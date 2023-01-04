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

class CarrierService202204Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-04")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/carrier_services.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "carrier_service" => hash_including({"name" => "Shipping Rate Provider", "callback_url" => "http://shipping.example.com", "service_discovery" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"carrier_service" => {"id" => 1067451814, "name" => "Shipping Rate Provider", "active" => true, "service_discovery" => true, "carrier_service_type" => "api", "admin_graphql_api_id" => "gid://shopify/DeliveryCarrierService/1067451814", "format" => "json", "callback_url" => "http://shipping.example.com/"}}), headers: {})

    carrier_service = ShopifyAPI::CarrierService.new
    carrier_service.name = "Shipping Rate Provider"
    carrier_service.callback_url = "http://shipping.example.com"
    carrier_service.service_discovery = true
    carrier_service.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/carrier_services.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/carrier_services.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"carrier_services" => [{"id" => 1067451817, "name" => "Purolator", "active" => true, "service_discovery" => true, "carrier_service_type" => "api", "admin_graphql_api_id" => "gid://shopify/DeliveryCarrierService/1067451817", "format" => "json", "callback_url" => "http://example.com/"}, {"id" => 260046840, "name" => "ups_shipping", "active" => true, "service_discovery" => true, "carrier_service_type" => "legacy", "admin_graphql_api_id" => "gid://shopify/DeliveryCarrierService/260046840"}]}), headers: {})

    ShopifyAPI::CarrierService.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/carrier_services.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-04/carrier_services/1067451815.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "carrier_service" => hash_including({"name" => "Some new name", "active" => false}) }
      )
      .to_return(status: 200, body: JSON.generate({"carrier_service" => {"active" => false, "id" => 1067451815, "name" => "Some new name", "service_discovery" => true, "carrier_service_type" => "api", "admin_graphql_api_id" => "gid://shopify/DeliveryCarrierService/1067451815", "format" => "json", "callback_url" => "http://example.com/"}}), headers: {})

    carrier_service = ShopifyAPI::CarrierService.new
    carrier_service.id = 1067451815
    carrier_service.name = "Some new name"
    carrier_service.active = false
    carrier_service.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-04/carrier_services/1067451815.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/carrier_services/1067451816.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"carrier_service" => {"id" => 1067451816, "name" => "Purolator", "active" => true, "service_discovery" => true, "carrier_service_type" => "api", "admin_graphql_api_id" => "gid://shopify/DeliveryCarrierService/1067451816", "format" => "json", "callback_url" => "http://example.com/"}}), headers: {})

    ShopifyAPI::CarrierService.find(
      id: 1067451816,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/carrier_services/1067451816.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-04/carrier_services/1067451812.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::CarrierService.delete(
      id: 1067451812,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-04/carrier_services/1067451812.json")
  end

end
