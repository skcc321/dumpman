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
    ssh_opts '-i ~/.ssh/sertificate.pem'

    # fetch strategy
    # if you are using capistrano or other deployment methods
    # where you have direct access to filesystem where the application code is located
    # you should use :direct strategy
    fetch_strategy :direct
    # if your application is running under the docker you can use :docker strategy

    # if you selected :docker as fetch_strategy
    # you have to set docker_image as well
    # docker_image "645843940509.dkr.ecr.us-east-1.amazonaws.com/oh-snowflake"

    # if you selected :direct as fetch strategy
    # please set
    # app path on the remote server
    app_path '~/application/current'
  end
end
