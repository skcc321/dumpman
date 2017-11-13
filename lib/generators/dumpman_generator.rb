class DumpmanGenerator < Rails::Generators::Base
  source_root File.join(File.expand_path(File.dirname(__FILE__)), '../templates')

  desc "This generator creates an dumpman config at config/initializers"
  def create_dumpman_config
    template 'dumpman.rb', 'config/initializers/dumpman.rb'
  end
end
