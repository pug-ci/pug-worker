require 'bunny'

module Pug
  module Worker
    class Application
      def start
        broker_connection.start
        pool.start
      end

      def stop
        pool.stop
        broker_connection.close
      end

      private

      def pool
        @pool ||= Pool.new configuration.pool_size, instance_factory
      end

      def instance_factory
        @instance_factory ||= Factory.new broker_connection
      end

      def broker_connection
        @broker_connection ||= Bunny.new configuration.amqp
      end

      def configuration
        Pug::Worker.configuration
      end
    end
  end
end
