# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class StorefrontAccessTokenUnstableTest < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "unstable")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/storefront_access_tokens.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "storefront_access_token" => hash_including({title: "Test"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    storefront_access_token = ShopifyAPI::StorefrontAccessToken.new(session: @test_session)
    storefront_access_token.title = "Test"
    storefront_access_token.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/storefront_access_tokens.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/storefront_access_tokens.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::StorefrontAccessToken.all(
      session: @test_session,
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/storefront_access_tokens.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/storefront_access_tokens/755357713.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::StorefrontAccessToken.delete(
      session: @test_session,
      id: "755357713",
    )

    assert_requested(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/storefront_access_tokens/755357713.json")
  end

end
