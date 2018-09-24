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

  test ":ready? returns true when status is 201" do
    fake "checkouts/#{@expected_checkout_id}", method: :get, status: 201, body: load_fixture('checkout')
    checkout = ShopifyAPI::Checkout.find(@expected_checkout_id)

    assert_predicate checkout, :ready?
  end

  test ":ready? returns false when status is 202" do
    fake "checkouts/#{@expected_checkout_id}", method: :get, status: 202, body: load_fixture('checkout')
    checkout = ShopifyAPI::Checkout.find(@expected_checkout_id)

    refute_predicate checkout, :ready?
  end

  test ":payments returns payments for a checkout" do
    fake "checkouts/#{@expected_checkout_id}", method: :get, status: 200, body: load_fixture('checkout')
    checkout = ShopifyAPI::Checkout.find(@expected_checkout_id)

    fake "checkouts/#{@expected_checkout_id}/payments", method: :get, status: 202, body: load_fixture('payments')

    assert_equal 10.00, checkout.payments.first.attributes['amount']
  end

  test ":shipping_rates returns shipping rates for a checkout" do
    fake "checkouts/#{@expected_checkout_id}", method: :get, status: 200, body: load_fixture('checkout')
    checkout = ShopifyAPI::Checkout.find(@expected_checkout_id)

    fake("checkouts/#{@expected_checkout_id}/shipping_rates",
      method: :get,
      status: 202,
      body: load_fixture('shipping_rates'))
    assert_equal "canada_post-INT.TP.BOGUS-4.00", checkout.shipping_rates.first.id
  end
end
