module Pug
  module Worker
    class Configuration
      attr_reader :pool_size

      def initialize(options = {})
        @pool_size = options[:pool_size] || 3
      end
    end
  end
end
