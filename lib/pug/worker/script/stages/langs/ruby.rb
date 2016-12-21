module Pug
  module Worker
    module Script
      module Stages
        module Langs
          class Ruby < Base
            def apply
              setup_ruby_version
              bundle_dependencies
              perform_build
            end

            private

            def setup_ruby_version
              shell.cmd "rvm use #{ruby_version} #{rvm_options}"
            end

            def rvm_options
              %w(--install --binary).join ' '
            end

            def bundle_dependencies
              # TODO: we should check Gemfile presence
              shell.cmd "bundle install #{bundle_install_options}"
            end

            def bundle_install_options
              %w(--deployment).join ' '
            end

            def perform_build
              # TODO: we should check Gemfile presence
              shell.cmd 'bundle exec rake'
            end

            def ruby_version
              build.configuration[:rbenv]
            end
          end
        end
      end
    end
  end
end
