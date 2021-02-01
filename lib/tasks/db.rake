require 'dumpman'

namespace :db do
  config = File.open(
    if defined?(Rails)
      Rails
    elsif defined?(Hanami)
      binding.pry
      Hanami
    else

    end.root.join('config', 'initializers', 'dumpman.rb')
  ).read
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

  desc 'up LOCAL dump'
  task :up => :environment do
    Dumpman::Executor.rake(
      :restore,
      :migrate
    )
  end

  desc 'dumps the database'
  task :dump => :environment do
    Dumpman::Commandor.dump
  end

  desc 'restores the database'
  task :restore => :environment do
    Dumpman::Commandor.restore
  end

  desc 'dumps the database'
  task :ddrop => :environment do
    Dumpman::Commandor.drop_db
  end

  desc 'restores the database'
  task :dcreate => :environment do
    Dumpman::Commandor.create_db
  end
end
