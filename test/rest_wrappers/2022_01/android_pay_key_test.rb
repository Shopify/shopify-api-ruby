# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class AndroidPayKey202201Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2022-01")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/android_pay_keys.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "android_pay_key" => hash_including({}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    android_pay_key = ShopifyAPI::AndroidPayKey.new(session: @test_session)

    android_pay_key.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/android_pay_keys.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/android_pay_keys/964811896.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::AndroidPayKey.find(
      session: @test_session,
      id: "964811896",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/android_pay_keys/964811896.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/android_pay_keys/964811894.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::AndroidPayKey.delete(
      session: @test_session,
      id: "964811894",
    )

    assert_requested(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/android_pay_keys/964811894.json")
  end

end
