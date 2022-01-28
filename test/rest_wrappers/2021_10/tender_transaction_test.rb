# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class TenderTransaction202110Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-10")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/tender_transactions.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::TenderTransaction.all(
      session: @test_session,
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/tender_transactions.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/tender_transactions.json?since_id=1011222854")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::TenderTransaction.all(
      session: @test_session,
      since_id: "1011222854",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/tender_transactions.json?since_id=1011222854")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/tender_transactions.json?processed_at_min=2005-08-06+10%3A22%3A51+-0400")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::TenderTransaction.all(
      session: @test_session,
      processed_at_min: "2005-08-06 10:22:51 -0400",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/tender_transactions.json?processed_at_min=2005-08-06+10%3A22%3A51+-0400")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/tender_transactions.json?processed_at_max=2005-08-06+10%3A22%3A51+-0400")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::TenderTransaction.all(
      session: @test_session,
      processed_at_max: "2005-08-06 10:22:51 -0400",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/tender_transactions.json?processed_at_max=2005-08-06+10%3A22%3A51+-0400")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/tender_transactions.json?processed_at_max=2005-08-05+10%3A22%3A51+-0400")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::TenderTransaction.all(
      session: @test_session,
      processed_at_max: "2005-08-05 10:22:51 -0400",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/tender_transactions.json?processed_at_max=2005-08-05+10%3A22%3A51+-0400")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/tender_transactions.json?order=processed_at+ASC")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::TenderTransaction.all(
      session: @test_session,
      order: "processed_at ASC",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/tender_transactions.json?order=processed_at+ASC")
  end

end
