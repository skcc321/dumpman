require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rake"
require "zlib"

Dir[File.join(File.dirname(__FILE__),'lib/tasks/*.rake')].each { |f| load f }

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
