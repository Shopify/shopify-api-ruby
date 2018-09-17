# frozen_string_literal: true

require 'test_helper'

class AbandonedCheckoutsTest < Test::Unit::TestCase
  test ":get lists all abandoned checkouts indexed by id" do
    fake 'checkouts', method: :get, status: 200, body: load_fixture('checkouts')
    abandoned_checkouts = ShopifyAPI::AbandonedCheckout.all
    assert_equal 450789469, abandoned_checkouts.first.id
    assert_equal JSON.parse(load_fixture('checkouts'))['checkouts'].size, abandoned_checkouts.size
  end
end
