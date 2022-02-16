# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Province202107Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-07")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427/provinces.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Province.all(
      session: @test_session,
      country_id: 879921427,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427/provinces.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427/provinces.json?since_id=536137098")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Province.all(
      session: @test_session,
      country_id: 879921427,
      since_id: "536137098",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427/provinces.json?since_id=536137098")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427/provinces/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Province.count(
      session: @test_session,
      country_id: 879921427,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427/provinces/count.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427/provinces/224293623.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Province.find(
      session: @test_session,
      country_id: 879921427,
      id: 224293623,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427/provinces/224293623.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427/provinces/224293623.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "province" => hash_including({id: 224293623, tax: 0.09}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    province = ShopifyAPI::Province.new(session: @test_session)
    province.country_id = 879921427
    province.id = 224293623
    province.tax = 0.09
    province.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/countries/879921427/provinces/224293623.json")
  end

end
