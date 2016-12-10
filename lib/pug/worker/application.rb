require 'bunny'

module Pug
  module Worker
    class Application
      extend Forwardable

      attr_reader :configuration

      def_delegators :configuration, :broker_uri, :pool_size

      def initialize(options = {})
        @configuration = Configuration.new options
      end

      def configure
        yield configuration
      end

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
        @pool ||= Pool.new pool_size, instance_factory
      end

      def instance_factory
        @instance_factory ||= Factory.new broker_connection, configuration
      end

      def broker_connection
        @broker_connection ||= Bunny.new broker_uri
      end
    end
  end
end
