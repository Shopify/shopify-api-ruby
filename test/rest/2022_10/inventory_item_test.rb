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

class InventoryItem202210Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-10")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/inventory_items.json?ids=808950810%2C39072856%2C457924702")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"inventory_items" => [{"id" => 39072856, "sku" => "IPOD2008GREEN", "created_at" => "2022-10-03T13:07:13-04:00", "updated_at" => "2022-10-03T13:07:13-04:00", "requires_shipping" => true, "cost" => "25.00", "country_code_of_origin" => nil, "province_code_of_origin" => nil, "harmonized_system_code" => nil, "tracked" => true, "country_harmonized_system_codes" => [], "admin_graphql_api_id" => "gid://shopify/InventoryItem/39072856"}, {"id" => 457924702, "sku" => "IPOD2008BLACK", "created_at" => "2022-10-03T13:07:13-04:00", "updated_at" => "2022-10-03T13:07:13-04:00", "requires_shipping" => true, "cost" => "25.00", "country_code_of_origin" => nil, "province_code_of_origin" => nil, "harmonized_system_code" => nil, "tracked" => true, "country_harmonized_system_codes" => [], "admin_graphql_api_id" => "gid://shopify/InventoryItem/457924702"}, {"id" => 808950810, "sku" => "IPOD2008PINK", "created_at" => "2022-10-03T13:07:13-04:00", "updated_at" => "2022-10-03T13:07:13-04:00", "requires_shipping" => true, "cost" => "25.00", "country_code_of_origin" => nil, "province_code_of_origin" => nil, "harmonized_system_code" => nil, "tracked" => true, "country_harmonized_system_codes" => [], "admin_graphql_api_id" => "gid://shopify/InventoryItem/808950810"}]}), headers: {})

    ShopifyAPI::InventoryItem.all(
      ids: "808950810,39072856,457924702",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/inventory_items.json?ids=808950810%2C39072856%2C457924702")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/inventory_items/808950810.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"inventory_item" => {"id" => 808950810, "sku" => "IPOD2008PINK", "created_at" => "2022-10-03T13:07:13-04:00", "updated_at" => "2022-10-03T13:07:13-04:00", "requires_shipping" => true, "cost" => "25.00", "country_code_of_origin" => nil, "province_code_of_origin" => nil, "harmonized_system_code" => nil, "tracked" => true, "country_harmonized_system_codes" => [], "admin_graphql_api_id" => "gid://shopify/InventoryItem/808950810"}}), headers: {})

    ShopifyAPI::InventoryItem.find(
      id: 808950810,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/inventory_items/808950810.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-10/inventory_items/808950810.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "inventory_item" => hash_including({"sku" => "new sku"}) }
      )
      .to_return(status: 200, body: JSON.generate({"inventory_item" => {"id" => 808950810, "sku" => "new sku", "created_at" => "2022-10-03T13:07:13-04:00", "updated_at" => "2022-10-03T13:11:09-04:00", "requires_shipping" => true, "cost" => "25.00", "country_code_of_origin" => nil, "province_code_of_origin" => nil, "harmonized_system_code" => nil, "tracked" => true, "country_harmonized_system_codes" => [], "admin_graphql_api_id" => "gid://shopify/InventoryItem/808950810"}}), headers: {})

    inventory_item = ShopifyAPI::InventoryItem.new
    inventory_item.id = 808950810
    inventory_item.sku = "new sku"
    inventory_item.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-10/inventory_items/808950810.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-10/inventory_items/808950810.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "inventory_item" => hash_including({"cost" => "25.00"}) }
      )
      .to_return(status: 200, body: JSON.generate({"inventory_item" => {"id" => 808950810, "sku" => "IPOD2008PINK", "created_at" => "2022-10-03T13:07:13-04:00", "updated_at" => "2022-10-03T13:07:13-04:00", "requires_shipping" => true, "cost" => "25.00", "country_code_of_origin" => nil, "province_code_of_origin" => nil, "harmonized_system_code" => nil, "tracked" => true, "country_harmonized_system_codes" => [], "admin_graphql_api_id" => "gid://shopify/InventoryItem/808950810"}}), headers: {})

    inventory_item = ShopifyAPI::InventoryItem.new
    inventory_item.id = 808950810
    inventory_item.cost = "25.00"
    inventory_item.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-10/inventory_items/808950810.json")
  end

end
