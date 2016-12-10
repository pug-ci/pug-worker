module Pug
  module Worker
    class Configuration
      attr_reader :pool_size, :broker_uri, :build_queue_name, :build_status_exchange_name

      def initialize(options = {})
        @pool_size        = options[:pool_size] || 3
        @broker_uri       = options[:broker_uri] || 'amqp://guest:guest@localhost:5672'

        @build_queue_name           = options[:build_queue_name] || 'pug.builds'
        @build_status_exchange_name = options[:build_status_exchange_name] || 'pug.builds.status'
      end
    end
  end
end
