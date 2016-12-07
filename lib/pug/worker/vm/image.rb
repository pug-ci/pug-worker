module Pug
  module Worker
    module VM
      class Image
        attr_reader :tag

        def self.for(tag)
          new(tag).retrieve
        end

        def initialize(tag)
          @tag = tag
        end

        def retrieve
          find_image || pull_image
        end

        private

        def find_image
          Docker::Image.all.find do |image|
            image.info['RepoTags'] == image_tag
          end
        end

        def pull_image
          p "Pulling image: #{image_tag}"
          Docker::Image.create 'fromImage' => image_tag
        end

        def image_tag
          # TODO: add image tag prefixing: "#{image_prefix}::#{tag}"
          tag
        end
      end
    end
  end
end
