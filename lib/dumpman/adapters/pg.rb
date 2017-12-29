module Dumpman
  module Adapters
    class Pg < Base
      def dump_cmd
        "PGPASSWORD=#{password} pg_dump --username #{username} --verbose --clean --no-owner --no-acl --format=c #{database} > #{Dumpman.dump_file} -h #{host}"
      end

      def restore_cmd
        "PGPASSWORD=#{password} pg_restore --verbose --username #{username} --clean --no-owner --no-acl --dbname #{database} #{Dumpman.dump_file} -h #{host}"
      end
    end
  end
end
