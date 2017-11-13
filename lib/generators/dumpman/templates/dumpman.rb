Dumpman.setup do |config|
  # dump file name
  config.dump_file_name = "dumpman.sql"

  # :prod is uniq connection name
  config.connect :prod do |connection|
    # rails env
    connection.env = 'production'

    # ssh command for connection to the server
    connection.server = 'deployer@157.122.77.55'

    # app path on the server
    connection.path = '~/application/current'
  end
end
