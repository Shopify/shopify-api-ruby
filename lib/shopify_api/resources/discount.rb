module ShopifyAPI
  class Discount < Base
    self.element_name = 'legacy_discount'

    def disable
      load_attributes_from_response(post(:disable))
    end

    def enable
      load_attributes_from_response(post(:enable))
    end
  end
end
