# frozen_string_literal: true
module ShopifyAPI
  module VersionCoercers
    class Base
      def initialize
        @version_set = {}
      end

      def coerce_to_version(version_or_handle)
        return version_or_handle if version_or_handle.is_a?(ApiVersion)
        coerce_from_handle(version_or_handle.to_s)
      end

      def clear_known_versions
        @version_set = {}
      end

      def known_versions
        version_set
      end

      # def [](handle)
      #   version_set[handle]
      # end

      # def values
      #   version_set.values
      # end

      def fetch_known_versions
        @version_set = ShopifyAPI::Meta.admin_versions.map do |version|
          [version.handle, ShopifyAPI::ApiVersion.new(version.attributes.merge(verified: version.persisted?))]
        end.to_h
      end

      protected

      attr_reader :version_set

      def coerce_from_handle(name)
        raise NotImplementedError
      end
    end
  end
end
