require 'docker'

require_relative 'vm/image_fetcher'
require_relative 'vm/runner'

module Pug
  module Worker
    module VM
      def self.for(language)
        image_tag = Pug::Worker.configuration.vm.image_lookup[language]
        image = ImageFetcher.new(image_tag).fetch
        Runner.new image
      end
    end
  end
end
