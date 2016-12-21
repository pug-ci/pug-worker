require 'pug/worker/script/stages/langs/base'

module Pug
  module Worker
    module Script
      module Stages
        module Langs
          def self.stage_for(lang)
            # TODO: in some cases capitalize may be insufficient, classify instead
            const_get lang.capitalize
          end
        end
      end
    end
  end
end
