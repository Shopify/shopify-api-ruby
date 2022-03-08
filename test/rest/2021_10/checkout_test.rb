# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Checkout202110Test < Test::Unit::TestCase
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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "checkout" => hash_including({"line_items" => [{"variant_id" => 39072856, "quantity" => 5}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    checkout = ShopifyAPI::Checkout.new
    checkout.line_items = [
      {
        "variant_id" => 39072856,
        "quantity" => 5
      }
    ]
    checkout.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "checkout" => hash_including({"email" => "me@example.com"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    checkout = ShopifyAPI::Checkout.new
    checkout.email = "me@example.com"
    checkout.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts/b490a9220cd14d7344024f4874f640a6/complete.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    checkout = ShopifyAPI::Checkout.new
    checkout.token = "b490a9220cd14d7344024f4874f640a6"
    checkout.complete()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts/b490a9220cd14d7344024f4874f640a6/complete.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts/bd5a8aa1ecd019dd3520ff791ee3a24c.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Checkout.find(
      token: "bd5a8aa1ecd019dd3520ff791ee3a24c",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts/bd5a8aa1ecd019dd3520ff791ee3a24c.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Checkout.find(
      token: "7yjf4v2we7gamku6a6h7tvm8h3mmvs4x",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Checkout.find(
      token: "exuw7apwoycchjuwtiqg8nytfhphr62a",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "checkout" => hash_including({"token" => "exuw7apwoycchjuwtiqg8nytfhphr62a", "email" => "john.smith@example.com", "shipping_address" => {"first_name" => "John", "last_name" => "Smith", "address1" => "126 York St.", "city" => "Los Angeles", "province_code" => "CA", "country_code" => "US", "phone" => "(123)456-7890", "zip" => "90002"}}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    checkout = ShopifyAPI::Checkout.new
    checkout.token = "exuw7apwoycchjuwtiqg8nytfhphr62a"
    checkout.email = "john.smith@example.com"
    checkout.shipping_address = {
      "first_name" => "John",
      "last_name" => "Smith",
      "address1" => "126 York St.",
      "city" => "Los Angeles",
      "province_code" => "CA",
      "country_code" => "US",
      "phone" => "(123)456-7890",
      "zip" => "90002"
    }
    checkout.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "checkout" => hash_including({"token" => "exuw7apwoycchjuwtiqg8nytfhphr62a", "shipping_line" => {"handle" => "shopify-Free Shipping-0.00"}}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    checkout = ShopifyAPI::Checkout.new
    checkout.token = "exuw7apwoycchjuwtiqg8nytfhphr62a"
    checkout.shipping_line = {
      "handle" => "shopify-Free Shipping-0.00"
    }
    checkout.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a/shipping_rates.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Checkout.shipping_rates(
      token: "exuw7apwoycchjuwtiqg8nytfhphr62a",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a/shipping_rates.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a/shipping_rates.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Checkout.shipping_rates(
      token: "exuw7apwoycchjuwtiqg8nytfhphr62a",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a/shipping_rates.json")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts/zs9ru89kuqcdagk8bz4r9hnxt22wwd42/shipping_rates.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Checkout.shipping_rates(
      token: "zs9ru89kuqcdagk8bz4r9hnxt22wwd42",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/checkouts/zs9ru89kuqcdagk8bz4r9hnxt22wwd42/shipping_rates.json")
  end

end
