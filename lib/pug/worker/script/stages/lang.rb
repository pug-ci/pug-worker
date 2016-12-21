module Pug
  module Worker
    module Script
      module Stages
        class Lang < Base
          def apply
            lang_stage.apply
          end

          private

          def lang_stage
            Langs.stage_for(lang).new shell, build
          end

          def lang
            build.language
          end
        end
      end
    end
  end
end
