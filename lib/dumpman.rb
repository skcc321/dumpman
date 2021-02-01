require 'dumpman/connection'
require 'dumpman/database'
require 'dumpman/adapters/base'
require 'dumpman/adapters/pg'
require 'dumpman/adapters/mysql'
require 'dumpman/comandor'
require 'dumpman/executor'
require 'dumpman/fetchers/direct'
require 'dumpman/fetchers/docker'
require 'dumpman/fetcher'
require 'dumpman/version'

if defined?(Rails)
  require 'dumpman/railtie'
end

module Dumpman
  attr_accessor :connections

  @@dump_folder = '.'
  @@dump_file_name = 'dumpman.sql.gz'
  @@connections = []

  class << self
    def setup(&block)
      self.instance_eval(&block)
    end

    def dump_file_name(val = nil)
      return @@dump_file_name unless val.present?
      @@dump_file_name = val
    end

    def dump_folder(val = nil)
      return @@dump_folder unless val.present?
      @@dump_folder = val
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
  end
end
