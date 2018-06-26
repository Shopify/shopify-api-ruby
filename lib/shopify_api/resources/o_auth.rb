# frozen_string_literal: true

# This resource is deprecated and will be removed in a future version of this gem.
# Use ShopifyAPI::ApiPermission.destroy instead

module ShopifyAPI
  class OAuth < Base
    self.collection_name = 'oauth'

    def self.revoke
      warn '[DEPRECATED] ShopifyAPI::OAuth#revoke is deprecated and will be removed in a future version. ' \
        'Use ShopifyAPI::ApiPermission#destroy instead.'

      delete(:revoke)
    end
  end
end
