module Pug
  module Worker
    module Job
      class Executor
        attr_reader :payload

        def initialize(payload)
          @payload = payload
        end

        def perform
          vm.run do |_container|
            sleep 2
          end

          @success = true
        end

        def success?
          @success
        end

        def vm
          # TODO: get image tag from payload
          VM.for 'polleverywhere/rbenv'
        end
      end
    end
  end
end
