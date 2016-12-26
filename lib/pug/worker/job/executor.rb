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
          report_build_start
          result = nil

          vm.run do |container|
            container.store_file '~/build.sh', build_script
            container.exec ['chmod', '+x', '~/build.sh']

            result = container.exec(['/bin/bash', '-l', '~/build.sh']) do |stream, chunk|
              p "#{stream}: #{chunk}"
            end
          end

          report_build_result result
        end

        private

        def report_build_start
          report_build_status :started
        end

        def report_build_result(result)
          report_build_status build_status_for(result.last)
        end

        def report_build_status(status)
          status_reporter.publish build_identity.merge!(status: status)
        end

        def build_identity
          { id: build.id }
        end

        def build_status_for(status)
          case status
          when 0
            :passed
          else
            :failed
          end
        end

        def vm
          VM.for build.language
        end

        def build_script
          build.script || Script::Generator.new(build).generate
        end
      end
    end
  end
end
