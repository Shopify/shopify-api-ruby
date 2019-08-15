# frozen_string_literal: true
module ShopifyAPI
  module VersionCoercers
    class DefinedOnly < Base
      protected

      def coerce_from_handle(handle)
        version_set.fetch(handle) do
          raise UnknownVersion, "#{handle} is not in the defined version set: #{versions.keys}"
        end
      end
    end
  end
end
