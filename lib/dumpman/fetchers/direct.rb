module Dumpman
  module Fetchers
    # it triggers rake db:dump
    # inside app_path
    # and copies dump into tmp directory
    # after that it gets dump from remote server
    class Direct
      attr_reader :ssh_opts, :ssh_cmd, :app_path, :app_env

      def initialize(ssh_opts:, ssh_cmd:, app_path:, app_env:, **)
        @ssh_opts = ssh_opts
        @ssh_cmd = ssh_cmd
        @app_path = app_path
        @app_env = app_env
      end

      def get_dump
        Dumpman::Executor.system(make_dump_remotely) do |dump_location|
          Dumpman::Executor.system(fetch_dump_to_local(dump_location))
        end
      end

      private

        def make_dump_remotely
          <<~SSH_COMMAND
            ssh #{ssh_opts} #{ssh_cmd} '\
            export TEMP_DIR=$(mktemp -d)

            cd #{app_path} && \
            bash --login -c "RAILS_ENV=#{app_env} bundle exec rake db:dump \
            && cp #{Dumpman.dump_file_name} $TEMP_DIR/"

            echo $TEMP_DIR'
          SSH_COMMAND
        end

        def fetch_dump_to_local(dump_location)
          <<~SSH_COMMAND
            scp #{ssh_opts} #{ssh_cmd}:#{dump_location}/#{Dumpman.dump_file_name} \
            #{Dumpman.dump_folder}/"
          SSH_COMMAND
        end
    end
  end
end
