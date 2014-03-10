require 'test_helper'

class CheckoutsTest < Test::Unit::TestCase
  test "get all should get all orders" do
    fake 'checkouts', :method => :get, :status => 200, :body => load_fixture('checkouts')
    checkout = ShopifyAPI::Checkout.all
    assert_equal 450789469, checkout.first.id
  end
end
