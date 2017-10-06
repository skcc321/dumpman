require "dumpman/version"
require "dumpman/railtie"

module Dumpman
  mattr_accessor :dump_folder
  mattr_accessor :dump_file_name
  mattr_accessor :db_config
  mattr_accessor :connections

  @@dump_folder = "."
  @@dump_file_name = "dumpman.sql"
  @@connections = []

  Struct.new('Connection', :name, :env, :server, :path)

  class << self
    def setup
      yield(self)
    end

    def connect
      connection = Connection.new
      connections << yield(connection)
    end

    def dump_file
      File.join(dump_folder, dump_file_name)
    end

    def dump_zip_name
      "#{dump_zip_name}.zip"
    end

    def dump_zip
      File.join(dump_folder, dump_zip_name)
    end

    def with_db_config
      db_config ||= ActiveRecord::Base.connection_config

      yield(
        db_config[:database],
        db_config[:username],
        db_config[:password],
        db_config[:host]
      )
    end
  end
end
