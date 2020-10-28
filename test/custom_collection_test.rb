# frozen_string_literal: true
require 'test_helper'

class CustomCollectionTest < Test::Unit::TestCase
  test "#create should create a custom collection" do
    fake("custom_collections", method: :post, status: 201, body: load_fixture('custom_collection'))
    link = ShopifyAPI::CustomCollection.create(title: "Macbooks", image: { src: "http://example.com/rails_logo.gif" })
    assert_equal(1063001463, link.id)
  end
end
