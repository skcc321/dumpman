module Dumpman::Commandor
  extend self

  def zip
    # clean up from old dump
    File.delete(Dumpman.dump_zip) if File.exists?(Dumpman.dump_zip)

    Zip::File.open(Dumpman.dump_zip, Zip::File::CREATE) do |zipfile|
      zipfile.add(Dumpman.dump_file_name, Dumpman.dump_folder + '/' + Dumpman.dump_file_name)
    end
  end

  def unzip
    # clean up from old zip
    File.delete(Dumpman.dump_file) if File.exists?(Dumpman.dump_file)

    Zip::File.open(Dumpman.dump_zip) do |zip_file|
      zip_file.each do |entry|
        puts "Extracting #{entry.name}"
        entry.extract(Dumpman.dump_file)
      end
    end
  end

  def dump
    Dumpman.with_db_config do |database, username, password, host|
      cmd = "PGPASSWORD=#{password} pg_dump --username #{username} --verbose --clean --no-owner --no-acl --format=c #{database} > #{Dumpman.dump_file} -h #{host}"
      Dumpman::Executor.system(cmd)
    end
  end

  def restore
    Dumpman.with_db_config do |database, username, password, host|
      cmd = "PGPASSWORD=#{password} pg_restore --verbose --username #{username} --clean --no-owner --no-acl --dbname #{database} #{Dumpman.dump_file} -h #{host}"
      Dumpman::Executor.rake(:drop, :create)
      Dumpman::Executor.system(cmd)
    end
  end
end
