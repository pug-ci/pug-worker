require 'pug/worker/script/stages/base'
require 'pug/worker/script/stages/langs'
require 'pug/worker/script/stages/clone'
require 'pug/worker/script/stages/lang'
require 'pug/worker/script/stages/main'

module Pug
  module Worker
    module Script
      module Stages
        ORDERED = [Clone, Lang].freeze
      end
    end
  end
end
