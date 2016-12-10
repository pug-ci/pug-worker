module Pug
  module Worker
    module Broker
      class Base
        attr_reader :connection

        def initialize(connection)
          @connection = connection
        end

        private

        def channel
          @channel ||= connection.create_channel
        end
      end
    end
  end
end
