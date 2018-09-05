require 'test_helper'

class CheckoutsTest < Test::Unit::TestCase
  test "get all checkouts indexed by token" do
    fake 'checkouts', method: :get, status: 200, body: load_fixture('checkouts')
    checkout = ShopifyAPI::Checkout.all
    assert_equal '2a1ace52255252df566af0faaedfbfa7', checkout.first.id
  end

  test ":complete completes a checkout" do
    checkout_id = JSON.parse(load_fixture('checkout'))['checkout']['id']

    fake "checkouts/#{checkout_id}", method: :get, status: 200, body: load_fixture('checkout')
    checkout = ShopifyAPI::Checkout.find(checkout_id)

    fake "checkouts/#{checkout.id}/complete", method: :post, status: 200, body: load_fixture('checkouts')
    checkout.complete
  end
end
