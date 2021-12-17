# frozen_string_literal: true
module ShopifyAPI
  module ShopifyPayments
    class Balance < Base
      self.collection_name = "balance"
      self.resource_prefix = "shopify_payments/"

      def self.find(*arguments)
        scope = arguments.slice!(0)
        options = arguments.slice!(0) || {}

        super(:first, options)
      end
    end
  end
end
