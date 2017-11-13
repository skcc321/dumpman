Dumpman.setup do |config|
  config.dump_file_name = "overhaul-backend.sql"

  config.connect do |connection|
    connection.name = 'qa'
    connection.env = 'qa_aws'
    connection.server = 'qa'
    connection.path = '/opt/overhaul-backend/current'
  end

  config.connect do |connection|
    connection.name = 'prod'
    connection.env = 'production_aws'
    connection.server = 'app1'
    connection.path = '/opt/overhaul-backend/current'
  end

  config.connect do |connection|
    connection.name = 'stage'
    connection.env = 'staging'
    connection.server = 'stage'
    connection.path = '/opt/overhaul-backend/current'
  end
end
