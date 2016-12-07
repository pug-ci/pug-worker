require 'timeout'

module Pug
  module Worker
    module VM
      class Runner
        attr_reader :image

        def initialize(image)
          @image = image
        end

        def run
          start
          yield container
        ensure
          stop
        end

        private

        def start
          p "Running VM with image: #{image.id}"
          container.start

          Timeout.timeout 10 do
            loop do
              break if container.json['State']['Running']
              sleep 1
            end
          end
        end

        def stop
          p 'Stopping VM'
          container.stop
          container.delete force: true
        end

        def container
          @container ||= Docker::Container.create container_options
        end

        def container_options
          { 'Image' => image.id }
        end
      end
    end
  end
end
