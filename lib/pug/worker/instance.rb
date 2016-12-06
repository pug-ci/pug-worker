require 'celluloid/current'

module Pug
  module Worker
    class Instance
      extend  Forwardable
      include Celluloid

      attr_reader :number, :broker_connection, :configuration

      delegate build_queue_name: :configuration

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

      def builds_subscriber
        @builds_subscriber ||= Broker::Subscriber.new broker_connection, build_queue_name
      end

      def process(delivery_info, _metadata, payload)
        p "Instance worker ##{number} received message: #{payload}"
        executor = Job::Executor.new payload
        executor.perform

        if executor.success?
          builds_subscriber.acknowledge delivery_info.delivery_tag, false
        else
          builds_subscriber.reject delivery_info.delivery_tag, false
        end
      end
    end
  end
end
