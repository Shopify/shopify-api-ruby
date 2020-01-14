require 'test_helper'

class FulFillmentOrderTest < Test::Unit::TestCase
  def setup
    super
    fake "fulfillment_orders/519788021", method: :get,
      body: load_fixture('fulfillment_order')

    fake "orders/450789469/fulfillment_orders", method: :get,
      body: load_fixture('fulfillment_orders')
  end

  context "FulfillmentOrder" do
    context "#find" do
      should "be able to find fulfillment order" do
        fulfillment_order = ShopifyAPI::FulfillmentOrder.find(519788021)
        assert fulfillment_order.is_a?(ShopifyAPI::FulfillmentOrder)
        assert_equal 519788021, fulfillment_order.id
        assert_equal 450789469, fulfillment_order.order_id
      end
    end

    context "#all" do
      should "be able to list fulfillment orders for an order" do
        fake 'orders/450789469/fulfillment_orders', method: :get, body: load_fixture('fulfillment_orders')

        fulfillment_orders = ShopifyAPI::FulfillmentOrder.all(
          params: { order_id: 450789469 }
        )

        assert_equal [519788021, 519788022], fulfillment_orders.map(&:id).sort
        fulfillment_orders.each do |fulfillment_order|
          assert fulfillment_order.is_a?(ShopifyAPI::FulfillmentOrder)
          assert_equal 450789469, fulfillment_order.order_id
        end
      end

      should "require order_id" do
        assert_raises ShopifyAPI::ValidationException do
          ShopifyAPI::FulfillmentOrder.all
        end
      end
    end

    context "#fulfillments" do
      should "be able to list fulfillments for a fulfillment order" do
        fulfillment_order = ShopifyAPI::FulfillmentOrder.find(519788021)
        fake "fulfillment_orders/#{fulfillment_order.id}/fulfillments", method: :get,
             body: load_fixture('fulfillments')

        fulfillments = fulfillment_order.fulfillments

        assert_equal 1, fulfillments.count
        fulfillment = fulfillments.first
        assert fulfillment.is_a?(ShopifyAPI::Fulfillment)
        assert_equal 450789469, fulfillment.order_id
      end
    end

    context "#move" do
      should "move a fulfillment order to a new_location_id" do
        fulfillment_order = ShopifyAPI::FulfillmentOrder.find(519788021)
        new_location_id = 5

        fake_original_fulfillment_order = fulfillment_order.clone
        fake_original_fulfillment_order.status = 'closed'
        fake_moved_fulfillment_order = ActiveSupport::JSON.decode(load_fixture('fulfillment_order'))
        fake_moved_fulfillment_order['assigned_location_id'] = new_location_id

        request_body = { fulfillment_order: { new_location_id: 5 } }
        body = {
          original_fulfillment_order: fake_original_fulfillment_order,
          moved_fulfillment_order: fake_moved_fulfillment_order,
          remaining_fulfillment_order: nil,
        }
        fake "fulfillment_orders/519788021/move", :method => :post,
          :request_body => ActiveSupport::JSON.encode(request_body),
          :body => ActiveSupport::JSON.encode(body)

        response_fulfillment_orders = fulfillment_order.move(new_location_id: new_location_id)

        assert_equal 'closed', fulfillment_order.status

        assert_equal 3, response_fulfillment_orders.count
        original_fulfillment_order = response_fulfillment_orders['original_fulfillment_order']
        refute_nil original_fulfillment_order
        assert original_fulfillment_order.is_a?(ShopifyAPI::FulfillmentOrder)
        assert_equal 'closed', original_fulfillment_order.status

        moved_fulfillment_order = response_fulfillment_orders['moved_fulfillment_order']
        refute_nil moved_fulfillment_order
        assert moved_fulfillment_order.is_a?(ShopifyAPI::FulfillmentOrder)
        assert_equal 'open', moved_fulfillment_order.status
        assert_equal new_location_id, moved_fulfillment_order.assigned_location_id

        remaining_fulfillment_order = response_fulfillment_orders['remaining_fulfillment_order']
        assert_nil remaining_fulfillment_order
      end
    end

    context "#cancel" do
      should "cancel a fulfillment order" do
        fulfillment_order = ShopifyAPI::FulfillmentOrder.find(519788021)
        assert_equal 'open', fulfillment_order.status

        cancelled = ActiveSupport::JSON.decode(load_fixture('fulfillment_order'))
        cancelled['status'] = 'cancelled'
        body = {
          fulfillment_order: cancelled,
          replacement_fulfillment_order: fulfillment_order,
        }
        fake "fulfillment_orders/519788021/cancel", :method => :post, :body => ActiveSupport::JSON.encode(body)

        response_fulfillment_orders = fulfillment_order.cancel

        assert_equal 'cancelled', fulfillment_order.status
        assert_equal 2, response_fulfillment_orders.count
        fulfillment_order = response_fulfillment_orders['fulfillment_order']
        assert_equal 'cancelled', fulfillment_order.status
        replacement_fulfillment_order = response_fulfillment_orders['replacement_fulfillment_order']
        assert_equal 'open', replacement_fulfillment_order.status
      end
    end

    context "#close" do
      should "be able to close fulfillment order" do
        fulfillment_order = ShopifyAPI::FulfillmentOrder.find(519788021)
        fulfillment_order.status = 'in_progress'

        closed = ActiveSupport::JSON.decode(load_fixture('fulfillment_order'))
        closed['status'] = 'incomplete'
        request_body = {
          fulfillment_order: {
            message: "Test close message."
          }
        }
        fake "fulfillment_orders/519788021/close", :method => :post,
          :request_body => ActiveSupport::JSON.encode(request_body),
          :body => ActiveSupport::JSON.encode(closed)

        assert fulfillment_order.close(message: "Test close message.")
        assert_equal 'incomplete', fulfillment_order.status
      end
    end

    context "#request_fulfillment" do
      should "make a fulfillment request for a fulfillment order including unsubmitted" do
        fake_original_fulfillment_order = ActiveSupport::JSON.decode(load_fixture('fulfillment_order'))
        fake_original_fulfillment_order['status'] = 'closed'
        fake_submitted_fulfillment_order = fake_original_fulfillment_order.clone
        fake_submitted_fulfillment_order['id'] = 2
        fake_submitted_fulfillment_order['status'] = 'open'
        fake_submitted_fulfillment_order['request_status'] = 'submitted'
        fake_unsubmitted_fulfillment_order = fake_original_fulfillment_order.clone
        fake_unsubmitted_fulfillment_order['id'] = 3
        fake_unsubmitted_fulfillment_order['status'] = 'open'
        fake_unsubmitted_fulfillment_order['request_status'] = 'unsubmitted'
        body = {
          original_fulfillment_order: fake_original_fulfillment_order,
          submitted_fulfillment_order: fake_submitted_fulfillment_order,
          unsubmitted_fulfillment_order: fake_unsubmitted_fulfillment_order
        }
        request_body = {
          fulfillment_request: {
            fulfillment_order_line_items: [
              { id: 1, quantity: 1 }
            ],
            message: 'Fulfill this FO, please.'
          }
        }
        fake "fulfillment_orders/519788021/fulfillment_request", :method => :post,
          :request_body => ActiveSupport::JSON.encode(request_body),
          :body => ActiveSupport::JSON.encode(body)

        fulfillment_order = ShopifyAPI::FulfillmentOrder.find(519788021)
        params = {
          fulfillment_order_line_items: [{ id: 1, quantity: 1 }],
          message: "Fulfill this FO, please."
        }
        response_fulfillment_orders = fulfillment_order.request_fulfillment(params)

        assert_equal 'closed', fulfillment_order.status
        assert_equal 3, response_fulfillment_orders.size

        original_fulfillment_order = response_fulfillment_orders['original_fulfillment_order']
        assert_equal 519788021, original_fulfillment_order.id
        assert_equal 'closed', original_fulfillment_order.status

        submitted_fulfillment_order = response_fulfillment_orders['submitted_fulfillment_order']
        assert_equal 2, submitted_fulfillment_order.id
        assert_equal 'open', submitted_fulfillment_order.status
        assert_equal 'submitted', submitted_fulfillment_order.request_status

        unsubmitted_fulfillment_order = response_fulfillment_orders['unsubmitted_fulfillment_order']
        assert_equal 3, unsubmitted_fulfillment_order.id
        assert_equal 'open', unsubmitted_fulfillment_order.status
        assert_equal 'unsubmitted', unsubmitted_fulfillment_order.request_status
      end

      should "make a fulfillment request for a fulfillment order excluding unsubmitted" do
        fake_original_fulfillment_order = ActiveSupport::JSON.decode(load_fixture('fulfillment_order'))
        fake_original_fulfillment_order['status'] = 'closed'
        fake_submitted_fulfillment_order = fake_original_fulfillment_order.clone
        fake_submitted_fulfillment_order['id'] = 2
        fake_submitted_fulfillment_order['status'] = 'open'
        fake_submitted_fulfillment_order['request_status'] = 'submitted'
        body = {
          original_fulfillment_order: fake_original_fulfillment_order,
          submitted_fulfillment_order: fake_submitted_fulfillment_order,
          unsubmitted_fulfillment_order: nil,
        }
        request_body = {
          fulfillment_request: {
            fulfillment_order_line_items: [
              { id: 1, quantity: 1 }
            ],
            message: 'Fulfill this FO, please.'
          }
        }
        fake "fulfillment_orders/519788021/fulfillment_request", :method => :post,
          :request_body => ActiveSupport::JSON.encode(request_body),
          :body => ActiveSupport::JSON.encode(body)

        fulfillment_order = ShopifyAPI::FulfillmentOrder.find(519788021)
        params = {
          fulfillment_order_line_items: [{ id: 1, quantity: 1 }],
          message: "Fulfill this FO, please."
        }
        response_fulfillment_orders = fulfillment_order.request_fulfillment(params)

        assert_equal 'closed', fulfillment_order.status
        assert_equal 3, response_fulfillment_orders.size

        original_fulfillment_order = response_fulfillment_orders['original_fulfillment_order']
        assert_equal 519788021, original_fulfillment_order.id
        assert_equal 'closed', original_fulfillment_order.status

        submitted_fulfillment_order = response_fulfillment_orders['submitted_fulfillment_order']
        assert_equal 2, submitted_fulfillment_order.id
        assert_equal 'open', submitted_fulfillment_order.status
        assert_equal 'submitted', submitted_fulfillment_order.request_status

        assert_nil response_fulfillment_orders['unsubmitted_fulfillment_order']
      end
    end

    context "#accept_fulfillment_request" do
      should "accept a fulfillment request for a fulfillment order" do
        fulfillment_order = ShopifyAPI::FulfillmentOrder.find(519788021)

        message = "LGTM. Accept this FO fulfillment request"
        request_body = {
          'fulfillment_request' => {
            'message' => message
          }
        }
        fake_response = {
          fulfillment_order: fulfillment_order.attributes.merge(status: 'in_progress', request_status: 'accepted')
        }
        fake "fulfillment_orders/519788021/fulfillment_request/accept", :method => :post,
          :request_body => ActiveSupport::JSON.encode(request_body),
          :body => ActiveSupport::JSON.encode(fake_response)

        accepted = fulfillment_order.accept_fulfillment_request(message: message)

        assert_equal true, accepted
        assert_equal 'in_progress', fulfillment_order.status
        assert_equal 'accepted', fulfillment_order.request_status
      end
    end

    context "#reject_fulfillment_request" do
      should "reject a fulfillment request for a fulfillment order" do
        fulfillment_order = ShopifyAPI::FulfillmentOrder.find(519788021)

        message = "LBTM. Reject this FO fulfillment request"
        request_body = {
          'fulfillment_request' => {
            'message' => message
          }
        }
        fake_response = {
          fulfillment_order: fulfillment_order.attributes.merge(status: 'open', request_status: 'rejected')
        }
        fake "fulfillment_orders/519788021/fulfillment_request/reject", :method => :post,
          :request_body => ActiveSupport::JSON.encode(request_body),
          :body => ActiveSupport::JSON.encode(fake_response)

        rejected = fulfillment_order.reject_fulfillment_request(message: message)

        assert_equal true, rejected
        assert_equal 'open', fulfillment_order.status
        assert_equal 'rejected', fulfillment_order.request_status
      end
    end

    context "#request_cancellation" do
      should "make a cancellation request for a fulfillment order" do
        fulfillment_order = ShopifyAPI::FulfillmentOrder.find(519788021)

        message = "Cancelling this please."
        request_body = {
          'cancellation_request' => {
            'message' => message
          }
        }
        cancelling = ActiveSupport::JSON.decode(load_fixture('fulfillment_order'))
        cancelling['status'] = 'in_progress'
        cancelling['request_status'] = 'cancellation_requested'
        fake "fulfillment_orders/519788021/cancellation_request", :method => :post,
          :request_body => ActiveSupport::JSON.encode(request_body),
          :body => ActiveSupport::JSON.encode({ fulfillment_order: cancelling })

        cancelled = fulfillment_order.request_cancellation(message: "Cancelling this please.")

        assert_equal true, cancelled
        assert_equal 'in_progress', fulfillment_order.status
        assert_equal 'cancellation_requested', fulfillment_order.request_status
      end
    end

    context "#accept_cancellation_request" do
      should "accept a cancellation request for a fulfillment order" do
        fulfillment_order = ShopifyAPI::FulfillmentOrder.find(519788021)

        message = 'Already in-progress. Reject this FO cancellation request'
        request_body = {
          'cancellation_request' => {
            'message' => message
          }
        }
        fake_response = {
          fulfillment_order: fulfillment_order.attributes.merge(status: 'cancelled',
                                                                request_status: 'cancellation_accepted')
        }
        fake "fulfillment_orders/519788021/cancellation_request/accept", :method => :post,
          :request_body => ActiveSupport::JSON.encode(request_body),
          :body => ActiveSupport::JSON.encode(fake_response)

        accepted = fulfillment_order.accept_cancellation_request(message: message)

        assert_equal true, accepted
        assert_equal 'cancelled', fulfillment_order.status
        assert_equal 'cancellation_accepted', fulfillment_order.request_status
      end
    end

    context "#reject_cancellation_request" do
      should "reject a cancellation request for a fulfillment order" do
        fulfillment_order = ShopifyAPI::FulfillmentOrder.find(519788021)

        message = "Already in-progress. Reject this FO cancellation request"
        request_body = {
          'cancellation_request' => {
            'message' => message
          }
        }
        fake_response = {
          fulfillment_order: fulfillment_order.attributes.merge(status: 'in_progress',
                                                                request_status: 'cancellation_rejected')
        }
        fake "fulfillment_orders/519788021/cancellation_request/reject", :method => :post,
          :request_body => request_body,
          :body => ActiveSupport::JSON.encode(fake_response)

        rejected = fulfillment_order.reject_cancellation_request(message: message)

        assert_equal true, rejected
        assert_equal 'in_progress', fulfillment_order.status
        assert_equal 'cancellation_rejected', fulfillment_order.request_status
      end
    end

  end
end
