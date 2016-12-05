require 'bunny'

module Pug
  module Worker
    class Application
      extend Forwardable

      attr_reader :configuration

      delegate %i(broker_uri pool_size) => :configuration

      def initialize(options = {})
        @configuration = Configuration.new options
      end

      def configure
        yield configuration
      end

      def start
        pool.start
      end

      def stop
        pool.stop
      end

      private

      def pool
        @pool ||= Pool.new pool_size, instance_factory
      end

      def instance_factory
        @instance_factory ||= Factory.new broker_connection, configuration
      end

      def broker_connection
        @broker_connection ||= Bunny.new(broker_uri).start
      end
    end
  end
end
