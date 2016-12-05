module Pug
  module Worker
    class Factory
      attr_reader :broker_connection, :configuration

      def initialize(broker_connection, configuration)
        @broker_connection = broker_connection
        @configuration = configuration
      end

      def create(instance_num)
        Instance.new instance_num, broker_connection, configuration
      end
    end
  end
end
