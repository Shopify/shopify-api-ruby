require 'test_helper'

class FulFillmentOrderTest < Test::Unit::TestCase
  def setup
    super
    fake "orders/450789469/fulfillment_orders/519788021", method: :get,
         body: load_fixture('fulfillment_order')
  end

  context "FulfillmentOrder" do
    context "#find" do
      should "be able to find fulfillment order" do
        fulfillment_order = ShopifyAPI::FulfillmentOrder.find(519788021, params: { order_id: 450789469 })
        assert_equal 519788021, fulfillment_order.id
        assert_equal 450789469, fulfillment_order.order_id
      end
    end

    context "#all" do
      should "be able to list fulfillment orders for an order" do
        fake 'orders/450789469/fulfillment_orders', method: :get, body: "[#{load_fixture('fulfillment_order')}]"

        fulfillment_orders = ShopifyAPI::FulfillmentOrder.all(
            params: { order_id: 450789469 }
        )

        assert_equal 1, fulfillment_orders.count
        fulfillment_order = fulfillment_orders.first
        assert_equal 519788021, fulfillment_order.id
        assert_equal 450789469, fulfillment_order.order_id
      end
    end

    context "#cancel" do
      should "be able to cancel fulfillment order" do
        fulfillment_order = ShopifyAPI::FulfillmentOrder.find(519788021, :params => {:order_id => 450789469})

        cancelled = ActiveSupport::JSON.decode(load_fixture('fulfillment_order'))
        cancelled['fulfillment_order']['status'] = 'cancelled'
        fake "orders/450789469/fulfillment_orders/519788021/cancel", :method => :post, :body => ActiveSupport::JSON.encode(cancelled)

        assert_equal 'open', fulfillment_order.status
        assert fulfillment_order.cancel
        assert_equal 'cancelled', fulfillment_order.status
      end
    end

    context "#close" do
      should "be able to close fulfillment order" do
        fulfillment_order = ShopifyAPI::FulfillmentOrder.find(519788021, :params => {:order_id => 450789469})

        closed = ActiveSupport::JSON.decode(load_fixture('fulfillment_order'))
        closed['fulfillment_order']['status'] = 'closed'
        fake "orders/450789469/fulfillment_orders/519788021/close", :method => :post, :body => ActiveSupport::JSON.encode(closed)

        assert_equal 'open', fulfillment_order.status
        assert fulfillment_order.close
        assert_equal 'closed', fulfillment_order.status
      end
    end

    context "#move" do
      should "be able to move fulfillment order" do
        fulfillment_order = ShopifyAPI::FulfillmentOrder.find(519788021, :params => {:order_id => 450789469})
        new_location_id = 5

        moved = ActiveSupport::JSON.decode(load_fixture('fulfillment_order'))
        moved['fulfillment_order']['assigned_location_id'] = new_location_id
        fulfillment_order.status = 'closed'

        body = {
            original_fulfillment_order: fulfillment_order,
            moved_fulfillment_order: moved['fulfillment_order'],
        }
        fake "orders/450789469/fulfillment_orders/519788021/move", :method => :post, :body => ActiveSupport::JSON.encode(body)

        assert_equal true, fulfillment_order.move(new_location_id: new_location_id)
        refute_nil fulfillment_order.original_fulfillment_order
        refute_nil fulfillment_order.moved_fulfillment_order

        assert_equal 'closed', fulfillment_order.original_fulfillment_order.status
        assert_equal 'open', fulfillment_order.moved_fulfillment_order.status
        assert_equal new_location_id, fulfillment_order.moved_fulfillment_order.assigned_location_id
      end
    end
  end
end
