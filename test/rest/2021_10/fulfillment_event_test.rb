# typed: strict
# frozen_string_literal: true

########################################################################################################################
# This file is auto-generated. If you have an issue, please create a GitHub issue.                                     #
########################################################################################################################

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class FulfillmentEvent202110Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2021-10")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/fulfillments/255858046/events.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_events" => [{"id" => 944956391, "fulfillment_id" => 255858046, "status" => "in_transit", "message" => nil, "happened_at" => "2022-04-05T12:55:35-04:00", "city" => nil, "province" => nil, "country" => nil, "zip" => nil, "address1" => nil, "latitude" => nil, "longitude" => nil, "shop_id" => 548380009, "created_at" => "2022-04-05T12:55:35-04:00", "updated_at" => "2022-04-05T12:55:35-04:00", "estimated_delivery_at" => nil, "order_id" => 450789469, "admin_graphql_api_id" => "gid://shopify/FulfillmentEvent/944956391"}]}), headers: {})

    ShopifyAPI::FulfillmentEvent.all(
      order_id: 450789469,
      fulfillment_id: 255858046,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/fulfillments/255858046/events.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/fulfillments/255858046/events.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "event" => hash_including({"status" => "in_transit"}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_event" => {"id" => 944956393, "fulfillment_id" => 255858046, "status" => "in_transit", "message" => nil, "happened_at" => "2022-04-05T12:55:38-04:00", "city" => nil, "province" => nil, "country" => nil, "zip" => nil, "address1" => nil, "latitude" => nil, "longitude" => nil, "shop_id" => 548380009, "created_at" => "2022-04-05T12:55:38-04:00", "updated_at" => "2022-04-05T12:55:38-04:00", "estimated_delivery_at" => nil, "order_id" => 450789469, "admin_graphql_api_id" => "gid://shopify/FulfillmentEvent/944956393"}}), headers: {})

    fulfillment_event = ShopifyAPI::FulfillmentEvent.new
    fulfillment_event.order_id = 450789469
    fulfillment_event.fulfillment_id = 255858046
    fulfillment_event.status = "in_transit"
    fulfillment_event.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/fulfillments/255858046/events.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/fulfillments/255858046/events/944956392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_event" => {"id" => 944956392, "fulfillment_id" => 255858046, "status" => "in_transit", "message" => nil, "happened_at" => "2022-04-05T12:55:36-04:00", "city" => nil, "province" => nil, "country" => nil, "zip" => nil, "address1" => nil, "latitude" => nil, "longitude" => nil, "shop_id" => 548380009, "created_at" => "2022-04-05T12:55:36-04:00", "updated_at" => "2022-04-05T12:55:36-04:00", "estimated_delivery_at" => nil, "order_id" => 450789469, "admin_graphql_api_id" => "gid://shopify/FulfillmentEvent/944956392"}}), headers: {})

    ShopifyAPI::FulfillmentEvent.find(
      order_id: 450789469,
      fulfillment_id: 255858046,
      id: 944956392,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/fulfillments/255858046/events/944956392.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/fulfillments/255858046/events/944956394.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::FulfillmentEvent.delete(
      order_id: 450789469,
      fulfillment_id: 255858046,
      id: 944956394,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/fulfillments/255858046/events/944956394.json")
  end

end
