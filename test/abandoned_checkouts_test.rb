require 'test_helper'

class CheckoutsTest < Test::Unit::TestCase
  test "get all should get all orders" do
    fake 'abandoned_checkouts', :method => :get, :status => 200, :body => load_fixture('abandoned_checkouts')
    checkout = ShopifyAPI::AbandonedCheckout.all
    assert_equal 450789469, checkout.first.id
  end
end
