# frozen_string_literal: true

module ShopifyAPI
  class Checkout < Base
    self.primary_key = :token
    headers['X-Shopify-Checkout-Version'] = '2016-09-06'
  end
end
