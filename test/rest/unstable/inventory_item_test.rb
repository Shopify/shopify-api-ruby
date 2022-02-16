# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class InventoryItemUnstableTest < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "unstable")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/unstable/inventory_items.json?ids=808950810%2C39072856%2C457924702")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::InventoryItem.all(
      session: @test_session,
      ids: "808950810,39072856,457924702",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/unstable/inventory_items.json?ids=808950810%2C39072856%2C457924702")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/unstable/inventory_items/808950810.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::InventoryItem.find(
      session: @test_session,
      id: 808950810,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/unstable/inventory_items/808950810.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/unstable/inventory_items/808950810.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "inventory_item" => hash_including({id: 808950810, sku: "new sku"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    inventory_item = ShopifyAPI::InventoryItem.new(session: @test_session)
    inventory_item.id = 808950810
    inventory_item.sku = "new sku"
    inventory_item.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/unstable/inventory_items/808950810.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/unstable/inventory_items/808950810.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "inventory_item" => hash_including({id: 808950810, cost: "25.00"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    inventory_item = ShopifyAPI::InventoryItem.new(session: @test_session)
    inventory_item.id = 808950810
    inventory_item.cost = "25.00"
    inventory_item.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/unstable/inventory_items/808950810.json")
  end

end
