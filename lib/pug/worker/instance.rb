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
        p "Subscribing"
        builds_subscriber.subscribe(&method(:process))
      end

      def unsubscribe_builds
        p "Unsubscribing"
        builds_subscriber.unsubscribe
      end

      def builds_subscriber
        @builds_subscriber ||= Broker::Subscriber.new(
          broker_connection,
          configuration.builds_broker.queue_name
        )
      end

      def status_reporter
        @status_reporter ||= Broker::Publisher.new(
          broker_connection,
          configuration.builds_broker.status_exchange
        )
      end

      def logs_reporter
        @logs_reporter ||= Broker::Publisher.new(
          broker_connection,
          configuration.builds_broker.logs_exchange
        )
      end

      def process(message)
        p "Starting request processing"
        Job::Executor.new(message.payload, status_reporter, logs_reporter).perform
        message.ack
      end

      def configuration
        Pug::Worker.configuration
      end
    end
  end
end
