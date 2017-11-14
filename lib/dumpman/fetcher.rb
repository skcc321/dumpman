module Dumpman
  class Fetcher < OpenStruct
    def self.fetch(connection_name)
      connection = Dumpman.connections.find do |connection|
        connection.name == connection_name
      end

      instance = self.new(connection.attrs)
      instance.fetch_remote_dump
    end

    def fetch_remote_dump
      Dumpman::Executor.system(
        compress_dump_remotely,
        fetch_dump_to_local
      )
    end

    private

    def compress_dump_remotely
      "ssh #{ssh_opts} #{ssh_cmd} RAILS_ENV=#{app_env} rake db:compress"
    end

    def fetch_dump_to_local
      "scp #{ssh_opts} #{ssh_cmd}:#{path}/#{Dumpman.dump_zip_name} #{Dumpman.dump_folder}/"
    end
  end
end
