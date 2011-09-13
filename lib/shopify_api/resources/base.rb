module ShopifyAPI
  class Base < ActiveResource::Base
    extend Countable
    self.include_root_in_json = false
  end
end
