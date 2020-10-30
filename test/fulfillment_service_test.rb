# frozen_string_literal: true
require 'test_helper'

class FulFillmentServiceTest < Test::Unit::TestCase
  test 'new should create fulfillment service' do
    fake("fulfillment_services", method: :post, body: load_fixture('fulfillment_service'))
    fulfillment_service = ShopifyAPI::FulfillmentService.new(name: "SomeService")
    fulfillment_service.save
    assert_equal("SomeService", fulfillment_service.name)
  end

  test 'find should return the fulfillment service' do
    fake("fulfillment_services/123456", method: :get, body: load_fixture('fulfillment_service'))
    fulfillment_service = ShopifyAPI::FulfillmentService.find(123456)
    assert_equal(123456, fulfillment_service.id)
    assert_equal("SomeService", fulfillment_service.name)
  end
end
