module Pug
  module Worker
    module Utils
      module_function

      def symbolize_keys(hash)
        Hash[hash.map { |key, val| [key.to_sym, val] }]
      end

      def slice(hash, *keys)
        Hash[[keys, hash.values_at(*keys)].transpose]
      end

      def slugify(str)
        str.downcase.strip.tr(' ', '-').gsub(/[^\w-]/, '')
      end
    end
  end
end
