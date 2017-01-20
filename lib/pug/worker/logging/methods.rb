module Pug
  module Worker
    module Logging
      module Methods
        SEVERITIES = %w(fatal error warn info debug unknown).freeze

        SEVERITIES.each do |severity|
          define_method severity do |measure, message = {}|
            logger.send severity, message.merge(measure: measure)
          end
        end

        def logger
          Pug::Worker.logger
        end
      end
    end
  end
end
