module Dumpman
  module Executor
    extend self

    def system(*commands)
      cmd = commands.join(' && ')
      puts("executing: #{cmd}")

      # execute & capture the result
      if block_given?
        # if success yield the result message
        yield %x[#{cmd}].strip if $?.success?
      else
        # return execution t/f
        Kernel.system(cmd)
      end
    end

    def rake(*commands)
      commands.each do |command|
        Rake::Task["db:#{command}"].reenable
        Rake::Task["db:#{command}"].invoke
      end
    end
  end
end
