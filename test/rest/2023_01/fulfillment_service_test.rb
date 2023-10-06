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

class FulfillmentService202301Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2023-01")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/fulfillment_services.json?scope=all")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_services" => [{"id" => 611870435, "name" => "Venus Fulfillment", "email" => nil, "service_name" => "Venus Fulfillment", "handle" => "venus-fulfillment", "fulfillment_orders_opt_in" => false, "include_pending_stock" => false, "provider_id" => nil, "location_id" => 611870435, "callback_url" => nil, "tracking_support" => true, "inventory_management" => true, "admin_graphql_api_id" => "gid://shopify/ApiFulfillmentService/611870435"}, {"id" => 755357713, "name" => "Mars Fulfillment", "email" => nil, "service_name" => "Mars Fulfillment", "handle" => "mars-fulfillment", "fulfillment_orders_opt_in" => true, "include_pending_stock" => false, "provider_id" => nil, "location_id" => 24826418, "callback_url" => "http://google.com/", "tracking_support" => true, "inventory_management" => true, "admin_graphql_api_id" => "gid://shopify/ApiFulfillmentService/755357713"}]}), headers: {})

    response = ShopifyAPI::FulfillmentService.all(
      scope: "all",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/fulfillment_services.json?scope=all")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/fulfillment_services.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_services" => [{"id" => 755357713, "name" => "Mars Fulfillment", "email" => nil, "service_name" => "Mars Fulfillment", "handle" => "mars-fulfillment", "fulfillment_orders_opt_in" => true, "include_pending_stock" => false, "provider_id" => nil, "location_id" => 24826418, "callback_url" => "http://google.com/", "tracking_support" => true, "inventory_management" => true, "admin_graphql_api_id" => "gid://shopify/ApiFulfillmentService/755357713"}]}), headers: {})

    response = ShopifyAPI::FulfillmentService.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/fulfillment_services.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-01/fulfillment_services.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_service" => hash_including({"name" => "Jupiter Fulfillment", "callback_url" => "http://google.com", "inventory_management" => true, "tracking_support" => true, "requires_shipping_method" => true, "format" => "json", "permits_sku_sharing" => true, "fulfillment_orders_opt_in" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_service" => {"id" => 1061774488, "name" => "Jupiter Fulfillment", "email" => nil, "service_name" => "Jupiter Fulfillment", "handle" => "jupiter-fulfillment", "fulfillment_orders_opt_in" => true, "include_pending_stock" => false, "provider_id" => nil, "location_id" => 1072404545, "callback_url" => "http://google.com/", "tracking_support" => true, "inventory_management" => true, "admin_graphql_api_id" => "gid://shopify/ApiFulfillmentService/1061774488", "permits_sku_sharing" => true}}), headers: {})

    response = fulfillment_service = ShopifyAPI::FulfillmentService.new
    fulfillment_service.name = "Jupiter Fulfillment"
    fulfillment_service.callback_url = "http://google.com"
    fulfillment_service.inventory_management = true
    fulfillment_service.tracking_support = true
    fulfillment_service.requires_shipping_method = true
    fulfillment_service.format = "json"
    fulfillment_service.permits_sku_sharing = true
    fulfillment_service.fulfillment_orders_opt_in = true
    fulfillment_service.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-01/fulfillment_services.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/fulfillment_services/755357713.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_service" => {"id" => 755357713, "name" => "Mars Fulfillment", "email" => nil, "service_name" => "Mars Fulfillment", "handle" => "mars-fulfillment", "fulfillment_orders_opt_in" => true, "include_pending_stock" => false, "provider_id" => nil, "location_id" => 24826418, "callback_url" => "http://google.com/", "tracking_support" => true, "inventory_management" => true, "admin_graphql_api_id" => "gid://shopify/ApiFulfillmentService/755357713"}}), headers: {})

    response = ShopifyAPI::FulfillmentService.find(
      id: 755357713,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/fulfillment_services/755357713.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_5()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2023-01/fulfillment_services/755357713.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_service" => hash_including({"name" => "New Fulfillment Service Name"}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_service" => {"id" => 755357713, "name" => "New Fulfillment Service Name", "email" => nil, "service_name" => "New Fulfillment Service Name", "handle" => "mars-fulfillment", "fulfillment_orders_opt_in" => true, "include_pending_stock" => false, "provider_id" => nil, "location_id" => 24826418, "callback_url" => "http://google.com/", "tracking_support" => true, "inventory_management" => true, "admin_graphql_api_id" => "gid://shopify/ApiFulfillmentService/755357713"}}), headers: {})

    response = fulfillment_service = ShopifyAPI::FulfillmentService.new
    fulfillment_service.id = 755357713
    fulfillment_service.name = "New Fulfillment Service Name"
    fulfillment_service.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2023-01/fulfillment_services/755357713.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_6()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2023-01/fulfillment_services/755357713.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    response = ShopifyAPI::FulfillmentService.delete(
      id: 755357713,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2023-01/fulfillment_services/755357713.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

end
