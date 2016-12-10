require 'thor'

module Pug
  module Worker
    class CLI < Thor
      desc 'start', 'Starts worker application'

      method_option :pool_size, type: :numeric
      method_option :pid_path,  type: :string
      method_option :daemonize, type: :boolean

      def start
        configure
        run
      end

      private

      def configure
        Pug::Worker.configuration = Configuration.new method_options
      end

      def run
        Daemon.new(Application.new).run
      end

      def method_options
        @method_options ||= Utils.symbolize_keys options
      end
    end
  end
end
