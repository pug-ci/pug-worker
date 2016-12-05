module Pug
  module Worker
    module Job
      class Executor
        attr_reader :payload

        def initialize(payload)
          @payload = payload
        end

        def perform
          sleep 2
          @success = true
        end

        def success?
          @success
        end
      end
    end
  end
end
