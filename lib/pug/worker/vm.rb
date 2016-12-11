require 'docker'

require 'pug/worker/vm/image'
require 'pug/worker/vm/runner'

module Pug
  module Worker
    module VM
      def self.for(language)
        image_tag = Pug::Worker.configuration.vm.image_lookup[language]
        Runner.new Image.for(image_tag)
      end
    end
  end
end
