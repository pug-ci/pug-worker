require 'hashr'

module Pug
  module Worker
    class Configuration < Hashr
      extend Hashr::EnvDefaults

      self.env_namespace = 'pug_worker'.freeze

      define  daemonize: false,
              pool_size: 3,
              amqp: {
                username: 'guest',
                password: 'guest',
                host: 'localhost',
                port: 5672
              },
              builds_broker: {
                queue_name: 'pug.builds',
                status_exchange: 'pug.builds.status'
              },
              vm: {
                image_lookup: {
                  # ruby: 'polleverywhere/rbenv:latest'
                  ruby: 'adgud2/ruby-rvm:latest'
                }
              }
    end
  end
end
