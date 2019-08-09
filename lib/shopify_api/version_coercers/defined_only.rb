# frozen_string_literal: true
module ShopifyAPI
  module VersionCoercers
    class DefinedOnly < Base
      protected

      def coerce_from_name(name)
        versions.fetch(name) do
          raise UnknownVersion, "#{name} is not in the defined version set: #{versions.keys.join(', ')}"
        end
      end
    end
  end
end
