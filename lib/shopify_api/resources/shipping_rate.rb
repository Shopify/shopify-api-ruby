# frozen_string_literal: true

module ShopifyAPI
  class ShippingRate < Base
    self.resource_prefix = "checkouts/:checkout_id/"
  end
end
