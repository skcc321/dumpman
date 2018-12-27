[![Build Status](https://travis-ci.org/skcc321/dumpman.svg?branch=master)](https://travis-ci.org/skcc321/dumpman)
[![Maintainability](https://api.codeclimate.com/v1/badges/3f69b1bb862be2a7e6ce/maintainability)](https://codeclimate.com/github/skcc321/dumpman/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/3f69b1bb862be2a7e6ce/test_coverage)](https://codeclimate.com/github/skcc321/dumpman/test_coverage)

# Dumpman
Dumpman gem is what you need if you have application somewhere and need to dump your DB download it and up that dump localy!

### use case:
You have staging OR production server with running rails app on it.

For some reason you need DB dump from that server.

What you can do?
- Solution 1: connect to that server, make dump via CLI, download it, extract it on your loacl machine
- Solution 2: install this gem and run ```bash rake db:prod:up``` and that's it.

![alt text](https://farm8.staticflickr.com/7347/10602023975_fd3e5b61b7_b.jpg)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dumpman'
```

Then execute:

    $ bundle

Or install it yourself as:

    $ gem install dumpman

Generate default config:

    $ rails g dumpman
    
it will create file app/config/initializers/dumpman.rb
```ruby
Dumpman.setup do
  # dump file name
  dump_file_name "dumpman.sql"

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
```

Update app/config/initializers/dumpman.rb with propper settings.

## Usage

Now you are able to use awesome commands:

    $ rake db:prod:up # makes db dump on that server, compreses it with ZIP, downloads, extracts localy 
    $ rake db:stage:up
    $ rake db:qa:up
    ...

## Contributing

Bug reports and pull requests are welcome!

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
