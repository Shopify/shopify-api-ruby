# frozen_string_literal: true

require 'test_helper'

class ShippingRateTest < Test::Unit::TestCase
  test ":get lists all shipping rates for a given checkout" do
    fake 'checkouts', method: :get, status: 200, body: load_fixture('checkouts')
    checkouts = ShopifyAPI::Checkout.all

    fake "checkouts/#{checkouts.first.id}/shipping_rates",
      method: :get, status: 200, body: load_fixture('checkouts')
    shipping_rates = ShopifyAPI::ShippingRate.find(:all, params: { checkout_id: checkouts.first.id })

    assert_equal 2, shipping_rates.first.shipping_rates.length
    assert_equal 'canada_post-INT.TP.BOGUS-4.00', shipping_rates.first.shipping_rates.first.id
  end
end
