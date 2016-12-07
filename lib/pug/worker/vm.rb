require 'docker'

require 'pug/worker/vm/image'
require 'pug/worker/vm/runner'

module Pug
  module Worker
    module VM
      def self.for(language)
        Runner.new Image.for(language)
      end
    end
  end
end
