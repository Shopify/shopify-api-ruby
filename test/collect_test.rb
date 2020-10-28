# frozen_string_literal: true
require 'test_helper'

class CollectTest < Test::Unit::TestCase
  test "#create should create a collect" do
    fake("collects", method: :post, status: 201, body: load_fixture('collect'))
    link = ShopifyAPI::Collect.create(product_id: 921728736, collection_id: 841564295)
    assert_equal(841564295, link.id)
  end
end
