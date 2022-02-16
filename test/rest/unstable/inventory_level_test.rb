# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class InventoryLevelUnstableTest < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "unstable")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/unstable/inventory_levels.json?inventory_item_ids=808950810%2C39072856&location_ids=655441491%2C487838322")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::InventoryLevel.all(
      session: @test_session,
      inventory_item_ids: "808950810,39072856",
      location_ids: "655441491,487838322",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/unstable/inventory_levels.json?inventory_item_ids=808950810%2C39072856&location_ids=655441491%2C487838322")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/unstable/inventory_levels.json?inventory_item_ids=808950810")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::InventoryLevel.all(
      session: @test_session,
      inventory_item_ids: "808950810",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/unstable/inventory_levels.json?inventory_item_ids=808950810")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/unstable/inventory_levels.json?location_ids=655441491")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::InventoryLevel.all(
      session: @test_session,
      location_ids: "655441491",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/unstable/inventory_levels.json?location_ids=655441491")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/unstable/inventory_levels/adjust.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({location_id: 655441491, inventory_item_id: 808950810, available_adjustment: 5})
      )
      .to_return(status: 200, body: "{}", headers: {})

    inventory_level = ShopifyAPI::InventoryLevel.new(session: @test_session)

    inventory_level.adjust(
      body: {location_id: 655441491, inventory_item_id: 808950810, available_adjustment: 5},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/unstable/inventory_levels/adjust.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/unstable/inventory_levels.json?inventory_item_id=808950810&location_id=655441491")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::InventoryLevel.delete(
      session: @test_session,
      inventory_item_id: "808950810",
      location_id: "655441491",
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/unstable/inventory_levels.json?inventory_item_id=808950810&location_id=655441491")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/unstable/inventory_levels/connect.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({location_id: 844681632, inventory_item_id: 457924702})
      )
      .to_return(status: 200, body: "{}", headers: {})

    inventory_level = ShopifyAPI::InventoryLevel.new(session: @test_session)

    inventory_level.connect(
      body: {location_id: 844681632, inventory_item_id: 457924702},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/unstable/inventory_levels/connect.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/unstable/inventory_levels/set.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({location_id: 655441491, inventory_item_id: 808950810, available: 42})
      )
      .to_return(status: 200, body: "{}", headers: {})

    inventory_level = ShopifyAPI::InventoryLevel.new(session: @test_session)

    inventory_level.set(
      body: {location_id: 655441491, inventory_item_id: 808950810, available: 42},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/unstable/inventory_levels/set.json")
  end

end
