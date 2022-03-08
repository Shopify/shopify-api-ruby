# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Event202104Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/events.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/events.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/events.json?created_at_min=2008-01-10+12%3A30%3A00%2B00%3A00")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.all(
      created_at_min: "2008-01-10 12:30:00+00:00",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/events.json?created_at_min=2008-01-10+12%3A30%3A00%2B00%3A00")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/orders/450789469/events.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.all(
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/orders/450789469/events.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/orders/450789469/events.json?limit=1&since_id=164748010")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.all(
      order_id: 450789469,
      limit: "1",
      since_id: "164748010",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/orders/450789469/events.json?limit=1&since_id=164748010")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products/921728736/events.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.all(
      product_id: 921728736,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products/921728736/events.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/events.json?since_id=164748010")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.all(
      since_id: "164748010",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/events.json?since_id=164748010")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/events.json?filter=Product%2COrder")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.all(
      filter: "Product,Order",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/events.json?filter=Product%2COrder")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/events.json?filter=Product&verb=destroy")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.all(
      filter: "Product",
      verb: "destroy",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/events.json?filter=Product&verb=destroy")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/events/677313116.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.find(
      id: 677313116,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/events/677313116.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/events/count.json?created_at_min=2008-01-10T13%3A00%3A00%2B00%3A00")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.count(
      created_at_min: "2008-01-10T13:00:00+00:00",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/events/count.json?created_at_min=2008-01-10T13%3A00%3A00%2B00%3A00")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/events/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Event.count()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/events/count.json")
  end

end
