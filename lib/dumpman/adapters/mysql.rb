module Dumpman
  module Adapters
    class Mysql < Base
      def dump_cmd
        if password.present?
          "mysqldump -u #{username} -p #{password} -h #{host} -d #{database} > #{Dumpman.dump_file}"
        else
          "mysqldump -u #{username} -h #{host} -d #{database} > #{Dumpman.dump_file}"
        end
      end

      def restore_cmd
        if password.present?
          "mysql -u #{username} -p #{password} -h #{host} #{database} < #{Dumpman.dump_file}"
        else
          "mysql -u #{username} -h #{host} #{database} < #{Dumpman.dump_file}"
        end
      end
    end
  end
end
