require "zip"
require "dumpman"

namespace :db do
  config = File.open(Rails.root.join('config', 'initializers', 'dumpman.rb')).read
  eval(config)

  Dumpman.connection_names.each do |name|
    namespace name do
      desc "up #{name} dump"
      task :up => :environment do
        Dumpman::Fetcher.fetch(name)
        Dumpman::Executor.rake(:up)
      end
    end
  end

  desc "up LOCAL dump"
  task :up => :environment do
    Dumpman::Executor.rake(
      :drop,
      :create,
      :extract,
      :migrate
    )
  end

  desc "zips the database"
  task :compress => :environment do
    Dumpman::Commandor.dump
    Dumpman::Commandor.zip
  end

  desc "unzips the database"
  task :extract => :environment do
    Dumpman::Commandor.unzip
    Dumpman::Commandor.restore
  end

  desc "dumps the database"
  task :dump => :environment do
    Dumpman::Commandor.dump
  end

  desc "restores the database"
  task :restore => :environment do
    Dumpman::Commandor.restore
  end
end
