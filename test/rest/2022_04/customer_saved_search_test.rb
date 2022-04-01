# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class CustomerSavedSearch202204Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-04")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/customer_saved_searches.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"customer_saved_searches" => [{"id" => 789629109, "name" => "Accepts Marketing", "created_at" => "2022-03-04T10:52:46-05:00", "updated_at" => "2022-03-04T10:52:46-05:00", "query" => "accepts_marketing:1"}, {"id" => 20610973, "name" => "Canadian Snowboarders", "created_at" => "2022-03-04T10:52:46-05:00", "updated_at" => "2022-03-04T10:52:46-05:00", "query" => "country:Canada"}, {"id" => 669439218, "name" => "Premier Customers", "created_at" => "2022-03-04T10:52:46-05:00", "updated_at" => "2022-03-04T10:52:46-05:00", "query" => "John Smith orders_count:>10 total_spent:>100.00"}]}), headers: {})

    ShopifyAPI::CustomerSavedSearch.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/customer_saved_searches.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/customer_saved_searches.json?since_id=20610973")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"customer_saved_searches" => [{"id" => 669439218, "name" => "Premier Customers", "created_at" => "2022-03-04T10:52:46-05:00", "updated_at" => "2022-03-04T10:52:46-05:00", "query" => "John Smith orders_count:>10 total_spent:>100.00"}, {"id" => 789629109, "name" => "Accepts Marketing", "created_at" => "2022-03-04T10:52:46-05:00", "updated_at" => "2022-03-04T10:52:46-05:00", "query" => "accepts_marketing:1"}]}), headers: {})

    ShopifyAPI::CustomerSavedSearch.all(
      since_id: "20610973",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/customer_saved_searches.json?since_id=20610973")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/customer_saved_searches.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer_saved_search" => hash_including({"name" => "Spent more than $50", "query" => "total_spent:>50"}) }
      )
      .to_return(status: 200, body: JSON.generate({"customer_saved_search" => {"id" => 1068136102, "name" => "Spent more than $50", "created_at" => "2022-03-11T10:53:32-05:00", "updated_at" => "2022-03-11T10:53:32-05:00", "query" => "total_spent:>50"}}), headers: {})

    customer_saved_search = ShopifyAPI::CustomerSavedSearch.new
    customer_saved_search.name = "Spent more than $50"
    customer_saved_search.query = "total_spent:>50"
    customer_saved_search.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/customer_saved_searches.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/customer_saved_searches.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer_saved_search" => hash_including({"name" => "Spent more than $50 and after 2013", "query" => "total_spent:>50 order_date:>=2013-01-01"}) }
      )
      .to_return(status: 200, body: JSON.generate({"customer_saved_search" => {"id" => 1068136103, "name" => "Spent more than $50 and after 2013", "created_at" => "2022-03-11T10:53:34-05:00", "updated_at" => "2022-03-11T10:53:34-05:00", "query" => "total_spent:>50 order_date:>=2013-01-01"}}), headers: {})

    customer_saved_search = ShopifyAPI::CustomerSavedSearch.new
    customer_saved_search.name = "Spent more than $50 and after 2013"
    customer_saved_search.query = "total_spent:>50 order_date:>=2013-01-01"
    customer_saved_search.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/customer_saved_searches.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/customer_saved_searches/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 3}), headers: {})

    ShopifyAPI::CustomerSavedSearch.count()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/customer_saved_searches/count.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/customer_saved_searches/count.json?since_id=20610973")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 2}), headers: {})

    ShopifyAPI::CustomerSavedSearch.count(
      since_id: "20610973",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/customer_saved_searches/count.json?since_id=20610973")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/customer_saved_searches/789629109.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"customer_saved_search" => {"id" => 789629109, "name" => "Accepts Marketing", "created_at" => "2022-03-04T10:52:46-05:00", "updated_at" => "2022-03-04T10:52:46-05:00", "query" => "accepts_marketing:1"}}), headers: {})

    ShopifyAPI::CustomerSavedSearch.find(
      id: 789629109,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/customer_saved_searches/789629109.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-04/customer_saved_searches/789629109.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "customer_saved_search" => hash_including({"id" => 789629109, "name" => "This Name Has Been Changed"}) }
      )
      .to_return(status: 200, body: JSON.generate({"customer_saved_search" => {"name" => "This Name Has Been Changed", "id" => 789629109, "created_at" => "2022-03-04T10:52:46-05:00", "updated_at" => "2022-03-11T10:53:35-05:00", "query" => "accepts_marketing:1"}}), headers: {})

    customer_saved_search = ShopifyAPI::CustomerSavedSearch.new
    customer_saved_search.id = 789629109
    customer_saved_search.name = "This Name Has Been Changed"
    customer_saved_search.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-04/customer_saved_searches/789629109.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-04/customer_saved_searches/789629109.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::CustomerSavedSearch.delete(
      id: 789629109,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-04/customer_saved_searches/789629109.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/customer_saved_searches/789629109/customers.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"customers" => [{"id" => 207119551, "email" => "bob.norman@hostmail.com", "accepts_marketing" => true, "created_at" => "2022-03-11T10:52:46-05:00", "updated_at" => "2022-03-11T10:53:46-05:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "phone" => " 16136120707", "tags" => "", "last_order_name" => "#1001", "currency" => "USD", "addresses" => [{"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}], "accepts_marketing_updated_at" => "2022-03-11T10:53:46-05:00", "marketing_opt_in_level" => "single_opt_in", "tax_exemptions" => [], "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => nil, "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}]}), headers: {})

    ShopifyAPI::CustomerSavedSearch.customers(
      id: 789629109,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/customer_saved_searches/789629109/customers.json")
  end

end
