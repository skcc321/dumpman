module Dumpman
  module Adapters
    class Base
      include Singleton

      def self.dump_cmd
        instance.dump_cmd
      end

      def self.restore_cmd
        instance.restore_cmd
      end

      def self.drop_cmd
        instance.dump_cmd
      end

      def self.create_cmd
        instance.restore_cmd
      end

      def dump_cmd
        raise(NotImplementedError)
      end

      def restore_cmd
        raise(NotImplementedError)
      end

      def drop_cmd
        raise(NotImplementedError)
      end

      def create_cmd
        raise(NotImplementedError)
      end

      private

        def db_config
          @db_config ||= ActiveRecord::Base.connection_config
        end

        def database
          @database ||= db_config.fetch(:database)
        end

        def username
          @username ||= db_config.fetch(:username)
        end

        def password
          @password ||= db_config.fetch(:password)
        end

        def host
          @host ||= db_config.fetch(:host)
        end
    end
  end
end
