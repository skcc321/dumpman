module Dumpman
  module Database
    def dump
      cmd = strategy.dump_cmd
      Dumpman::Executor.system(cmd)
    end

    def restore
      cmd = strategy.restore_cmd
      Dumpman::Executor.system(cmd)
    end

    def drop
      cmd = strategy.drop_cmd
      Dumpman::Executor.system(cmd)
    end

    def create
      cmd = strategy.create_cmd
      Dumpman::Executor.system(cmd)
    end

    def strategy
      case adapter
      when 'postgres', 'postgresql' then Dumpman::Adapters::Pg
      when 'mysql', 'mysql2' then Dumpman::Adapters::Mysql
      when 'mongo' then Dumpman::Adapters::Mongo
      else
        raise('unknown adapter in "config/database.yml"')
      end
    end

    def adapter
      if defined?(ActiveRecord)
        ActiveRecord::Base.connection_config.fetch(:adapter)
      elsif defined?(Hanami::Model)
        URI.parse(Hanami::Model.configuration.url).scheme
      elsif defined?(Mongoid)
       'mongo'
      else
        raise('unknown ORM/ODM adapter')
      end
    end

    module_function :dump,
      :restore,
      :drop,
      :create,
      :strategy,
      :adapter
  end
end
