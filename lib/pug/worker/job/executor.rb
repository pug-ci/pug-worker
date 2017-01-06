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

        def perform
          report_start
          result = perform_build
          report_result result
        end

        private

        def perform_build
          Builds::Runner.new(build).run
        end

        def report_start
          report_status :started
        end

        def report_result(result)
          report_status resolve_status(result)
        end

        def resolve_status(result)
          Builds::StatusResolver.new(result).resolve
        end

        def report_status(status)
          status_reporter.publish id: build.id, status: status
        end
      end
    end
  end
end
