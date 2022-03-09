# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class StorefrontAccessToken202201Test < Test::Unit::TestCase
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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/storefront_access_tokens.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "storefront_access_token" => hash_including({"title" => "Test"}) }
      )
      .to_return(status: 200, body: JSON.generate({"storefront_access_token" => {"access_token" => "0db00803dd4e5b98676e060f7997d07f", "access_scope" => "unauthenticated_read_product_listings", "created_at" => "2022-02-03T17:16:52-05:00", "id" => 1003304191, "admin_graphql_api_id" => "gid://shopify/StorefrontAccessToken/1003304191", "title" => "Test"}}), headers: {})

    storefront_access_token = ShopifyAPI::StorefrontAccessToken.new
    storefront_access_token.title = "Test"
    storefront_access_token.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/storefront_access_tokens.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/storefront_access_tokens.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"storefront_access_tokens" => [{"access_token" => "378d95641257a4ab3feff967ee234f4d", "access_scope" => "unauthenticated_read_product_listings", "created_at" => "2022-02-03T17:14:40-05:00", "id" => 755357713, "admin_graphql_api_id" => "gid://shopify/StorefrontAccessToken/755357713", "title" => "API Client Extension"}]}), headers: {})

    ShopifyAPI::StorefrontAccessToken.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/storefront_access_tokens.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-01/storefront_access_tokens/755357713.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::StorefrontAccessToken.delete(
      id: 755357713,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-01/storefront_access_tokens/755357713.json")
  end

end
