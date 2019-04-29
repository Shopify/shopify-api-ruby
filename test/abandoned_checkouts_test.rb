# frozen_string_literal: true
require 'test_helper'

class AbandonedCheckoutsTest < Test::Unit::TestCase
  def setup
    super

    @expected_checkouts = JSON.parse(load_fixture('abandoned_checkouts'))['checkouts']
    @expected_checkout_id = JSON.parse(load_fixture('abandoned_checkout'))['checkout']['id']
  end

  test ":create creates a checkout" do
    fake 'checkouts', method: :post, status: 201, body: load_fixture('abandoned_checkout')

    checkout = ShopifyAPI::AbandonedCheckout.create

    assert_equal @expected_checkout_id, checkout.id
    assert_equal true, checkout.attributes.include?(:abandoned_checkout_url)
  end

  test "get all checkouts indexed by token" do
    fake 'checkouts', method: :get, status: 200, body: load_fixture('abandoned_checkouts')

    checkouts = ShopifyAPI::AbandonedCheckout.all

    assert_equal @expected_checkout_id, checkouts.first.id
    assert_equal @expected_checkouts.size, checkouts.size
  end
end
