# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class CountryUnstableTest < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "unstable")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/countries.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Country.all(
      session: @test_session,
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/countries.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/countries.json?since_id=359115488")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Country.all(
      session: @test_session,
      since_id: "359115488",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/countries.json?since_id=359115488")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/countries.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "country" => hash_including({code: "FR", tax: 0.2}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    country = ShopifyAPI::Country.new(session: @test_session)
    country.code = "FR"
    country.tax = 0.2
    country.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/countries.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/countries.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "country" => hash_including({code: "FR"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    country = ShopifyAPI::Country.new(session: @test_session)
    country.code = "FR"
    country.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/countries.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/countries/count.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Country.count(
      session: @test_session,
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/countries/count.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/countries/879921427.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Country.find(
      session: @test_session,
      id: "879921427",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/countries/879921427.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/countries/879921427.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "country" => hash_including({id: 879921427, tax: 0.05}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    country = ShopifyAPI::Country.new(session: @test_session)
    country.id = 879921427
    country.tax = 0.05
    country.save()

    assert_requested(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/countries/879921427.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/countries/879921427.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Country.delete(
      session: @test_session,
      id: "879921427",
    )

    assert_requested(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/countries/879921427.json")
  end

end
