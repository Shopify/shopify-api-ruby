# frozen_string_literal: true
module ShopifyAPI
  module VersionCoercers
    class GenerateVersion < Base
      protected

      def coerce_from_handle(handle)
        version_set.fetch(handle) do
          record_new_version(handle)
        end
      end

      private

      def record_new_version(handle)
        new_version = ShopifyAPI::ApiVersion.new(handle)
        version_set[handle] = new_version
      end
    end
  end
end
