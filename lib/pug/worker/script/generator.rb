module Pug
  module Worker
    module Script
      class Generator
        attr_reader :build

        def initialize(build)
          @build = build
        end

        def generate
          apply_stages
          shell.compile
        end

        private

        def apply_stages
          Stages::Main.new(shell, build).apply
        end

        def shell
          @shell ||= Shell::Builder.new
        end
      end
    end
  end
end
