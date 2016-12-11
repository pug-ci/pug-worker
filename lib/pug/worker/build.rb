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

      def language
        configuration[:language]
      end

      def configuration
        payload[:config] || {}
      end
    end
  end
end
