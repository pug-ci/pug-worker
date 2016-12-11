require 'hashr'

module Pug
  module Worker
    class Configuration < Hashr
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
                  ruby: 'polleverywhere/rbenv:latest'
                }
              }
    end
  end
end
