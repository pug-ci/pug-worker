module Pug
  module Worker
    module Broker
      class Subscriber
        extend Forwardable

        attr_reader :connection, :queue_name

        delegate %i(acknowledge reject) => :channel

        def initialize(connection, queue_name)
          @connection = connection
          @queue_name = queue_name
        end

        def subscribe(&block)
          @subscription = make_subscription(&block)
        end

        def unsubscribe
          @subscription.cancel
          channel.close
        end

        private

        def make_subscription(&block)
          queue.subscribe subscription_options, &block
        end

        def subscription_options
          {
            block:      false,
            manual_ack: true,
            exclusive:  false
          }
        end

        def queue
          @queue ||= channel.queue queue_name, queue_options
        end

        def queue_options
          { durable: true }
        end

        def channel
          @channel ||= connection.create_channel
        end
      end
    end
  end
end
