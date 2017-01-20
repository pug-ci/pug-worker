module Pug
  module Worker
    module Job
      class Executor
        include Logging::Methods

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
          report status: :running
        end

        def report_result(result)
          status = resolve_status result
          report status: status, duration: result.duration
        end

        def resolve_status(result)
          StatusResolver.new(result).resolve
        end

        def report(params)
          report_data = build_identity.merge! params
          info :build_execution, report_data
          status_reporter.publish report_data
        end

        def build_identity
          { id: build.id }
        end
      end
    end
  end
end
