module Dumpman
  module Adapters
    class Mysql < Base
      def dump_cmd
        "MYSQL_PWD=#{password} mysqldump -u #{username} -h #{host} #{database} > #{Dumpman.dump_file}"
      end

      def restore_cmd
        "MYSQL_PWD=#{password} mysql -u #{username} -h #{host} #{database} < #{Dumpman.dump_file}"
      end
    end
  end
end
