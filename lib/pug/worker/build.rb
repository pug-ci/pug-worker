module Pug
  module Worker
    class Build
      attr_reader :payload

      def initialize(payload)
        @payload = payload
      end

      def id
        payload[:id]
      end

      def script
        payload[:build_script]
      end

      def ref
        payload[:ref]
      end

      def commit
        payload[:commit_id]
      end

      def language
        configuration[:language]
      end

      def repository_url
        repository[:url]
      end

      def slug
        Utils.slugify repository[:name]
      end

      def repository
        payload[:repository]
      end

      def configuration
        payload[:config] || {}
      end
    end
  end
end
