module Pug
  module Worker
    module Job
      class BuildRunner
        attr_reader :build

        def initialize(build)
          @build = build
        end

        def run
          vm.run do |container|
            start_time = Time.now
            output = ScriptExecutor.new(container, script).run
            duration = Time.now - start_time

            Result.new output, duration: duration
          end
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
      end
    end
  end
end
