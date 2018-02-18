module Dumpman
  module Adapters
    class Base
      include Singleton

      def self.dump_cmd
        instance.dump_cmd
      end

      def self.restore_cmd
        instance.dump_cmd
      end

      def dump_cmd
        raise(NotImplementedError)
      end

      def restore_cmd
        raise(NotImplementedError)
      end

      def options_mapping
        raise(NotImplementedError)
      end

      private

        def options
          options_mapping.inject("") do |memo, (key, value)|
            memo += " #{key} #{value}" if value.present?
            memo
          end
        end

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
