module ShopifyAPI
  class OAuth < Base
    self.collection_name = 'oauth'

    def self.revoke
      delete(:revoke)
    end
  end
end
