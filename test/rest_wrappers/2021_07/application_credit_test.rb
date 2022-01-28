# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class ApplicationCredit202107Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-07")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/application_credits.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "application_credit" => hash_including({description: "application credit for refund", amount: 5.0, test: true}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    application_credit = ShopifyAPI::ApplicationCredit.new(session: @test_session)
    application_credit.description = "application credit for refund"
    application_credit.amount = 5.0
    application_credit.test = true
    application_credit.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/application_credits.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/application_credits.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "application_credit" => hash_including({description: "application credit for refund", amount: 5.0}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    application_credit = ShopifyAPI::ApplicationCredit.new(session: @test_session)
    application_credit.description = "application credit for refund"
    application_credit.amount = 5.0
    application_credit.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/application_credits.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/application_credits.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::ApplicationCredit.all(
      session: @test_session,
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/application_credits.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/application_credits/140583599.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::ApplicationCredit.find(
      session: @test_session,
      id: "140583599",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/application_credits/140583599.json")
  end

end
