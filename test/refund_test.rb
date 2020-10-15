require 'test_helper'

class RefundTest < Test::Unit::TestCase

  test '#create should create a refund' do
    fake "orders/450789469/refunds", method: :post, status: 201, body: load_fixture('refund')
    refund = ShopifyAPI::Refund.create(
      order_id: 450789469,
      restock: true,
      note: "wrong size",
      shipping: { full_refund: true },
      refund_line_items: [{ line_item_id: 518995019, quantity: 1 }]
    )
    assert_equal 703073504, refund.refund_line_items.first.line_item_id
  end

  test '#find should return a refund' do
    fake "orders/450789469/refunds/509562969.json?order_id=450789469", extension: false, method: :get, body: load_fixture('refund')
    fake "orders/450789469/refunds/509562969", method: :get, body: load_fixture('refund')
    refund = ShopifyAPI::Refund.find(509562969, params: { order_id: 450789469 })
    assert_equal 509562969, refund.id
  end

  test '#calculate a refund' do
    fake "orders/450789469/refunds/calculate", method: :post, body: load_fixture('refund')
    data = { shipping: { amount: 0 } }

    refund = ShopifyAPI::Refund.calculate(data, params: { order_id: 450789469 })
    assert_equal 2, refund.refund_line_items.count
    assert_equal 703073504, refund.refund_line_items.first.line_item_id
  end
end
