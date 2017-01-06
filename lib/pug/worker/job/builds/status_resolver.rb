module Pug
  module Worker
    module Job
      module Builds
        class StatusResolver
          attr_reader :result

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

          private

          def status
            result.last
          end
        end
      end
    end
  end
end
