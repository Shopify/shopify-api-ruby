require 'test_helper'
require 'fulfillment_order_test_helper'

class AssignedFulFillmentOrderTest < Test::Unit::TestCase
  include FulfillmentOrderTestHelper

  def setup
    super
    @url_prefix = url_prefix_for_activated_session_for('2020-01')
    @fulfillment_order_fixture = load_fixture('assigned_fulfillment_orders')
  end

  context "AssignedFulfillmentOrder" do
    context ".new" do
      should "raise NotImplementedError when api_version is older than 2020-01" do
        url_prefix_for_activated_session_for('2019-10')

        assert_raises(NotImplementedError) do
          ShopifyAPI::AssignedFulfillmentOrder.new(ActiveSupport::JSON.decode(@fulfillment_order_fixture))
        end
      end
    end

    context "#all" do
      should "raise NotImplementedError when api_version is older than 2020-01" do
        @url_prefix = url_prefix_for_activated_session_for('2019-10')

        fake 'assigned_fulfillment_orders',
          url: "#{@url_prefix}/assigned_fulfillment_orders.json",
          method: :get,
          body: @fulfillment_order_fixture,
          extension: false

        assert_raises(NotImplementedError) do
          ShopifyAPI::AssignedFulfillmentOrder.all(params: { assigned_status: 'cancellation_requested' })
        end
      end

      should "list assigned fulfillment orders by assigned_status" do
        fake 'assigned_fulfillment_orders',
          url: "#{@url_prefix}/assigned_fulfillment_orders.json?assigned_status=cancellation_requested",
          method: :get,
          body: @fulfillment_order_fixture,
          extension: false

        assigned_fulfillment_orders = ShopifyAPI::AssignedFulfillmentOrder.all(
          params: { assigned_status: 'cancellation_requested' }
        )

        assert_equal 2, assigned_fulfillment_orders.count
        assigned_fulfillment_orders.each do |fulfillment_order|
          assert fulfillment_order.is_a?(ShopifyAPI::FulfillmentOrder)
          assert_equal 'in_progress', fulfillment_order.status
          assert_equal 'cancellation_accepted', fulfillment_order.request_status
        end
      end

      should "be able to list assigned fulfillment orders by location_ids" do
        assigned_location_id = 905684977
        fake 'assigned_fulfillment_orders',
          url: "#{@url_prefix}/assigned_fulfillment_orders.json?location_ids%5B%5D=#{assigned_location_id}",
          method: :get,
          body: @fulfillment_order_fixture, extension: false

        assigned_fulfillment_orders = ShopifyAPI::AssignedFulfillmentOrder.all(
          params: { location_ids: [assigned_location_id] }
        )

        assert_equal 2, assigned_fulfillment_orders.count
        assigned_fulfillment_orders.each do |fulfillment_order|
          assert fulfillment_order.is_a?(ShopifyAPI::FulfillmentOrder)
          assert_equal assigned_location_id, fulfillment_order.assigned_location_id
        end
      end
    end
  end
end
