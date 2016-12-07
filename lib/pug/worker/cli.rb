require 'thor'

module Pug
  module Worker
    class CLI < Thor
      desc 'start', 'Starts worker application'

      method_option :pool_size, type: :numeric, default: 3
      method_option :pid_file,  type: :string

      def start
        daemon.run
      end

      private

      def daemon
        Daemon.new application, daemon_options
      end

      def application
        Application.new application_options
      end

      def application_options
        Utils.slice method_options, :pool_size
      end

      def daemon_options
        Utils.slice method_options, :pid_file
      end

      def method_options
        @method_options ||= Utils.symbolize_keys options
      end
    end
  end
end
