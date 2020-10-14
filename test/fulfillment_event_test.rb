require 'test_helper'

class FulFillmentEventTest < Test::Unit::TestCase
  def test_find_all_resources
    fake(
      'orders/450789469/fulfillments/255858046/events',
      method: :get,
      body: "[#{load_fixture('fulfillment_event')}]"
    )
    events = ShopifyAPI::FulfillmentEvent.all(
      params: { fulfillment_id: 255858046, order_id: 450789469 }
    )

    assert_equal(1, events.count)
  end

  def test_find_a_resource
    fake(
      'orders/450789469/fulfillments/255858046/events/334455',
      method: :get,
      body: load_fixture('fulfillment_event')
    )
    event = ShopifyAPI::FulfillmentEvent.find(
      334455, params: { fulfillment_id: 255858046, order_id: 450789469 }
    )

    assert_equal('in_transit', event.status)
    assert_equal(255858046, event.fulfillment_id)
    assert_equal(450789469, event.order_id)
  end

  def test_create_a_resource
    fake('orders/450789469/fulfillments/255858046/events', method: :post, body: '')

    event = ShopifyAPI::FulfillmentEvent.new(
      fulfillment_id: 255858046,
      order_id: 450789469,
      status: 'in_transit'
    )

    assert(event.save)
  end

  def test_update_a_resource
    fake(
      'orders/450789469/fulfillments/255858046/events/334455',
      method: :get,
      body: load_fixture('fulfillment_event')
    )
    event = ShopifyAPI::FulfillmentEvent.find(
      334455, params: { fulfillment_id: 255858046, order_id: 450789469 }
    )

    fake('orders/450789469/fulfillments/255858046/events/334455', method: :put, body: '')

    assert(event.save)
  end

  def test_destroy_a_resource
    fake(
      'orders/450789469/fulfillments/255858046/events/334455',
      method: :get,
      body: load_fixture('fulfillment_event')
    )
    event = ShopifyAPI::FulfillmentEvent.find(
      334455, params: { fulfillment_id: 255858046, order_id: 450789469 }
    )

    fake('orders/450789469/fulfillments/255858046/events/334455', method: :delete, body: '')

    assert(event.destroy)
  end
end
