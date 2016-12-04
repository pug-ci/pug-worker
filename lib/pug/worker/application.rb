module Pug
  module Worker
    class Application
      extend Forwardable

      attr_reader :configuration

      delegate pool_size: :configuration

      def initialize(options = {})
        @configuration = Configuration.new options
      end

      def configure
        yield configuration
      end

      def start
        pool.start
        sleep
      end

      def stop
        pool.stop
      end

      private

      def pool
        @pool ||= Pool.new pool_size
      end
    end
  end
end
