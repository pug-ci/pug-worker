require 'logger'

require_relative 'logging/json_formatter'
require_relative 'logging/methods'

module Pug
  module Worker
    module Logging
      def self.default_logger
        logger = Logger.new STDOUT
        logger.formatter = JsonFormatter.new
        logger.level = Logger::INFO
        logger
      end
    end
  end
end
