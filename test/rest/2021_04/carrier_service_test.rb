# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class CarrierService202104Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2021-04")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/carrier_services.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "carrier_service" => hash_including({name: "Shipping Rate Provider", callback_url: "http://shippingrateprovider.com", service_discovery: true}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    carrier_service = ShopifyAPI::CarrierService.new
    carrier_service.name = "Shipping Rate Provider"
    carrier_service.callback_url = "http://shippingrateprovider.com"
    carrier_service.service_discovery = true
    carrier_service.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/carrier_services.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/carrier_services.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::CarrierService.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/carrier_services.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-04/carrier_services/1036894964.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "carrier_service" => hash_including({id: 1036894964, name: "Some new name", active: false}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    carrier_service = ShopifyAPI::CarrierService.new
    carrier_service.id = 1036894964
    carrier_service.name = "Some new name"
    carrier_service.active = false
    carrier_service.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-04/carrier_services/1036894964.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/carrier_services/1036894966.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::CarrierService.find(
      id: 1036894966,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/carrier_services/1036894966.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-04/carrier_services/1036894967.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::CarrierService.delete(
      id: 1036894967,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-04/carrier_services/1036894967.json")
  end

end
