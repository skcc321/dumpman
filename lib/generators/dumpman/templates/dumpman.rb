Dumpman.setup do
  # dump file name
  dump_file_name 'dumpman.sql'

  # :prod is uniq connection name
  define_source :prod do
    # application environment (RAILS_ENV)
    app_env 'production'

    # ssh command for connection to the remote server
    ssh_cmd 'root@192.168.1.1'

    # ssh options for connection to the remote server
    # example:
    # ssh_opts '-i ~/.ssh/sertificate.pem'

    # app path on the remote server
    app_path '~/application/current'
  end
end
