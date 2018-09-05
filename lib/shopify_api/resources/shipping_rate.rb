# frozen_string_literal: true

module ShopifyAPI
  class ShippingRate < Base
    self.prefix = '/admin/checkouts/:checkout_id/'
  end
end
