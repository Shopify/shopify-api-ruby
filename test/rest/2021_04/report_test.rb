# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Report202104Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/reports.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Report.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/reports.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/reports.json?ids=517154478")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Report.all(
      ids: "517154478",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/reports.json?ids=517154478")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/reports.json?updated_at_min=2005-07-31+15%3A57%3A11+EDT+-04%3A00")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Report.all(
      updated_at_min: "2005-07-31 15:57:11 EDT -04:00",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/reports.json?updated_at_min=2005-07-31+15%3A57%3A11+EDT+-04%3A00")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/reports.json?fields=id%2Cshopify_ql")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Report.all(
      fields: "id,shopify_ql",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/reports.json?fields=id%2Cshopify_ql")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/reports.json?since_id=123")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Report.all(
      since_id: "123",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/reports.json?since_id=123")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/reports.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "report" => hash_including({name: "A new app report", shopify_ql: "SHOW total_sales BY order_id FROM sales SINCE -1m UNTIL today ORDER BY total_sales"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    report = ShopifyAPI::Report.new
    report.name = "A new app report"
    report.shopify_ql = "SHOW total_sales BY order_id FROM sales SINCE -1m UNTIL today ORDER BY total_sales"
    report.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/reports.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/reports/517154478.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Report.find(
      id: 517154478,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/reports/517154478.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/reports/517154478.json?fields=id%2Cshopify_ql")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Report.find(
      id: 517154478,
      fields: "id,shopify_ql",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/reports/517154478.json?fields=id%2Cshopify_ql")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-04/reports/517154478.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "report" => hash_including({id: 517154478, name: "Changed Report Name", shopify_ql: "SHOW total_sales BY order_id FROM sales SINCE -12m UNTIL today ORDER BY total_sales"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    report = ShopifyAPI::Report.new
    report.id = 517154478
    report.name = "Changed Report Name"
    report.shopify_ql = "SHOW total_sales BY order_id FROM sales SINCE -12m UNTIL today ORDER BY total_sales"
    report.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-04/reports/517154478.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-04/reports/517154478.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Report.delete(
      id: 517154478,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-04/reports/517154478.json")
  end

end
