# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class CancellationRequest202201Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-01")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000837/cancellation_request.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "cancellation_request" => hash_including({message: "The customer changed his mind."}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    cancellation_request = ShopifyAPI::CancellationRequest.new
    cancellation_request.fulfillment_order_id = 1046000837
    cancellation_request.message = "The customer changed his mind."
    cancellation_request.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000837/cancellation_request.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000838/cancellation_request/accept.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "cancellation_request" => hash_including({message: "We had not started any processing yet."}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    cancellation_request = ShopifyAPI::CancellationRequest.new
    cancellation_request.fulfillment_order_id = 1046000838
    cancellation_request.accept(
      body: {cancellation_request: {message: "We had not started any processing yet."}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000838/cancellation_request/accept.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000839/cancellation_request/reject.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "cancellation_request" => hash_including({message: "We have already send the shipment out."}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    cancellation_request = ShopifyAPI::CancellationRequest.new
    cancellation_request.fulfillment_order_id = 1046000839
    cancellation_request.reject(
      body: {cancellation_request: {message: "We have already send the shipment out."}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000839/cancellation_request/reject.json")
  end

end
