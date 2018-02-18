module Dumpman
  module Adapters
    class Mysql < Base
      def dump_cmd
        "mysqldump #{options} > #{Dumpman.dump_file}"
      end

      def restore_cmd
        "mysql #{options} > #{Dumpman.dump_file}"
      end

      private

      def options_mapping
        {
          "-u" => username,
          "-p" => password,
          "-h" => host,
          "-d" => database,
        }
      end
    end
  end
end
