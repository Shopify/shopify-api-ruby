require 'test_helper'

class CartTest < Test::Unit::TestCase
  test 'all should return all carts' do
    fake 'carts'
    carts = ShopifyAPI::Cart.all
    assert_equal carts.size, 2
    assert_equal 2, carts.first.id
    assert_equal "3eed8183d4281db6ea82ee2b8f23e9cc", carts.first.token
    assert_equal 1, carts.first.line_items.size
    assert_equal 'test', carts.first.line_items.first.title
  end
end