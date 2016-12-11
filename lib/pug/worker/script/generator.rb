module Pug
  module Worker
    module Script
      class Generator
        attr_reader :build

        def initialize(build)
          @build = build
        end

        def generate
          # TODO: run all stages
          shell.compile
        end

        private

        def shell
          @shell ||= Shell::Builder.new
        end
      end
    end
  end
end
