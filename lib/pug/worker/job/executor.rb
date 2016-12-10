module Pug
  module Worker
    module Job
      class Executor
        attr_reader :payload, :reporter

        def initialize(payload, reporter)
          @payload = payload
          @reporter = reporter
        end

        def perform
          reporter.publish 'build:started', 'build started'

          vm.run do |container|
            container.store_file '~/build.sh', build_script

            container.exec ['chmod', '+x', '~/build.sh']
            p container.exec ['bash', '~/build.sh']
          end

          reporter.publish 'build:finished', 'build finished'

          @success = true
        end

        def success?
          @success
        end

        private

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
