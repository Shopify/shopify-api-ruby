require 'test_helper'

class CheckoutsTest < Test::Unit::TestCase
  test "get all checkouts indexed by token" do
    fake 'checkouts', :method => :get, :status => 200, :body => load_fixture('checkouts')
    checkout = ShopifyAPI::Checkout.all
    assert_equal '2a1ace52255252df566af0faaedfbfa7', checkout.first.id
  end
end
