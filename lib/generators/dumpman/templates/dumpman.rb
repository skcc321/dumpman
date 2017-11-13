Dumpman.setup do |config|
  config.dump_file_name = "dumpman.sql"

  config.connect do |connection|
    connection.name = 'prod'
    connection.env = 'production'
    connection.server = 'deployer@157.122.77.55'
    connection.path = '~/application/current'
  end
end
