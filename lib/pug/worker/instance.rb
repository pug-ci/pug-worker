require 'securerandom'
require 'celluloid/current'

module Pug
  module Worker
    class Instance
      include Celluloid
      include Logging::Methods

      attr_reader :id, :broker_connection

      def initialize(broker_connection)
        @id = generate_id
        @broker_connection = broker_connection
      end

      def start
        log_status :started
        subscribe_builds
      end

      def stop
        log_status :stopped
        unsubscribe_builds
      end

      private

      def generate_id
        SecureRandom.hex 10
      end

      def log_status(status)
        info :instance_state, status: status, id: id
      end

      def subscribe_builds
        builds_subscriber.subscribe(&method(:process))
      end

      def unsubscribe_builds
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
        Job::Executor.new(message.payload, status_reporter, logs_reporter).run
        message.ack
      end

      def configuration
        Pug::Worker.configuration
      end
    end
  end
end
