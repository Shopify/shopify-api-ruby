# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class FulfillmentOrderUnstableTest < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "unstable")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillment_orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::FulfillmentOrder.all(
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/unstable/orders/450789469/fulfillment_orders.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/unstable/fulfillment_orders/1046000847.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::FulfillmentOrder.find(
      id: 1046000847,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/unstable/fulfillment_orders/1046000847.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/unstable/fulfillment_orders/1046000848/cancel.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new
    fulfillment_order.id = 1046000848
    fulfillment_order.cancel()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/unstable/fulfillment_orders/1046000848/cancel.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/unstable/fulfillment_orders/1046000851/close.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_order" => hash_including({message: "Not enough inventory to complete this work."}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new
    fulfillment_order.id = 1046000851
    fulfillment_order.close(
      body: {fulfillment_order: {message: "Not enough inventory to complete this work."}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/unstable/fulfillment_orders/1046000851/close.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/unstable/fulfillment_orders/1046000852/move.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_order" => hash_including({new_location_id: 655441491}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new
    fulfillment_order.id = 1046000852
    fulfillment_order.move(
      body: {fulfillment_order: {new_location_id: 655441491}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/unstable/fulfillment_orders/1046000852/move.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/unstable/fulfillment_orders/1046000854/open.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new
    fulfillment_order.id = 1046000854
    fulfillment_order.open()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/unstable/fulfillment_orders/1046000854/open.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/unstable/fulfillment_orders/1046000855/reschedule.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_order" => hash_including({new_fulfill_at: "2023-03-03"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new
    fulfillment_order.id = 1046000855
    fulfillment_order.reschedule(
      body: {fulfillment_order: {new_fulfill_at: "2023-03-03"}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/unstable/fulfillment_orders/1046000855/reschedule.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/unstable/fulfillment_orders/1046000856/hold.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({fulfillment_hold: {reason: "inventory_out_of_stock", reason_notes: "Not enough inventory to complete this work."}})
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new
    fulfillment_order.id = 1046000856
    fulfillment_order.hold(
      body: {fulfillment_hold: {reason: "inventory_out_of_stock", reason_notes: "Not enough inventory to complete this work."}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/unstable/fulfillment_orders/1046000856/hold.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/unstable/fulfillment_orders/1046000858/release_hold.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new
    fulfillment_order.id = 1046000858
    fulfillment_order.release_hold()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/unstable/fulfillment_orders/1046000858/release_hold.json")
  end

end
