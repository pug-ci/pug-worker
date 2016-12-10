require 'celluloid/current'

module Pug
  module Worker
    class Instance
      extend  Forwardable
      include Celluloid

      attr_reader :number, :broker_connection, :configuration

      def_delegators :configuration, :build_queue_name, :build_status_exchange_name

      def initialize(number, broker_connection, configuration)
        @number = number
        @broker_connection = broker_connection
        @configuration = configuration
      end

      def start
        p "Starting instance worker ##{number}"
        subscribe_builds
      end

      def stop
        p "Stopping instance worker ##{number}"
        unsubscribe_builds
      end

      private

      def subscribe_builds
        builds_subscriber.subscribe(&method(:process))
      end

      def unsubscribe_builds
        builds_subscriber.unsubscribe
      end

      def process(message)
        executor = Job::Executor.new message.payload, builds_status_reporter
        executor.perform

        executor.success? ? message.ack : message.reject
      end

      def builds_subscriber
        @builds_subscriber ||= Broker::Subscriber.new broker_connection, build_queue_name
      end

      def builds_status_reporter
        @builds_status_reporter ||= Broker::Reporter.new broker_connection, build_status_exchange_name
      end
    end
  end
end
