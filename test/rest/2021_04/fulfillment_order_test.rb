# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class FulfillmentOrder202104Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-04")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/orders/450789469/fulfillment_orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::FulfillmentOrder.all(
      session: @test_session,
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/orders/450789469/fulfillment_orders.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/fulfillment_orders/1046000847.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::FulfillmentOrder.find(
      session: @test_session,
      id: 1046000847,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/fulfillment_orders/1046000847.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/fulfillment_orders/1046000848/cancel.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new(session: @test_session)
    fulfillment_order.id = 1046000848
    fulfillment_order.cancel()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/fulfillment_orders/1046000848/cancel.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/fulfillment_orders/1046000851/close.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_order" => hash_including({"message" => "Not enough inventory to complete this work."}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new(session: @test_session)
    fulfillment_order.id = 1046000851
    fulfillment_order.close(
      body: {"fulfillment_order" => {"message" => "Not enough inventory to complete this work."}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/fulfillment_orders/1046000851/close.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/fulfillment_orders/1046000852/move.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_order" => hash_including({"new_location_id" => 655441491}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new(session: @test_session)
    fulfillment_order.id = 1046000852
    fulfillment_order.move(
      body: {"fulfillment_order" => {"new_location_id" => 655441491}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/fulfillment_orders/1046000852/move.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/fulfillment_orders/1046000854/open.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new(session: @test_session)
    fulfillment_order.id = 1046000854
    fulfillment_order.open()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/fulfillment_orders/1046000854/open.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/fulfillment_orders/1046000855/reschedule.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_order" => hash_including({"new_fulfill_at" => "2023-03-03"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new(session: @test_session)
    fulfillment_order.id = 1046000855
    fulfillment_order.reschedule(
      body: {"fulfillment_order" => {"new_fulfill_at" => "2023-03-03"}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/fulfillment_orders/1046000855/reschedule.json")
  end

end
