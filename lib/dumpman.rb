require "dumpman/connection"
require "dumpman/comandor"
require "dumpman/executor"
require "dumpman/fetcher"
require "dumpman/railtie"
require "dumpman/version"

module Dumpman
  mattr_accessor :dump_folder
  mattr_accessor :dump_file_name
  mattr_accessor :db_config
  mattr_accessor :connections

  @@dump_folder = "."
  @@dump_file_name = "dumpman.sql"
  @@connections = []

  class << self
    def setup(&block)
      self.instance_eval(&block)
    end

    def connection_names
      connections.map(&:name)
    end

    def define_source(name, &block)
      connection = Dumpman::Connection.new(name)
      connection.instance_eval(&block)
      connections << connection
    end

    def dump_file
      File.join(dump_folder, dump_file_name)
    end

    def dump_zip_name
      "#{dump_file_name}.zip"
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
