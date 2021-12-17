# frozen_string_literal: true
module ShopifyAPI
  module ShopifyPayments
    class Transaction < Base
      self.resource_prefix = "shopify_payments/balance/"
    end
  end
end
