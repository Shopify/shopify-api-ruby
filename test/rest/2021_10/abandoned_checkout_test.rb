# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class AbandonedCheckout202110Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::AbandonedCheckout.checkouts()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts.json?status=closed")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::AbandonedCheckout.checkouts(
      status: "closed",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts.json?status=closed")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts.json?created_at_max=2013-10-12T07%3A05%3A27-02%3A00")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::AbandonedCheckout.checkouts(
      created_at_max: "2013-10-12T07:05:27-02:00",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts.json?created_at_max=2013-10-12T07%3A05%3A27-02%3A00")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts.json?limit=1")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::AbandonedCheckout.checkouts(
      limit: "1",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts.json?limit=1")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts.json?status=closed")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::AbandonedCheckout.checkouts(
      status: "closed",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts.json?status=closed")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts.json?created_at_max=2013-10-12T07%3A05%3A27-02%3A00")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::AbandonedCheckout.checkouts(
      created_at_max: "2013-10-12T07:05:27-02:00",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts.json?created_at_max=2013-10-12T07%3A05%3A27-02%3A00")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::AbandonedCheckout.checkouts()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts.json")
  end

end
