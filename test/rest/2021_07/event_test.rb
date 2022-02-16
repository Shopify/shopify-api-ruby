# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Event202107Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-07")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/events.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.all(
      session: @test_session,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/events.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/events.json?created_at_min=2008-01-10+12%3A30%3A00%2B00%3A00")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.all(
      session: @test_session,
      created_at_min: "2008-01-10 12:30:00+00:00",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/events.json?created_at_min=2008-01-10+12%3A30%3A00%2B00%3A00")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/events.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.all(
      session: @test_session,
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/events.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/events.json?limit=1&since_id=164748010")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.all(
      session: @test_session,
      order_id: 450789469,
      limit: "1",
      since_id: "164748010",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/events.json?limit=1&since_id=164748010")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/products/921728736/events.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.all(
      session: @test_session,
      product_id: 921728736,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/products/921728736/events.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/events.json?since_id=164748010")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.all(
      session: @test_session,
      since_id: "164748010",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/events.json?since_id=164748010")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/events.json?filter=Product%2COrder")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.all(
      session: @test_session,
      filter: "Product,Order",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/events.json?filter=Product%2COrder")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/events.json?filter=Product&verb=destroy")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.all(
      session: @test_session,
      filter: "Product",
      verb: "destroy",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/events.json?filter=Product&verb=destroy")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/events/677313116.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.find(
      session: @test_session,
      id: 677313116,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/events/677313116.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/events/count.json?created_at_min=2008-01-10T13%3A00%3A00%2B00%3A00")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.count(
      session: @test_session,
      created_at_min: "2008-01-10T13:00:00+00:00",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/events/count.json?created_at_min=2008-01-10T13%3A00%3A00%2B00%3A00")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/events/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.count(
      session: @test_session,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/events/count.json")
  end

end
