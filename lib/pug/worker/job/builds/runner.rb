module Pug
  module Worker
    module Job
      module Builds
        class Runner
          attr_reader :build

          def initialize(build)
            @build = build
          end

          def run
            result = nil

            vm.run do |container|
              container.store_file '~/build.sh', script
              container.exec ['chmod', '+x', '~/build.sh']

              result = container.exec(['/bin/bash', '-l', '~/build.sh'], wait: timeout) do |stream, chunk|
                p "#{stream}: #{chunk}"
              end
            end

            result
          end

          private

          def vm
            VM.for build.language
          end

          def script
            @script ||= build.script || generate_script
          end

          def generate_script
            Script::Generator.new(build).generate
          end

          def timeout
            Pug::Worker.configuration.build_timeout
          end
        end
      end
    end
  end
end
