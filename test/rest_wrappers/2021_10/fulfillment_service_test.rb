# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class FulfillmentService202110Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-10")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/fulfillment_services.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::FulfillmentService.all(
      session: @test_session,
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/fulfillment_services.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/fulfillment_services.json?scope=all")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::FulfillmentService.all(
      session: @test_session,
      scope: "all",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/fulfillment_services.json?scope=all")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/fulfillment_services.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "fulfillment_service" => hash_including({name: "Jupiter Fulfillment", callback_url: "http://google.com", inventory_management: true, tracking_support: true, requires_shipping_method: true, format: "json"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_service = ShopifyAPI::FulfillmentService.new(session: @test_session)
    fulfillment_service.name = "Jupiter Fulfillment"
    fulfillment_service.callback_url = "http://google.com"
    fulfillment_service.inventory_management = true
    fulfillment_service.tracking_support = true
    fulfillment_service.requires_shipping_method = true
    fulfillment_service.format = "json"
    fulfillment_service.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/fulfillment_services.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/fulfillment_services/755357713.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::FulfillmentService.find(
      session: @test_session,
      id: "755357713",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/fulfillment_services/755357713.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/fulfillment_services/755357713.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "fulfillment_service" => hash_including({id: 755357713, name: "New Fulfillment Service Name"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    fulfillment_service = ShopifyAPI::FulfillmentService.new(session: @test_session)
    fulfillment_service.id = 755357713
    fulfillment_service.name = "New Fulfillment Service Name"
    fulfillment_service.save()

    assert_requested(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/fulfillment_services/755357713.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/fulfillment_services/755357713.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::FulfillmentService.delete(
      session: @test_session,
      id: "755357713",
    )

    assert_requested(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/fulfillment_services/755357713.json")
  end

end
