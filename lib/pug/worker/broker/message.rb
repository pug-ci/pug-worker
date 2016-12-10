module Pug
  module Worker
    module Broker
      class Message
        extend Forwardable

        attr_reader :channel, :delivery_info, :payload

        def_delegators :delivery_info, :delivery_tag

        def initialize(channel, delivery_info, payload)
          @channel = channel
          @delivery_info = delivery_info
          @payload = parse_payload payload
        end

        def ack
          channel.acknowledge delivery_tag, false
        end

        def reject
          channel.reject delivery_tag, false
        end

        private

        def parse_payload(payload)
          JSON.parse payload, symbolize_names: true
        end
      end
    end
  end
end
