module Dumpman
  module Adapters
    class Mysql < Base
      def dump_cmd
        "MYSQL_PWD='#{password}' mysqldump -u #{username} -h #{host} #{database} | gzip -9 > #{Dumpman.dump_file}"
      end

      def restore_cmd
        "gunzip < #{Dumpman.dump_file} | MYSQL_PWD='#{password}' mysql -u #{username} -h #{host} #{database}"
      end

      def drop_cmd
        "MYSQL_PWD='#{password}' mysql -u #{username} -h #{host} -e 'drop database #{database}'"
      end

      def create_cmd
        "MYSQL_PWD='#{password}' mysql -u #{username} -h #{host} -e 'create database #{database}'"
      end
    end
  end
end
