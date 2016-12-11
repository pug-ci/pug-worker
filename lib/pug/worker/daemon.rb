module Pug
  module Worker
    class Daemon
      attr_reader :application

      def initialize(application)
        @application = application
      end

      def run
        start
        sleep
      end

      private

      def start
        daemonize if configuration.daemonize?
        trap_signals
        create_pid_file
        application.start
        sleep
      end

      def stop
        delete_pid_file
        application.stop
      end

      def daemonize
        Process.daemon true, true
      end

      def trap_signals
        trap_int_signal
        trap_term_signal
      end

      def trap_int_signal
        Signal.trap 'INT' do
          Thread.new { stop }.join
          exit! 1
        end
      end

      def trap_term_signal
        Signal.trap 'TERM' do
          Thread.new { stop }.join
          exit! 0
        end
      end

      def create_pid_file
        pid_file.create pid
      end

      def delete_pid_file
        pid_file.delete
      end

      def pid_file
        @pid_file ||= PidFile.new configuration.pid_path
      end

      def pid
        Process.pid
      end

      def configuration
        Pug::Worker.configuration
      end
    end
  end
end
