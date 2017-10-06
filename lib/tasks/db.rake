require "zip"
require "pry"

namespace :db do
  desc "up QA dump"
  task :up_qa => :environment do
    Dumpman::Fetcher.fetch(:qa)
    Dumpman::Executor.rake(:up)
  end

  desc "up STAGE dump"
  task :up_stage => :environment do
    Dumpman::Fetcher.fetch(:stage)
    Dumpman::Executor.rake(:up)
  end

  desc "up PROD dump"
  task :up_prod => :environment do
    Dumpman::Fetcher.fetch(:prod)
    Dumpman::Executor.rake(:up)
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
    Dumpman::Compandor.zip
  end

  desc "unzips the database"
  task :extract => :environment do
    Dumpman::Compandor.zip
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
