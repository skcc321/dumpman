module Dumpman
  module Adapters
    class Mysql < Base
      def dump_cmd
        "mysqldump -u #{username} -p #{password} -h #{host} -d #{database} > #{Dumpman.dump_file}"
      end

      def restore_cmd
        "mysql -u #{username} -p #{password} -h #{host} #{database} < #{Dumpman.dump_file}"
      end
    end
  end
end
