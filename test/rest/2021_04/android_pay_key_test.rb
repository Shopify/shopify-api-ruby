# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class AndroidPayKey202104Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2021-04")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/android_pay_keys.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "android_pay_key" => hash_including({}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    android_pay_key = ShopifyAPI::AndroidPayKey.new

    android_pay_key.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/android_pay_keys.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/android_pay_keys/964811897.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::AndroidPayKey.find(
      id: 964811897,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/android_pay_keys/964811897.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-04/android_pay_keys/964811898.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::AndroidPayKey.delete(
      id: 964811898,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-04/android_pay_keys/964811898.json")
  end

end
