[travis]: https://travis-ci.org/pug-ci/pug-worker
[codeclimate]: https://codeclimate.com/github/pug-ci/pug-worker

# Pug::Worker

[![Build Status](https://travis-ci.org/pug-ci/pug-worker.svg?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/pug-ci/pug-worker/badges/gpa.svg)][codeclimate]

Spawns pool of worker instances responsible for processing builds securely inside Docker containers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pug-worker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pug-worker

## Usage

TODO: Write usage instructions

## Docker

You can use both docker and docker-compose with this project, in order to run tests, integration tests or a sample worker pool without setting up RabbitMQ in your local development environment.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pug-worker.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
