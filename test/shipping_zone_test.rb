require 'test_helper'

class ShippingZoneTest < Test::Unit::TestCase
  test "get all should get all shipping zones" do
    fake 'shipping_zones', method: :get, status: 200, body: load_fixture('shipping_zones')
    checkout = ShopifyAPI::ShippingZone.all
    assert_equal 1, checkout.first.id
    assert_equal "Canada", checkout.first.name
  end
end
