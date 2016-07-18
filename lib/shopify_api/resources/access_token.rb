module ShopifyAPI
  class AccessToken < Base
    def self.delegate(access_scope, expires_in = nil)
      resource = post(:delegate, delegate_access_scope: access_scope, expires_in: expires_in)
      new_record(format.decode(resource.body))
    end
  end
end
