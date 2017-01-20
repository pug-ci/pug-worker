module Pug
  module Worker
    module Job
      class Result
        attr_reader :output, :metrics

        def initialize(output, metrics = {})
          @output = output
          @metrics = metrics
        end

        def status
          output.last
        end

        def duration
          metrics[:duration]
        end
      end
    end
  end
end
