module Pug
  module Worker
    module Job
      class ScriptExecutor
        attr_reader :container, :script

        def initialize(container, script)
          @container = container
          @script = script
        end

        def run
          upload_script
          exec_script
        end

        private

        def upload_script
          container.store_file '~/build.sh', script
          container.exec ['chmod', '+x', '~/build.sh']
        end

        def exec_script
          container.exec ['/bin/bash', '-l', '~/build.sh'], wait: timeout
        end

        def timeout
          Pug::Worker.configuration.build_timeout
        end
      end
    end
  end
end
