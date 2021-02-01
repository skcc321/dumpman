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
        instance.drop_cmd
      end

      def self.create_cmd
        instance.create_cmd
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
          @db_config ||= if defined?(ActiveRecord)
                           ActiveRecord::Base.connection_config
                         elsif defined?(Hanami::Model)
                           URI.parse(Hanami::Model.configuration.url)
                         elsif defined?(Mongoid)
                           URI.parse(Mongoid.configure.clients.dig("default", "uri")) ||
                             OpenStruct.new(Mongoid.configure.clients.dig("default"))
                         else
                           raise('unknown db configuration')
                         end
        end

        def database
          #                 Rails config           ||    Hanami/Mongoid config
          @database ||= db_config.fetch(:database) { db_config.fetch(:scheme) }
        end

        def username
          @username ||= db_config.fetch(:username) { db_config.fetch(:user) }
        end

        def password
          @password ||= db_config.fetch(:password) { raise("you should set password in 'database.yml'") }
        end

        def host
          @host ||= db_config.fetch(:host) { 'localhost' }
        end
    end
  end
end
