require 'forwardable'

require 'pug/worker/version'
require 'pug/worker/logging'
require 'pug/worker/utils'
require 'pug/worker/configuration'
require 'pug/worker/pid_file'
require 'pug/worker/daemon'
require 'pug/worker/broker'
require 'pug/worker/vm'
require 'pug/worker/build'
require 'pug/worker/script'
require 'pug/worker/job'
require 'pug/worker/instance'
require 'pug/worker/pool'
require 'pug/worker/application'
require 'pug/worker/cli'

module Pug
  module Worker
    class << self
      attr_writer :configuration, :logger
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield configuration
    end

    def self.logger
      @logger ||= Logging.default_logger
    end
  end
end
