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
          container.start

          Timeout.timeout 10 do
            loop do
              break if running?
              sleep 1
            end
          end
        end

        def stop
          container.stop
          container.delete force: true
        end

        def running?
          container && container.json['State']['Running']
        end

        def container
          @container ||= Docker::Container.create container_options
        end

        def container_options
          {
            'Tty' => true, # TODO: this should be treated only as temporary solution
            'Image' => image.id
          }
        end
      end
    end
  end
end
