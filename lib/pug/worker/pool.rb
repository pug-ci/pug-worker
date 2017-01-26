module Pug
  module Worker
    class Pool
      attr_reader :size, :broker_connection

      def initialize(size, broker_connection)
        @size = size
        @broker_connection = broker_connection
      end

      def start
        each_instance :start
      end

      def stop
        each_instance :stop
      end

      private

      def each_instance(method)
        instances.each { |instance| instance.send method }
      end

      def instances
        @instances ||= spawn_instances
      end

      def spawn_instances
        Array.new(size) { Instance.new broker_connection }
      end
    end
  end
end
