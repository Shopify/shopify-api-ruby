require 'test_helper'
require 'fulfillment_order_test_helper'

class OrderTest < Test::Unit::TestCase
  include FulfillmentOrderTestHelper

  test "create should create order" do
    fake 'orders', :method => :post, :status => 201, :body => load_fixture('order')
    order = ShopifyAPI::Order.create(line_items: [{ quantity:1, variant_id:39072856 }], financial_status:"authorized")
    assert_equal 39072856, order.line_items.first.variant_id
  end

  test "create should create an order with custom properties" do
    props = [{ :"By default may label with \"Roasted for " => { :"Your First Name" => { :"\". If you want something specific on the label, enter it here:" => "" } } }]
    fake 'orders', :method => :post, :status => 201, :body => load_fixture('order_with_properties')
    order = ShopifyAPI::Order.create(line_items: [{ quantity:1, variant_id:39072856, properties:props }], financial_status:"authorized")
    assert_equal 39072856, order.line_items.first.variant_id
  end

  test "get should get an order" do
    fake 'orders/450789469', :method => :get, :status => 200, :body => load_fixture('order')
    order = ShopifyAPI::Order.find(450789469)
    assert_equal 450789469, order.id
  end

  test "get should get an order with custom properties" do
    fake 'orders/450789469', :method => :get, :status => 200, :body => load_fixture('order_with_properties')
    order = ShopifyAPI::Order.find(450789469)
    assert_equal 450789469, order.id
  end

  test "get all should get all orders" do
    fake 'orders', :method => :get, :status => 200, :body => load_fixture('orders')
    order = ShopifyAPI::Order.all
    assert_equal 450789469, order.first.id
  end

  test "add note should add a note to order" do
    fake 'orders/450789469', :method => :get, :status => 200, :body => load_fixture('order')
    order = ShopifyAPI::Order.find(450789469)
    order.note = "Test note"
    fake 'orders/450789469', :method => :put, :status => 200, :body => load_fixture('order')
    order.save
    assert_equal "Test note", order.note
  end

  test "delete should delete an order" do
    fake 'orders/450789469', :method => :get, :status => 200, :body => load_fixture('order')
    fake 'orders/450789469', :method => :delete, :body => 'destroyed'
    order = ShopifyAPI::Order.find(450789469)
    assert order.destroy
  end

  test "cancel an order with params" do
    fake 'orders/450789469', :method => :get, :status => 200, :body => load_fixture('order')
    fake 'orders/450789469/cancel', :method => :post, :body => load_fixture('order')
    order = ShopifyAPI::Order.find(450789469)
    order.cancel(email: false, restock: true)
    assert_request_body({ 'email' => false, 'restock' => true }.to_json)
  end

  test "capture an order with currency param" do
    fake 'orders/450789469', body: load_fixture('order')
    order = ShopifyAPI::Order.find(450789469)

    fake 'orders/450789469/transactions', method: :post, status: 201, body: load_fixture('transaction')
    order.capture(100.00, currency: 'CAD')

    assert_request_body({
      transaction: {
        amount: 100.00,
        kind: 'capture',
        currency: 'CAD',
      },
    }.to_json)
  end

  test "fulfillment_orders should get fulfillment orders for an order with 2020-01 version" do
    url_prefix = url_prefix_for_activated_session_for('2020-01')

    fake(
      'orders',
      url: "#{url_prefix}/orders/450789469.json",
      method: :get,
      status: 200,
      body: load_fixture('order'),
      extension: false
    )
    order = ShopifyAPI::Order.find(450789469)

    fake(
      'orders',
      url: "#{url_prefix}/orders/450789469/fulfillment_orders.json",
      method: :get,
      status: 200,
      body: load_fixture('fulfillment_orders'),
      extension: false
    )
    fulfillment_orders = order.fulfillment_orders

    assert_equal [519788021, 519788022], fulfillment_orders.map(&:id).sort
    fulfillment_orders.each do |fulfillment_order|
      assert fulfillment_order.is_a?(ShopifyAPI::FulfillmentOrder)
      assert_equal 450789469, fulfillment_order.order_id
    end
  end

  test "fulfillment_orders raises NotImplementedError when api_version is older than 2020-01" do
    url_prefix = url_prefix_for_activated_session_for('2019-10')

    fake(
      'orders',
      url: "#{url_prefix}/orders/450789469.json",
      method: :get,
      status: 200,
      body: load_fixture('order'),
      extension: false
    )
    order = ShopifyAPI::Order.find(450789469)

    assert_raises NotImplementedError do
      order.fulfillment_orders
    end
  end
end
