require 'test_helper'

class OrderTest < Test::Unit::TestCase

  test "create should create order" do
    fake 'orders', :method => :post, :status => 201, :body => load_fixture('order')
    order = ShopifyAPI::Order.create(line_items: [{quantity:1, variant_id:39072856}], financial_status:"authorized")
    assert_equal 39072856, order.line_items.first.variant_id
  end

  test "create should create an order with custom properties" do
    props = [{ :"By default may label with \"Roasted for " => { :"Your First Name" => { :"\". If you want something specific on the label, enter it here:" => "" }}}]
    fake 'orders', :method => :post, :status => 201, :body => load_fixture('order_with_properties')
    order = ShopifyAPI::Order.create(line_items: [{quantity:1, variant_id:39072856, properties:props}], financial_status:"authorized")
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
    assert_request_body({'email' => false, 'restock' => true}.to_json)
  end
end
