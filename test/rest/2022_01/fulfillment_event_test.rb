# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class FulfillmentEvent202201Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/fulfillments/255858046/events.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::FulfillmentEvent.all(
      order_id: 450789469,
      fulfillment_id: 255858046,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/fulfillments/255858046/events.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/fulfillments/255858046/events.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "event" => hash_including({status: "in_transit"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_event = ShopifyAPI::FulfillmentEvent.new
    fulfillment_event.order_id = 450789469
    fulfillment_event.fulfillment_id = 255858046
    fulfillment_event.status = "in_transit"
    fulfillment_event.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/fulfillments/255858046/events.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/fulfillments/255858046/events/944956395.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::FulfillmentEvent.find(
      order_id: 450789469,
      fulfillment_id: 255858046,
      id: 944956395,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/fulfillments/255858046/events/944956395.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/fulfillments/255858046/events/944956397.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::FulfillmentEvent.delete(
      order_id: 450789469,
      fulfillment_id: 255858046,
      id: 944956397,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/fulfillments/255858046/events/944956397.json")
  end

end
