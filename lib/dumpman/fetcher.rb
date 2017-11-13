class Dumpman::Fetcher < OpenStruct
  def self.fetch(connection_name)
    connection = Dumpman.connections.find do |connection|
      connection.name == connection_name
    end

    instance = self.new(connection)
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
    "ssh #{server} RAILS_ENV=#{env} rake db:compress"
  end

  def fetch_dump_to_local
    "scp #{server}:#{path}/#{Dumpman.dump_zip_name} #{Dumpman.dump_folder}/"
  end
end
