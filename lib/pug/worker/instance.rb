require 'celluloid/current'

module Pug
  module Worker
    class Instance
      include Celluloid

      attr_reader :number

      def initialize(number)
        @number = number
      end

      def start
        p "Starting instance worker ##{number}"
      end

      def stop
        p "Stopping instance worker ##{number}"
      end
    end
  end
end
