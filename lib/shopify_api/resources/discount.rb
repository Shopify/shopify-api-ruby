module ShopifyAPI
  class Discount < Base
    def disable
      load_attributes_from_response(post(:disable))
    end
    
    def enable
      load_attributes_from_response(post(:enable))
    end
  end
end