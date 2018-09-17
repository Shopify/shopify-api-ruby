# frozen_string_literal: true
require 'test_helper'

class CheckoutsTest < Test::Unit::TestCase
  def setup
    super

    @expected_checkouts = JSON.parse(load_fixture('checkouts'))['checkouts']
    @expected_checkout_id = JSON.parse(load_fixture('checkout'))['checkout']['token']
  end

  test ":create creates a checkout" do
    fake 'checkouts', method: :post, status: 201, body: load_fixture('checkout')

    checkout = ShopifyAPI::Checkout.create

    assert_equal @expected_checkout_id, checkout.id
  end

  test "get all checkouts indexed by token" do
    fake 'checkouts', method: :get, status: 200, body: load_fixture('checkouts')

    checkouts = ShopifyAPI::Checkout.all

    assert_equal @expected_checkout_id, checkouts.first.id
    assert_equal @expected_checkouts.size, checkouts.size
  end

  test ":complete completes a checkout" do
    fake "checkouts/#{@expected_checkout_id}", method: :get, status: 200, body: load_fixture('checkout')

    checkout = ShopifyAPI::Checkout.find(@expected_checkout_id)

    fake "checkouts/#{@expected_checkout_id}/complete", method: :post, status: 200, body: load_fixture('checkouts')

    checkout.complete
  end
end
