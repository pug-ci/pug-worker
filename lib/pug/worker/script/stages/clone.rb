module Pug
  module Worker
    module Script
      module Stages
        class Clone < Base
          def apply
            clone
            shell.cd dir
            fetch_ref
            checkout
          end

          private

          def clone
            shell.cmd "git clone #{clone_options} #{repository_url} #{dir}"
          end

          def clone_options
            %w(--quiet).join ' '
          end

          def fetch_ref
            shell.cmd "git fetch origin #{ref}"
          end

          def checkout
            shell.cmd "git checkout #{checkout_options} #{commit}"
          end

          def checkout_options
            %w(--quiet --force).join ' '
          end

          def repository_url
            build.repository_url
          end

          def dir
            build.slug
          end

          def ref
            build.ref
          end

          def commit
            build.commit
          end
        end
      end
    end
  end
end
