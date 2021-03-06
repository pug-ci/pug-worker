require 'timeout'
require 'bunny'

module Pug
  module Worker
    class Application
      def start
        start_broker_connection
        pool.start
      end

      def stop
        pool.stop
        broker_connection.close
      end

      private

      def start_broker_connection
        Timeout.timeout 10 do
          begin
            broker_connection.start
          rescue Bunny::TCPConnectionFailed
            sleep 1
            retry
          end
        end
      end

      def broker_connection
        @broker_connection ||= Bunny.new configuration.amqp
      end

      def pool
        @pool ||= Pool.new configuration.pool_size, broker_connection
      end

      def configuration
        Pug::Worker.configuration
      end
    end
  end
end
