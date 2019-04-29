require 'simplecov'
SimpleCov.start

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require File.expand_path('../../spec/dummy/config/environment.rb', __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path('../../spec/dummy/db/migrate', __FILE__)]
require 'bundler/setup'
require 'dumpman'
require 'pry-byebug'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:example) do
    File.delete(Dumpman.dump_archive_name) if File.exists?(Dumpman.dump_archive_name)
    File.delete(Dumpman.dump_file_name) if File.exists?(Dumpman.dump_file_name)

    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
  end

  config.after(:example) do
    File.delete(Dumpman.dump_archive_name) if File.exists?(Dumpman.dump_archive_name)
    File.delete(Dumpman.dump_file_name) if File.exists?(Dumpman.dump_file_name)
  end
end

Rails.application.load_tasks
