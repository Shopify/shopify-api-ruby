# frozen_string_literal: true

require 'test_helper'

class AbandonedCheckoutsTest < Test::Unit::TestCase
  test ":get lists all abandoned checkouts indexed by id" do
    fake 'checkouts', method: :get, status: 200, body: load_fixture('checkouts')
    abandoned_checkout = ShopifyAPI::AbandonedCheckout.all
    assert_equal 450789469, abandoned_checkout.first.id
  end
end
