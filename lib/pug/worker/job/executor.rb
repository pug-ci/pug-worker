module Pug
  module Worker
    module Job
      class Executor
        attr_reader :payload, :status_reporter

        def initialize(payload, status_reporter)
          @payload = payload
          @status_reporter = status_reporter
        end

        def perform
          report_build_start
          result = nil

          vm.run do |container|
            container.store_file '~/build.sh', build_script
            container.exec ['chmod', '+x', '~/build.sh']

            result = container.exec ['bash', '~/build.sh']
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
          { id: payload[:id] }
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
          # TODO: get image tag from payload
          VM.for 'polleverywhere/rbenv:latest'
        end

        def build_script
          payload[:build_script]
        end
      end
    end
  end
end
