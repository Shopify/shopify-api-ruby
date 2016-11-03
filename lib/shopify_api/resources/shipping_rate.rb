module ShopifyAPI
  class ShippingRate < Base
    include DisablePrefixCheck
    conditional_prefix :checkout

    def readonly?
      true
    end
  end
end
