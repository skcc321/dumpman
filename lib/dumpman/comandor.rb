require "zlib"

module Dumpman
  module Commandor
    extend self

    def archive
      # clean up from old dump
      File.delete(Dumpman.dump_archive) if File.exists?(Dumpman.dump_archive)

      Zlib::GzipWriter.open(Dumpman.dump_archive, 9) do |gz|
        gz.write(Dumpman.dump_file_name)
      end
    end

    def unarchive
      # clean up from old archive
      File.delete(Dumpman.dump_file) if File.exists?(Dumpman.dump_file)

      Zlib::GzipReader.open(Dumpman.dump_archive) do |gz|
        puts "Extracting #{Dumpman.dump_file}"

        File.write(Dumpman.dump_file, gz.read)
      end
    end

    def dump
      Dumpman::Database.dump
    end

    def restore
      Dumpman::Database.drop
      Dumpman::Database.create
      Dumpman::Database.restore
    end

    def drop_db
      Dumpman::Database.drop
    end

    def create_db
      Dumpman::Database.create
    end
  end
end
