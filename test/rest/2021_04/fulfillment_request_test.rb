# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class FulfillmentRequest202104Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-04")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/fulfillment_orders/1046000840/fulfillment_request.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_request" => hash_including({message: "Fulfill this ASAP please.", fulfillment_order_line_items: [{id: 1058737578, quantity: 1}, {id: 1058737579, quantity: 1}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_request = ShopifyAPI::FulfillmentRequest.new(session: @test_session)
    fulfillment_request.fulfillment_order_id = 1046000840
    fulfillment_request.message = "Fulfill this ASAP please."
    fulfillment_request.fulfillment_order_line_items = [
      {
        id: 1058737578,
        quantity: 1
      },
      {
        id: 1058737579,
        quantity: 1
      }
    ]
    fulfillment_request.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/fulfillment_orders/1046000840/fulfillment_request.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/fulfillment_orders/1046000843/fulfillment_request.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_request" => hash_including({message: "Fulfill this ASAP please."}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_request = ShopifyAPI::FulfillmentRequest.new(session: @test_session)
    fulfillment_request.fulfillment_order_id = 1046000843
    fulfillment_request.message = "Fulfill this ASAP please."
    fulfillment_request.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/fulfillment_orders/1046000843/fulfillment_request.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/fulfillment_orders/1046000844/fulfillment_request/accept.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_request" => hash_including({message: "We will start processing your fulfillment on the next business day."}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_request = ShopifyAPI::FulfillmentRequest.new(session: @test_session)
    fulfillment_request.fulfillment_order_id = 1046000844
    fulfillment_request.accept(
      body: {fulfillment_request: {message: "We will start processing your fulfillment on the next business day."}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/fulfillment_orders/1046000844/fulfillment_request/accept.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/fulfillment_orders/1046000845/fulfillment_request/reject.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_request" => hash_including({message: "Not enough inventory on hand to complete the work."}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_request = ShopifyAPI::FulfillmentRequest.new(session: @test_session)
    fulfillment_request.fulfillment_order_id = 1046000845
    fulfillment_request.reject(
      body: {fulfillment_request: {message: "Not enough inventory on hand to complete the work."}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/fulfillment_orders/1046000845/fulfillment_request/reject.json")
  end

end
