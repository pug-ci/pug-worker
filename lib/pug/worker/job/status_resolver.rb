module Pug
  module Worker
    module Job
      class StatusResolver
        extend Forwardable

        attr_reader :result

        def_delegators :result, :status

        def initialize(result)
          @result = result
        end

        def resolve
          case status
          when 0
            :passed
          else
            :failed
          end
        end
      end
    end
  end
end
