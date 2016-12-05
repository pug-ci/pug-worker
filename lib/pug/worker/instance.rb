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

      attr_reader :build_channel, :build_subscription

      def subscribe_builds
        @build_channel = broker_connection.create_channel
        queue = build_channel.queue build_queue_name, durable: true
        @build_subscription = queue.subscribe build_subscription_options, &method(:process)
      end

      def build_subscription_options
        {
          block:      false,
          manual_ack: true,
          exclusive:  false
        }
      end

      def unsubscribe_builds
        build_subscription.cancel
        build_channel.close
      end

      def process(delivery_info, _metadata, payload)
        p "Instance worker ##{number} received message: #{payload}"
        executor = Job::Executor.new payload
        executor.perform

        if executor.success?
          build_channel.acknowledge delivery_info.delivery_tag, false
        else
          build_channel.reject delivery_info.delivery_tag, false
        end
      end
    end
  end
end
