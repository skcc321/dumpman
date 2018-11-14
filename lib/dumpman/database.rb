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
      case ActiveRecord::Base.connection_config.fetch(:adapter)
      when 'postgresql' then Dumpman::Adapters::Pg
      when 'mysql', 'mysql2' then Dumpman::Adapters::Mysql
      else
        raise('unknown adapter in "config/database.yml"')
      end
    end

    module_function :dump,
      :restore,
      :drop,
      :create,
      :strategy
  end
end
