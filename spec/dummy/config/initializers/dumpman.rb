Dumpman.setup do
  # dump file name
  dump_file_name "dumpman-test.sql"

  # :prod is uniq connection name
  define_source :qa do
    # app env (RAILS_ENV)
    app_env 'qa'

    # ssh command for connection to the server
    ssh_cmd 'overhaul@54.172.149.43'

    # ssh command opptions
    ssh_opts '-i ~/.ssh/overhaul.pem'

    # app path on the server
    app_path '/opt/overhaul-backend/current'
  end
end
