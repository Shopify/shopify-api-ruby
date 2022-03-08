# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class CollectionListing202201Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/collection_listings.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::CollectionListing.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/collection_listings.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/collection_listings/841564295/product_ids.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::CollectionListing.product_ids(
      collection_id: 841564295,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/collection_listings/841564295/product_ids.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/collection_listings/482865238.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::CollectionListing.find(
      collection_id: 482865238,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/collection_listings/482865238.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-01/collection_listings/482865238.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "collection_listing" => hash_including({"collection_id" => 482865238}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    collection_listing = ShopifyAPI::CollectionListing.new
    collection_listing.collection_id = 482865238
    collection_listing.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-01/collection_listings/482865238.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-01/collection_listings/482865238.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::CollectionListing.delete(
      collection_id: 482865238,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-01/collection_listings/482865238.json")
  end

end
