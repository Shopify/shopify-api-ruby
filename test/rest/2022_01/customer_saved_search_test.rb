# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class CustomerSavedSearch202201Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-01")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/customer_saved_searches.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::CustomerSavedSearch.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/customer_saved_searches.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/customer_saved_searches.json?since_id=20610973")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::CustomerSavedSearch.all(
      since_id: "20610973",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/customer_saved_searches.json?since_id=20610973")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/customer_saved_searches.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer_saved_search" => hash_including({"name" => "Spent more than $50", "query" => "total_spent:>50"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    customer_saved_search = ShopifyAPI::CustomerSavedSearch.new
    customer_saved_search.name = "Spent more than $50"
    customer_saved_search.query = "total_spent:>50"
    customer_saved_search.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/customer_saved_searches.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/customer_saved_searches.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer_saved_search" => hash_including({"name" => "Spent more than $50 and after 2013", "query" => "total_spent:>50 order_date:>=2013-01-01"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    customer_saved_search = ShopifyAPI::CustomerSavedSearch.new
    customer_saved_search.name = "Spent more than $50 and after 2013"
    customer_saved_search.query = "total_spent:>50 order_date:>=2013-01-01"
    customer_saved_search.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/customer_saved_searches.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/customer_saved_searches/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::CustomerSavedSearch.count()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/customer_saved_searches/count.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/customer_saved_searches/count.json?since_id=20610973")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::CustomerSavedSearch.count(
      since_id: "20610973",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/customer_saved_searches/count.json?since_id=20610973")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/customer_saved_searches/789629109.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::CustomerSavedSearch.find(
      id: 789629109,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/customer_saved_searches/789629109.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-01/customer_saved_searches/789629109.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer_saved_search" => hash_including({"id" => 789629109, "name" => "This Name Has Been Changed"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    customer_saved_search = ShopifyAPI::CustomerSavedSearch.new
    customer_saved_search.id = 789629109
    customer_saved_search.name = "This Name Has Been Changed"
    customer_saved_search.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-01/customer_saved_searches/789629109.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-01/customer_saved_searches/789629109.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::CustomerSavedSearch.delete(
      id: 789629109,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-01/customer_saved_searches/789629109.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/customer_saved_searches/789629109/customers.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::CustomerSavedSearch.customers(
      id: 789629109,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/customer_saved_searches/789629109/customers.json")
  end

end
