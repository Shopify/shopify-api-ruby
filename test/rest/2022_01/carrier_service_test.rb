# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class CarrierService202201Test < Test::Unit::TestCase
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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/carrier_services.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "carrier_service" => hash_including({"name" => "Shipping Rate Provider", "callback_url" => "http://shippingrateprovider.com", "service_discovery" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"carrier_service" => {"id" => 1036894963, "name" => "Shipping Rate Provider", "active" => true, "service_discovery" => true, "carrier_service_type" => "api", "admin_graphql_api_id" => "gid://shopify/DeliveryCarrierService/1036894963", "format" => "json", "callback_url" => "http://shippingrateprovider.com/"}}), headers: {})

    carrier_service = ShopifyAPI::CarrierService.new
    carrier_service.name = "Shipping Rate Provider"
    carrier_service.callback_url = "http://shippingrateprovider.com"
    carrier_service.service_discovery = true
    carrier_service.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/carrier_services.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/carrier_services.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"carrier_services" => [{"id" => 1036894965, "name" => "Purolator", "active" => true, "service_discovery" => true, "carrier_service_type" => "api", "admin_graphql_api_id" => "gid://shopify/DeliveryCarrierService/1036894965", "format" => "json", "callback_url" => "http://example.com/"}, {"id" => 260046840, "name" => "ups_shipping", "active" => true, "service_discovery" => true, "carrier_service_type" => "legacy", "admin_graphql_api_id" => "gid://shopify/DeliveryCarrierService/260046840"}]}), headers: {})

    ShopifyAPI::CarrierService.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/carrier_services.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-01/carrier_services/1036894964.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "carrier_service" => hash_including({"id" => 1036894964, "name" => "Some new name", "active" => false}) }
      )
      .to_return(status: 200, body: JSON.generate({"carrier_service" => {"active" => false, "id" => 1036894964, "name" => "Some new name", "service_discovery" => true, "carrier_service_type" => "api", "admin_graphql_api_id" => "gid://shopify/DeliveryCarrierService/1036894964", "format" => "json", "callback_url" => "http://example.com/"}}), headers: {})

    carrier_service = ShopifyAPI::CarrierService.new
    carrier_service.id = 1036894964
    carrier_service.name = "Some new name"
    carrier_service.active = false
    carrier_service.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-01/carrier_services/1036894964.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/carrier_services/1036894966.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"carrier_service" => {"id" => 1036894966, "name" => "Purolator", "active" => true, "service_discovery" => true, "carrier_service_type" => "api", "admin_graphql_api_id" => "gid://shopify/DeliveryCarrierService/1036894966", "format" => "json", "callback_url" => "http://example.com/"}}), headers: {})

    ShopifyAPI::CarrierService.find(
      id: 1036894966,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/carrier_services/1036894966.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-01/carrier_services/1036894967.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::CarrierService.delete(
      id: 1036894967,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-01/carrier_services/1036894967.json")
  end

end
