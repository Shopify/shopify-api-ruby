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

class Location202301Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/locations.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"locations" => [{"id" => 655441491, "name" => "50 Rideau Street", "address1" => "50 Rideau Street", "address2" => nil, "city" => "Ottawa", "zip" => "K1N 9J7", "province" => "Ontario", "country" => "CA", "phone" => nil, "created_at" => "2023-02-02T09:53:49-05:00", "updated_at" => "2023-02-02T09:53:49-05:00", "country_code" => "CA", "country_name" => "Canada", "province_code" => "ON", "legacy" => false, "active" => true, "admin_graphql_api_id" => "gid://shopify/Location/655441491", "localized_country_name" => "Canada", "localized_province_name" => "Ontario"}, {"id" => 24826418, "name" => "Apple Api Shipwire", "address1" => nil, "address2" => nil, "city" => nil, "zip" => nil, "province" => nil, "country" => "DE", "phone" => nil, "created_at" => "2023-02-02T09:53:49-05:00", "updated_at" => "2023-02-02T09:53:49-05:00", "country_code" => "DE", "country_name" => "Germany", "province_code" => nil, "legacy" => true, "active" => true, "admin_graphql_api_id" => "gid://shopify/Location/24826418", "localized_country_name" => "Germany", "localized_province_name" => nil}, {"id" => 844681632, "name" => "Apple Cupertino", "address1" => nil, "address2" => nil, "city" => nil, "zip" => nil, "province" => nil, "country" => "US", "phone" => nil, "created_at" => "2023-02-02T09:53:49-05:00", "updated_at" => "2023-02-02T09:53:49-05:00", "country_code" => "US", "country_name" => "United States", "province_code" => nil, "legacy" => false, "active" => true, "admin_graphql_api_id" => "gid://shopify/Location/844681632", "localized_country_name" => "United States", "localized_province_name" => nil}, {"id" => 611870435, "name" => "Apple Shipwire", "address1" => nil, "address2" => nil, "city" => nil, "zip" => nil, "province" => nil, "country" => "DE", "phone" => nil, "created_at" => "2023-02-02T09:53:49-05:00", "updated_at" => "2023-02-02T09:53:49-05:00", "country_code" => "DE", "country_name" => "Germany", "province_code" => nil, "legacy" => true, "active" => true, "admin_graphql_api_id" => "gid://shopify/Location/611870435", "localized_country_name" => "Germany", "localized_province_name" => nil}, {"id" => 487838322, "name" => "Fifth Avenue AppleStore", "address1" => nil, "address2" => nil, "city" => nil, "zip" => nil, "province" => nil, "country" => "US", "phone" => nil, "created_at" => "2023-02-02T09:53:49-05:00", "updated_at" => "2023-02-02T09:53:49-05:00", "country_code" => "US", "country_name" => "United States", "province_code" => nil, "legacy" => false, "active" => true, "admin_graphql_api_id" => "gid://shopify/Location/487838322", "localized_country_name" => "United States", "localized_province_name" => nil}]}), headers: {})

    ShopifyAPI::Location.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/locations.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/locations/487838322.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"location" => {"id" => 487838322, "name" => "Fifth Avenue AppleStore", "address1" => nil, "address2" => nil, "city" => nil, "zip" => nil, "province" => nil, "country" => "US", "phone" => nil, "created_at" => "2023-02-02T09:53:49-05:00", "updated_at" => "2023-02-02T09:53:49-05:00", "country_code" => "US", "country_name" => "United States", "province_code" => nil, "legacy" => false, "active" => true, "admin_graphql_api_id" => "gid://shopify/Location/487838322"}}), headers: {})

    ShopifyAPI::Location.find(
      id: 487838322,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/locations/487838322.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/locations/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 5}), headers: {})

    ShopifyAPI::Location.count

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/locations/count.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/locations/487838322/inventory_levels.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"inventory_levels" => [{"inventory_item_id" => 49148385, "location_id" => 487838322, "available" => 18, "updated_at" => "2023-02-02T09:53:49-05:00", "admin_graphql_api_id" => "gid://shopify/InventoryLevel/548380009?inventory_item_id=49148385"}, {"inventory_item_id" => 808950810, "location_id" => 487838322, "available" => 9, "updated_at" => "2023-02-02T09:53:49-05:00", "admin_graphql_api_id" => "gid://shopify/InventoryLevel/548380009?inventory_item_id=808950810"}, {"inventory_item_id" => 457924702, "location_id" => 487838322, "available" => 36, "updated_at" => "2023-02-02T09:53:49-05:00", "admin_graphql_api_id" => "gid://shopify/InventoryLevel/548380009?inventory_item_id=457924702"}, {"inventory_item_id" => 39072856, "location_id" => 487838322, "available" => 27, "updated_at" => "2023-02-02T09:53:49-05:00", "admin_graphql_api_id" => "gid://shopify/InventoryLevel/548380009?inventory_item_id=39072856"}]}), headers: {})

    ShopifyAPI::Location.inventory_levels(
      id: 487838322,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/locations/487838322/inventory_levels.json")
  end

end
