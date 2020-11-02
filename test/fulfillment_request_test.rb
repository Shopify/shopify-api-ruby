# frozen_string_literal: true
require 'test_helper'

class FulFillmentRequestTest < Test::Unit::TestCase
  def setup
    super
    fake("orders/450789469/fulfillment_requests/695890229", method: :get, body: load_fixture('fulfillment_request'))
  end

  context "#mark_as_failed" do
    should "be able to mark_as_failed a fulfillment request" do
      fulfillment_request = ShopifyAPI::FulfillmentRequest.find(695890229, params: { order_id: 450789469 })

      cancelled = ActiveSupport::JSON.decode(load_fixture('fulfillment_request'))
      cancelled['failure_message'] = 'failure reason'
      cancelled['message'] = nil
      fake(
        "orders/450789469/fulfillment_requests/695890229/mark_as_failed",
        method: :put,
        body: ActiveSupport::JSON.encode(cancelled)
      )
      assert(fulfillment_request.failure_message.blank?)
      assert(fulfillment_request.mark_as_failed)
      assert_equal('failure reason', fulfillment_request.failure_message)
    end
  end

  context "#find" do
    should "be able to find fulfillment request" do
      fulfillment_request = ShopifyAPI::FulfillmentRequest.find(695890229, params: { order_id: 450789469 })
      assert_equal(695890229, fulfillment_request.id)
      assert_equal(450789469, fulfillment_request.order_id)
    end
  end
end
