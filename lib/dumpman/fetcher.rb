class Dumpman::Fetcher < Openstruct
  def self.fetch(connection_name)
    connection = Dumpman.connections.find do |connection|
      connection.name == connection_name
    end

    self.new(connection)
  end

  def fetch_remote_dump
    Dumpman::Executor.system(
      compress_dump_remotely,
      fetch_dump_to_local
    )
  end

  private

  def compress_dump_remotely
    "ssh #{server_name} RAILS_ENV=#{rails_env} rake db:compress"
  end

  def fetch_dump_to_local
    "scp #{server_name}:#{app_location}/#{Dumpman.dump_zip_name} #{Dumpman.dump_folder}/"
  end
end
