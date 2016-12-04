module Pug
  module Worker
    class Pool
      attr_reader :size

      def initialize(size)
        @size = size
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
        Array.new(size) { |instance_num| Instance.new instance_num }
      end
    end
  end
end
