require 'test_helper'

class AbandonedCheckoutsTest < Test::Unit::TestCase
  test "get all should get all orders" do
    fake 'checkouts', :method => :get, :status => 200, :body => load_fixture('checkouts')
    abandoned_checkout = ShopifyAPI::AbandonedCheckout.all
    assert_equal 450789469, abandoned_checkout.first.id
  end
end
