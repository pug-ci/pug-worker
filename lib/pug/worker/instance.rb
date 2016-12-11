require 'celluloid/current'

module Pug
  module Worker
    class Instance
      include Celluloid

      attr_reader :number, :broker_connection

      def initialize(number, broker_connection)
        @number = number
        @broker_connection = broker_connection
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
        Job::Executor.new(message.payload, builds_status_reporter).perform
        message.ack
      end

      def builds_subscriber
        @builds_subscriber ||= Broker::Subscriber.new(
          broker_connection,
          configuration.builds_broker.queue_name
        )
      end

      def builds_status_reporter
        @builds_status_reporter ||= Broker::Reporter.new(
          broker_connection,
          configuration.builds_broker.status_exchange
        )
      end

      def configuration
        Pug::Worker.configuration
      end
    end
  end
end
