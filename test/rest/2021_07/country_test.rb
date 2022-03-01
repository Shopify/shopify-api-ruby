# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Country202107Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2021-07")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Country.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries.json?since_id=359115488")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Country.all(
      since_id: "359115488",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries.json?since_id=359115488")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/countries.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "country" => hash_including({code: "FR"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    country = ShopifyAPI::Country.new
    country.code = "FR"
    country.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/countries.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/countries.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "country" => hash_including({code: "FR", tax: 0.2}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    country = ShopifyAPI::Country.new
    country.code = "FR"
    country.tax = 0.2
    country.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/countries.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Country.count()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries/count.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Country.find(
      id: 879921427,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "country" => hash_including({id: 879921427, tax: 0.05}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    country = ShopifyAPI::Country.new
    country.id = 879921427
    country.tax = 0.05
    country.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Country.delete(
      id: 879921427,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427.json")
  end

end
