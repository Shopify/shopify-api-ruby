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

class InventoryLevel202204Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/inventory_levels.json?location_ids=655441491")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"inventory_levels" => [{"inventory_item_id" => 49148385, "location_id" => 655441491, "available" => 2, "updated_at" => "2023-02-02T09:56:58-05:00", "admin_graphql_api_id" => "gid://shopify/InventoryLevel/655441491?inventory_item_id=49148385"}, {"inventory_item_id" => 808950810, "location_id" => 655441491, "available" => 1, "updated_at" => "2023-02-02T09:56:58-05:00", "admin_graphql_api_id" => "gid://shopify/InventoryLevel/655441491?inventory_item_id=808950810"}, {"inventory_item_id" => 457924702, "location_id" => 655441491, "available" => 4, "updated_at" => "2023-02-02T09:56:58-05:00", "admin_graphql_api_id" => "gid://shopify/InventoryLevel/655441491?inventory_item_id=457924702"}, {"inventory_item_id" => 39072856, "location_id" => 655441491, "available" => 3, "updated_at" => "2023-02-02T09:56:58-05:00", "admin_graphql_api_id" => "gid://shopify/InventoryLevel/655441491?inventory_item_id=39072856"}]}), headers: {})

    ShopifyAPI::InventoryLevel.all(
      location_ids: "655441491",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/inventory_levels.json?location_ids=655441491")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/inventory_levels.json?inventory_item_ids=808950810")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"inventory_levels" => [{"inventory_item_id" => 808950810, "location_id" => 487838322, "available" => 9, "updated_at" => "2023-02-02T09:56:58-05:00", "admin_graphql_api_id" => "gid://shopify/InventoryLevel/548380009?inventory_item_id=808950810"}, {"inventory_item_id" => 808950810, "location_id" => 655441491, "available" => 1, "updated_at" => "2023-02-02T09:56:58-05:00", "admin_graphql_api_id" => "gid://shopify/InventoryLevel/655441491?inventory_item_id=808950810"}]}), headers: {})

    ShopifyAPI::InventoryLevel.all(
      inventory_item_ids: "808950810",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/inventory_levels.json?inventory_item_ids=808950810")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/inventory_levels.json?inventory_item_ids=808950810%2C39072856&location_ids=655441491%2C487838322")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"inventory_levels" => [{"inventory_item_id" => 808950810, "location_id" => 487838322, "available" => 9, "updated_at" => "2023-02-02T09:56:58-05:00", "admin_graphql_api_id" => "gid://shopify/InventoryLevel/548380009?inventory_item_id=808950810"}, {"inventory_item_id" => 39072856, "location_id" => 487838322, "available" => 27, "updated_at" => "2023-02-02T09:56:58-05:00", "admin_graphql_api_id" => "gid://shopify/InventoryLevel/548380009?inventory_item_id=39072856"}, {"inventory_item_id" => 808950810, "location_id" => 655441491, "available" => 1, "updated_at" => "2023-02-02T09:56:58-05:00", "admin_graphql_api_id" => "gid://shopify/InventoryLevel/655441491?inventory_item_id=808950810"}, {"inventory_item_id" => 39072856, "location_id" => 655441491, "available" => 3, "updated_at" => "2023-02-02T09:56:58-05:00", "admin_graphql_api_id" => "gid://shopify/InventoryLevel/655441491?inventory_item_id=39072856"}]}), headers: {})

    ShopifyAPI::InventoryLevel.all(
      inventory_item_ids: "808950810,39072856",
      location_ids: "655441491,487838322",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/inventory_levels.json?inventory_item_ids=808950810%2C39072856&location_ids=655441491%2C487838322")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/inventory_levels/adjust.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({"location_id" => 655441491, "inventory_item_id" => 808950810, "available_adjustment" => 5})
      )
      .to_return(status: 200, body: JSON.generate({"inventory_level" => {"inventory_item_id" => 808950810, "location_id" => 655441491, "available" => 6, "updated_at" => "2023-02-02T10:00:24-05:00", "admin_graphql_api_id" => "gid://shopify/InventoryLevel/655441491?inventory_item_id=808950810"}}), headers: {})

    inventory_level = ShopifyAPI::InventoryLevel.new

    inventory_level.adjust(
      body: {"location_id" => 655441491, "inventory_item_id" => 808950810, "available_adjustment" => 5},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/inventory_levels/adjust.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-04/inventory_levels.json?inventory_item_id=808950810&location_id=655441491")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::InventoryLevel.delete(
      inventory_item_id: "808950810",
      location_id: "655441491",
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-04/inventory_levels.json?inventory_item_id=808950810&location_id=655441491")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/inventory_levels/connect.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({"location_id" => 844681632, "inventory_item_id" => 457924702})
      )
      .to_return(status: 200, body: JSON.generate({"inventory_level" => {"inventory_item_id" => 457924702, "location_id" => 844681632, "available" => 0, "updated_at" => "2023-02-02T10:00:35-05:00", "admin_graphql_api_id" => "gid://shopify/InventoryLevel/844681632?inventory_item_id=457924702"}}), headers: {})

    inventory_level = ShopifyAPI::InventoryLevel.new

    inventory_level.connect(
      body: {"location_id" => 844681632, "inventory_item_id" => 457924702},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/inventory_levels/connect.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/inventory_levels/set.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({"location_id" => 655441491, "inventory_item_id" => 808950810, "available" => 42})
      )
      .to_return(status: 200, body: JSON.generate({"inventory_level" => {"inventory_item_id" => 808950810, "location_id" => 655441491, "available" => 42, "updated_at" => "2023-02-02T10:00:50-05:00", "admin_graphql_api_id" => "gid://shopify/InventoryLevel/655441491?inventory_item_id=808950810"}}), headers: {})

    inventory_level = ShopifyAPI::InventoryLevel.new

    inventory_level.set(
      body: {"location_id" => 655441491, "inventory_item_id" => 808950810, "available" => 42},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/inventory_levels/set.json")
  end

end
