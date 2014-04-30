require 'test_helper'

class OrderTest < Test::Unit::TestCase

  test "fulfill should create a fullfillment for the order" do
    fake 'orders/450789469', :method => :get, :status => 200, :body => load_fixture('order')
    order = ShopifyAPI::Order.find(450789469)
    fake 'orders/450789469/fulfillments', :method => :post, :status => 200, :body => load_fixture('fulfillment')
    order.fulfill
  end

  test "create should create order" do
    fake 'orders', :method => :post, :status => 201, :body => load_fixture('order')
    order = ShopifyAPI::Order.create(line_items: [{quantity:1, variant_id:39072856}], financial_status:"authorized")
    assert_equal 39072856, order.line_items.first.variant_id
  end

  test "get should get an order" do
    fake 'orders/450789469', :method => :get, :status => 200, :body => load_fixture('order')
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
end

