module Pug
  module Worker
    module Broker
      class Subscriber < Base
        extend Forwardable

        attr_reader :queue_name

        delegate %i(acknowledge reject) => :channel

        def initialize(connection, queue_name)
          super connection
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

        def make_subscription
          queue.subscribe subscription_options do |delivery_info, _metadata, payload|
            yield Message.new(channel, delivery_info, payload)
          end
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
      end
    end
  end
end
