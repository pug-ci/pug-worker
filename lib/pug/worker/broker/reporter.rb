module Pug
  module Worker
    module Broker
      class Reporter < Base
        attr_reader :exchange_name

        def initialize(connection, exchange_name)
          super connection
          @exchange_name = exchange_name
        end

        def publish(event, message)
          options = { properties: { type: event } }
          exchange.publish message, options
        end

        private

        def exchange
          @exchange ||= channel.exchange exchange_name, exchange_options
        end

        def exchange_options
          {
            type:    :topic,
            durable: true
          }
        end
      end
    end
  end
end
