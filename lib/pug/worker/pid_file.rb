module Pug
  module Worker
    class PidFile
      attr_reader :path

      def initialize(path)
        @path = path
      end

      def create(pid)
        File.write path, pid
      end

      def delete
        File.delete path
      end
    end
  end
end
