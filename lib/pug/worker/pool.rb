module Pug
  module Worker
    class Pool
      attr_reader :size, :instance_factory

      def initialize(size, instance_factory)
        @size = size
        @instance_factory = instance_factory
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
        Array.new(size) { |instance_num| instance_factory.create instance_num }
      end
    end
  end
end
