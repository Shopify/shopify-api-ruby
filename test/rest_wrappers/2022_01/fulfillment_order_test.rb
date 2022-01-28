# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class FulfillmentOrder202201Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2022-01")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/orders/450789469/fulfillment_orders.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::FulfillmentOrder.all(
      session: @test_session,
      order_id: "450789469",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/orders/450789469/fulfillment_orders.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000794.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::FulfillmentOrder.find(
      session: @test_session,
      id: "1046000794",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000794.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000782/cancel.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new(session: @test_session)
    fulfillment_order.id = 1046000782
    fulfillment_order.cancel(
      body: {},
    )

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000782/cancel.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000785/close.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "fulfillment_order" => hash_including({message: "Not enough inventory to complete this work."}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new(session: @test_session)
    fulfillment_order.id = 1046000785
    fulfillment_order.close(
      body: {fulfillment_order: {message: "Not enough inventory to complete this work."}},
    )

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000785/close.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000786/move.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "fulfillment_order" => hash_including({new_location_id: 655441491}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new(session: @test_session)
    fulfillment_order.id = 1046000786
    fulfillment_order.move(
      body: {fulfillment_order: {new_location_id: 655441491}},
    )

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000786/move.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000788/open.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new(session: @test_session)
    fulfillment_order.id = 1046000788
    fulfillment_order.open(
      body: {},
    )

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000788/open.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000789/reschedule.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "fulfillment_order" => hash_including({new_fulfill_at: "2023-02-06"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new(session: @test_session)
    fulfillment_order.id = 1046000789
    fulfillment_order.reschedule(
      body: {fulfillment_order: {new_fulfill_at: "2023-02-06"}},
    )

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000789/reschedule.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000790/hold.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: hash_including({fulfillment_hold: {reason: "inventory_out_of_stock", reason_notes: "Not enough inventory to complete this work."}})
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new(session: @test_session)
    fulfillment_order.id = 1046000790
    fulfillment_order.hold(
      body: {fulfillment_hold: {reason: "inventory_out_of_stock", reason_notes: "Not enough inventory to complete this work."}},
    )

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000790/hold.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000792/release_hold.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new(session: @test_session)
    fulfillment_order.id = 1046000792
    fulfillment_order.release_hold(
      body: {},
    )

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000792/release_hold.json")
  end

end
