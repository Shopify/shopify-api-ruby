# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Report202110Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-10")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/reports.json?updated_at_min=2005-07-31+15%3A57%3A11+EDT+-04%3A00")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Report.all(
      session: @test_session,
      updated_at_min: "2005-07-31 15:57:11 EDT -04:00",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/reports.json?updated_at_min=2005-07-31+15%3A57%3A11+EDT+-04%3A00")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/reports.json?fields=id%2Cshopify_ql")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Report.all(
      session: @test_session,
      fields: "id,shopify_ql",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/reports.json?fields=id%2Cshopify_ql")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/reports.json?since_id=123")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Report.all(
      session: @test_session,
      since_id: "123",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/reports.json?since_id=123")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/reports.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Report.all(
      session: @test_session,
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/reports.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/reports.json?ids=517154478")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Report.all(
      session: @test_session,
      ids: "517154478",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/reports.json?ids=517154478")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/reports/517154478.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Report.find(
      session: @test_session,
      id: "517154478",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/reports/517154478.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/reports/517154478.json?fields=id%2Cshopify_ql")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Report.find(
      session: @test_session,
      id: "517154478",
      fields: "id,shopify_ql",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/reports/517154478.json?fields=id%2Cshopify_ql")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/reports/517154478.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "report" => hash_including({id: 517154478, name: "Changed Report Name", shopify_ql: "SHOW total_sales BY order_id FROM sales SINCE -12m UNTIL today ORDER BY total_sales"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    report = ShopifyAPI::Report.new(session: @test_session)
    report.id = 517154478
    report.name = "Changed Report Name"
    report.shopify_ql = "SHOW total_sales BY order_id FROM sales SINCE -12m UNTIL today ORDER BY total_sales"
    report.save()

    assert_requested(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/reports/517154478.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/reports/517154478.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Report.delete(
      session: @test_session,
      id: "517154478",
    )

    assert_requested(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/reports/517154478.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/reports.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "report" => hash_including({name: "A new app report", shopify_ql: "SHOW total_sales BY order_id FROM sales SINCE -1m UNTIL today ORDER BY total_sales"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    report = ShopifyAPI::Report.new(session: @test_session)
    report.name = "A new app report"
    report.shopify_ql = "SHOW total_sales BY order_id FROM sales SINCE -1m UNTIL today ORDER BY total_sales"
    report.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/reports.json")
  end

end
