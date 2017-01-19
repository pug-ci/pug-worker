module Pug
  module Worker
    module Job
      class Result
        attr_reader :output

        def initialize(output)
          @output = output
        end

        def status
          output.last
        end
      end
    end
  end
end
