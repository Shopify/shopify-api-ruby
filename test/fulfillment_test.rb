require 'test_helper'

class FulFillmentTest < Test::Unit::TestCase
  def setup
    fake "orders/450789469/fulfillments/255858046", :method => :get, :body => load_fixture('fulfillment')
  end

  context "Fulfillment" do
    context "#complete" do
      should "be able to complete fulfillment" do
        fulfillment = ShopifyAPI::Fulfillment.find(255858046, :params => {:order_id => 450789469})

        success = ActiveSupport::JSON.decode(load_fixture('fulfillment'))
        success['fulfillment']['status'] = 'success'
        fake "orders/450789469/fulfillments/255858046/complete", :method => :post, :body => ActiveSupport::JSON.encode(success)

        assert_equal 'pending', fulfillment.status
        assert fulfillment.complete
        assert_equal 'success', fulfillment.status
      end
    end

    context "#cancel" do
      should "be able to cancel fulfillment" do
        fulfillment = ShopifyAPI::Fulfillment.find(255858046, :params => {:order_id => 450789469})

        cancelled = ActiveSupport::JSON.decode(load_fixture('fulfillment'))
        cancelled['fulfillment']['status'] = 'cancelled'
        fake "orders/450789469/fulfillments/255858046/cancel", :method => :post, :body => ActiveSupport::JSON.encode(cancelled)

        assert_equal 'pending', fulfillment.status
        assert fulfillment.cancel
        assert_equal 'cancelled', fulfillment.status
      end
    end
  end

end