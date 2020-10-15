require 'test_helper'

class OrderRiskTest < Test::Unit::TestCase
  def test_create_order_risk
    fake("orders/450789469/risks", method: :post, body: load_fixture('order_risk'))
    v = ShopifyAPI::OrderRisk.new(order_id: 450789469)
    v.message = "This order was placed from a proxy IP"
    v.recommendation = "cancel"
    v.score = "1.0"
    v.source = "External"
    v.merchant_message = "This order was placed from a proxy IP"
    v.display = true
    v.cause_cancel = true
    v.save

    assert_equal(284138680, v.id)
  end

  def test_get_order_risks
    fake("orders/450789469/risks", method: :get, body: load_fixture('order_risks'))
    v = ShopifyAPI::OrderRisk.find(:all, params: { order_id: 450789469 })
    assert_equal(2, v.size)
  end

  def test_get_order_risk
    fake("orders/450789469/risks/284138680", method: :get, body: load_fixture('order_risk'))
    v = ShopifyAPI::OrderRisk.find(284138680, params: { order_id: 450789469 })
    assert_equal(284138680, v.id)
  end

  def test_delete_order_risk
    fake("orders/450789469/risks/284138680", method: :get, body: load_fixture('order_risk'))
    fake("orders/450789469/risks/284138680", method: :delete, body: "destroyed")
    v = ShopifyAPI::OrderRisk.find(284138680, params: { order_id: 450789469 })
    assert(v.destroy)
  end

  def test_update_order_risk
    fake("orders/450789469/risks/284138680", method: :get, body: load_fixture('order_risk'))
    fake("orders/450789469/risks/284138680", method: :put, body: load_fixture('order_risk'))

    v = ShopifyAPI::OrderRisk.find(284138680, params: { order_id: 450789469 })
    v.position = 3
    v.save
  end
end
