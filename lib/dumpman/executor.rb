module Dumpman
  module Executor
    extend self

    def system(*commands)
      cmd = commands.join(' && ')
      info(cmd)

      # execute & capture the result
      if block_given?
        # if success yield the result message
        result = %x[#{cmd}].strip
        yield result if $?.success?
      else
        # return execution t/f
        result = Kernel.system(cmd)
      end
    end

    def rake(*commands)
      commands.each do |command|
        Rake::Task["db:#{command}"].reenable
        Rake::Task["db:#{command}"].invoke
      end
    end

    def info(cmd)
      puts 'EXECUTING:'

      puts cmd.gsub(/(\s{2})/, '\1')
          .split(/\n/)
          .map { |x| x.squeeze(' ') }
          .reject(&:blank?)
    end
  end
end
