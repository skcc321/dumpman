# Dumpman
Dumpman gem is what you need if you have application somewhere and need to dump your DB download it and up that dump localy!

![alt text](https://s-media-cache-ak0.pinimg.com/originals/23/e6/df/23e6df3e2d857d3338c476094fe77fef.jpg)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dumpman', git: 'git@github.com:skcc321/dumpman.git'
```

Then execute:

    $ bundle

Or install it yourself as:

    $ gem install dumpman

Generate default config:

    $ rails g dumpman

Update app/config/initializers/dumpman.rb with propper settings.

## Usage

Now you are able to user awesome commands:

    $ rake db:prod:up
    $ rake db:stage:up
    $ rake db:qa:up
    ...

## Contributing

Bug reports and pull requests are welcome!

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
