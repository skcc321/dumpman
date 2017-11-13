module Dumpman
  module Executor
    extend self

    def system(*commands)
      cmd = commands.join(' && ')
      puts("executing: #{cmd}")
      Kernel.system(cmd)
    end

    def rake(*commands)
      commands.each do |command|
        Rake::Task["db:#{command}"].reenable
        Rake::Task["db:#{command}"].invoke
      end
    end
  end
end
