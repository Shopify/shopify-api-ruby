# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class StorefrontAccessToken202110Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2021-10")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-10/storefront_access_tokens.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "storefront_access_token" => hash_including({"title" => "Test"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    storefront_access_token = ShopifyAPI::StorefrontAccessToken.new
    storefront_access_token.title = "Test"
    storefront_access_token.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-10/storefront_access_tokens.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/storefront_access_tokens.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::StorefrontAccessToken.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/storefront_access_tokens.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-10/storefront_access_tokens/755357713.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::StorefrontAccessToken.delete(
      id: 755357713,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-10/storefront_access_tokens/755357713.json")
  end

end
