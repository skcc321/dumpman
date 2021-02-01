module Dumpman
  module Adapters
    class Mongo < Base
      def dump_cmd
        "PGPASSWORD='#{password}' pg_dump -h #{host} --username '#{username}' --verbose --clean --no-owner --no-acl -Z4 -Fc #{database} > '#{Dumpman.dump_file}'"
      end

      def restore_cmd
        "PGPASSWORD='#{password}' pg_restore -h #{host} --username '#{username}' --verbose --clean --no-owner --no-acl -j 4 -d #{database} '#{Dumpman.dump_file}'"
      end

      def drop_cmd
        "PGPASSWORD='#{password}' dropdb -h #{host} --username '#{username}' #{database}"
      end

      def create_cmd
        "PGPASSWORD='#{password}' createdb -h #{host} --username '#{username}' #{database}"
      end

      def uri?
        URI.parse(Mongoid.configure.clients.dig("default", "uri")).present?
      end
    end
  end
end
