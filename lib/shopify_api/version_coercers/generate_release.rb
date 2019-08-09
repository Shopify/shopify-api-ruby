# frozen_string_literal: true
module ShopifyAPI
  module VersionCoercers
    class GenerateRelease < Base
      protected

      def coerce_from_name(name)
        versions.fetch(name) do
          record_new_version(name)
        end
      end

      private

      def record_new_version(version_name)
        new_version = create_new_version(version_name)
        define_version(new_version)
        new_version
      end

      def create_new_version(version_name)
        if unstable_version.name == version_name
          unstable_version
        else
          ApiVersion::Release.new(version_name)
        end
      end

      def unstable_version
        @unstable_version ||= ShopifyAPI::ApiVersion::Unstable.new
      end
    end
  end
end
