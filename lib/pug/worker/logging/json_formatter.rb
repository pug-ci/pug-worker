require 'json'

module Pug
  module Worker
    module Logging
      class JsonFormatter < Logger::Formatter
        def call(severity, timestamp, _progname, message)
          "#{build_entry(severity, timestamp, message)}\n"
        end

        private

        def build_entry(severity, timestamp, message)
          case message
          when String
            message
          when Hash
            data = { severity: severity, timestamp: timestamp }
            data.merge!(message).to_json
          else
            message.inspect
          end
        end
      end
    end
  end
end
