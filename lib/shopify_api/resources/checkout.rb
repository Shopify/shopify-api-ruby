# frozen_string_literal: true

module ShopifyAPI
  class Checkout < Base
    self.primary_key = :token

    def self.headers
      super.merge('X-Shopify-Checkout-Version' => '2016-09-06')
    end

    def complete
      post(:complete)
    end

    def ready?
      return false unless persisted?

      reload
      [200, 201].include?(ShopifyAPI::Base.connection.response.code.to_i)
    end

    def payments
      Payment.find(:all, params: { checkout_id: id })
    end

    def shipping_rates
      ShippingRate.find(:all, params: { checkout_id: id })
    end
  end
end
