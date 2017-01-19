module Pug
  module Worker
    module Job
      class Executor
        attr_reader :build, :status_reporter, :logs_reporter

        def initialize(payload, status_reporter, logs_reporter)
          @build = Build.new payload
          @status_reporter = status_reporter
          @logs_reporter = logs_reporter
        end

        def run
          report_start
          result = run_build
          report_result result
        end

        private

        def run_build
          BuildRunner.new(build).run
        end

        def report_start
          report_status :running
        end

        def report_result(result)
          report_status resolve_status(result)
        end

        def resolve_status(result)
          StatusResolver.new(result).resolve
        end

        def report_status(status)
          status_reporter.publish id: build.id, status: status
        end
      end
    end
  end
end
