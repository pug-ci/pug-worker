module Pug
  module Worker
    module Script
      module Stages
        class Base
          attr_reader :shell, :build

          def initialize(shell, build)
            @shell = shell
            @build = build
          end

          def apply
            raise NotImplementedError
          end
        end
      end
    end
  end
end
