# frozen_string_literal: true
require 'test_helper'

class CountableTest < Test::Unit::TestCase
  def setup
    super
    fake("products/count", body: '{"count": 16}')
  end

  def test_count_products
    count = ShopifyAPI::Product.count
    assert_equal(16, count)
  end
end
