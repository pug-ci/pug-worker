module Pug
  module Worker
    module Script
      module Stages
        class Main < Base
          def apply
            Stages::ORDERED.each do |stage_class|
              stage_class.new(shell, build).apply
            end
          end
        end
      end
    end
  end
end
