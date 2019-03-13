# frozen_string_literal: true

module ShopifyAPI
  class ShippingRate < Base
    self.prefix = "#{api_prefix}checkouts/:checkout_id/"
  end
end
