module Pug
  module Worker
    module VM
      class ImageFetcher
        attr_reader :tag

        def initialize(tag)
          @tag = tag
        end

        def fetch
          find_image || pull_image
        end

        private

        def find_image
          Docker::Image.all.find do |image|
            image.info['RepoTags'].include? tag
          end
        end

        def pull_image
          p "Pulling image: #{tag}"
          Docker::Image.create 'fromImage' => tag
        end
      end
    end
  end
end
