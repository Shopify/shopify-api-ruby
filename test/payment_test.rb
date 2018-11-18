# frozen_string_literal: true
require 'test_helper'

class PaymentTest < Test::Unit::TestCase
  def setup
    super

    @checkout_id = JSON.parse(load_fixture('checkout'))['checkout']['token']
    @expected_payment = JSON.parse(load_fixture('payment'))['payment']
  end

  test ":create creates a new payment" do
    fake "checkouts/#{@checkout_id}/payments", method: :post, status: 201, body: load_fixture('payment')

    new_payment = ShopifyAPI::Payment.create(checkout_id: @checkout_id)

    assert_equal @expected_payment['unique_token'], new_payment.attributes['unique_token']
  end
end
