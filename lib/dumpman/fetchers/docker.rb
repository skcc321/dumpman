module Dumpman
  module Fetchers
    # it runs docker task to make dump
    # copies dump into tmp dir
    # and retrieves dump to local machine
    class Docker
      attr_reader :ssh_opts, :ssh_cmd, :docker_image, :app_env

      def initialize(ssh_opts:, ssh_cmd:, docker_image:, app_env:, **)
        @ssh_opts = ssh_opts
        @ssh_cmd = ssh_cmd
        @docker_image = docker_image
        @app_env = app_env
      end

      def get_dump
        Dumpman::Executor.system(make_dump_remotely) do |dump_location|
          Dumpman::Executor.system(fetch_dump_to_local(dump_location))
        end
      end

      def make_dump_remotely
        <<~SSH_COMMAND
          ssh #{ssh_opts} #{ssh_cmd} '
            export TEMP_DIR=$(mktemp -d)
            export DOCKER_IMAGE=$(docker images #{docker_image} --format "{{.ID}}" | head -1)

            docker run -d \
              --name pgdmp \
              --rm \
              -e RAILS_ENV=#{app_env} \
              -v ${TEMP_DIR}:/opt \
              -u root \
              ${DOCKER_IMAGE} /bin/bash -c \
                "bundle exec rake db:dump && cp #{Dumpman.dump_file_name} /opt/ && exit" > /dev/null

            docker wait pgdmp >/dev/null

            echo $TEMP_DIR
          '
        SSH_COMMAND
      end

      def fetch_dump_to_local(dump_location)
        <<~SSH_COMMAND
          scp #{ssh_opts} #{ssh_cmd}:#{dump_location}/#{Dumpman.dump_file_name} \
            #{Dumpman.dump_folder}/
        SSH_COMMAND
      end
    end
  end
end
