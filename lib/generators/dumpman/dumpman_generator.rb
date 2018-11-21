class DumpmanGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  desc 'This generator creates an dumpman config at config/initializers'
  def copy_initializer
    template 'dumpman.rb', 'config/initializers/dumpman.rb'
  end
end
