module Pug
  module Worker
    module Script
      module Shell
        class Builder
          def initialize
            @cmds = []
          end

          def compile
            # TODO: shellwords
            @cmds.join "\n"
          end

          def cmd(data)
            @cmds << data
          end

          def cd(data)
            @cmds << "cd #{data}"
          end
        end
      end
    end
  end
end
