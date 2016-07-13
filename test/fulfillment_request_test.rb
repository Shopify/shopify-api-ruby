require 'test_helper'

class FulFillmentTest < Test::Unit::TestCase
  def setup
    fake "orders/450789469/fulfillment_requests/695890229", :method => :get, :body => load_fixture('fulfillment_request')
  end

  context "#cancel" do
    should "be able to cancel fulfillment request" do
      fulfillment_request = ShopifyAPI::FulfillmentRequest.find(255858046, :params => {:order_id => 450789469})

      cancelled = ActiveSupport::JSON.decode(load_fixture('fulfillment_request'))
      cancelled['failure_message'] = 'cancelled'
      fake "orders/450789469/fulfillments/695890229/cancel", :method => :post, :body => ActiveSupport::JSON.encode(cancelled)

      assert fulfillment_request.failure_message.blank?
      assert fulfillment_request.cancel
      assert_equal 'cancelled', fulfillment_request.failure_message
    end
  end

  context "#find" do
    should "be able to find fulfillment request" do
      fulfillment_request = ShopifyAPI::FulfillmentRequest.find(255858046, :params => {:order_id => 450789469})
      assert_equal 695890229, fulfillment_request.id
      assert_equal 450789469, fulfillment_request.order_id
    end
  end
end
