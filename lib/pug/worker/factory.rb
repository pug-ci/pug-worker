module Pug
  module Worker
    class Factory
      attr_reader :broker_connection

      def initialize(broker_connection)
        @broker_connection = broker_connection
      end

      def create
        Instance.new broker_connection
      end
    end
  end
end
