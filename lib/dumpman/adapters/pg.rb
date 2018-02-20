module Dumpman
  module Adapters
    class Pg < Base
      def dump_cmd
        "PGPASSWORD=#{password} pg_dump -h #{host} --username #{username} --verbose --clean --no-owner --no-acl --format=c #{database} > '#{Dumpman.dump_file}'"
      end

      def restore_cmd
        "PGPASSWORD=#{password} pg_restore  -h #{host} --verbose --username #{username} --clean --no-owner --no-acl -d #{database} '#{Dumpman.dump_file}'"
      end
    end
  end
end
