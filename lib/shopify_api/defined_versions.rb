# frozen_string_literal: true
module ShopifyAPI
  module DefinedVersions
    def define_known_versions
      define_version(ShopifyAPI::ApiVersion::Unstable.new)
      define_version(ShopifyAPI::ApiVersion::Release.new('2019-04'))
    end
  end
end
