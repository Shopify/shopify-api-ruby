require 'test_helper'

class AssignedFulFillmentOrderTest < Test::Unit::TestCase
  context "AssignedFulfillmentOrder" do
    context "#all" do
      should "be able to list assigned fulfillment orders for an order by assigned_status" do
        fake 'orders/450789469/assigned_fulfillment_orders.json?assigned_status=cancellation_requested', method: :get,
             body: "[#{load_fixture('fulfillment_order')}]", extension: false

        fulfillment_orders = ShopifyAPI::AssignedFulfillmentOrder.all(
            params: { order_id: 450789469, assigned_status: 'cancellation_requested' }
        )

        assert_equal 1, fulfillment_orders.count
        fulfillment_order = fulfillment_orders.first
        assert_equal 450789469, fulfillment_order.order_id
      end

      should "be able to list assigned fulfillment orders for an order by location_ids" do
        fo_fixture = load_fixture('fulfillment_order')
        assigned_location_id = 361872256
        fo_fixture = fo_fixture.gsub(/("assigned_location_id" *:) *[0-9]+/, "\\1 #{assigned_location_id}")
        fake "orders/450789469/assigned_fulfillment_orders.json?location_ids%5B%5D=#{assigned_location_id}", method: :get,
             body: "[#{fo_fixture}]", extension: false

        fulfillment_orders = ShopifyAPI::AssignedFulfillmentOrder.all(
            params: { order_id: 450789469, location_ids: [assigned_location_id] }
        )

        assert_equal 1, fulfillment_orders.count
        fulfillment_order = fulfillment_orders.first.fulfillment_order
        assert_equal 450789469, fulfillment_order.order_id
        assert_equal assigned_location_id, fulfillment_order.assigned_location_id
      end
    end
  end
end
