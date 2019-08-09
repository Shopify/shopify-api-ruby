# frozen_string_literal: true
module ShopifyAPI
  module VersionCoercers
    class Base
      def initialize
        @versions = {}
      end

      def coerce_to_version(version_or_name)
        return version_or_name if version_or_name.is_a?(ApiVersion)
        coerce_from_name(version_or_name.to_s)
      end

      def define_version(version)
        versions[version.name] = version
      end

      def clear_defined_versions
        @versions = {}
      end

      def known_versions
        versions.values
      end

      protected

      attr_reader :versions

      def coerce_from_name(name)
        raise NotImplementedError
      end
    end
  end
end
