require_relative 'stages/base'
require_relative 'stages/langs'
require_relative 'stages/clone'
require_relative 'stages/lang'
require_relative 'stages/main'

module Pug
  module Worker
    module Script
      module Stages
        ORDERED = [Clone, Lang].freeze
      end
    end
  end
end
