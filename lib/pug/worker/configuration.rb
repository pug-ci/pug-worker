module Pug
  module Worker
    class Configuration
      DEFAULTS = {
        daemonize:            false,
        pool_size:            3,
        broker_uri:           'amqp://guest:guest@localhost:5672',
        builds_broker:        { queue_name: 'pug.builds' },
        builds_status_broker: { exchange_name: 'pug.builds.status' }
      }.freeze

      attr_accessor :pid_path, :daemonize, :pool_size, :broker_uri,
                    :builds_broker, :builds_status_broker

      alias_method :daemonize?, :daemonize

      def initialize(options = {})
        apply DEFAULTS.merge(options)
      end

      private

      def apply(options)
        options.each_pair do |option, value|
          send "#{option}=", value
        end
      end
    end
  end
end
