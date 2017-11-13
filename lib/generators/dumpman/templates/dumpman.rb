Dumpman.setup do
  # dump file name
  dump_file_name = "dumpman.sql"

  # :prod is uniq connection name
  define_source :prod do
    # rails env
    env 'production'

    # ssh command for connection to the server
    server 'deployer@157.122.77.55'

    # app path on the server
    path '~/application/current'
  end
end
