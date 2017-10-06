module Dumpman::Executor
  def system(*commands)
    cmd = commands.joins(' && ')
    puts("executing: #{cmd}")
    system(cmd)
  end

  def rake(*commands)
    commands.each do |command|
      Rake::Task["db:#{command}"].reenable
      Rake::Task["db:#{command}"].invoke
    end
  end
end
