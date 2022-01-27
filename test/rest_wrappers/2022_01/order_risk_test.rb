# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class OrderRisk202201Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2022-01")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/orders/450789469/risks.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "risk" => hash_including({message: "This order came from an anonymous proxy", recommendation: "cancel", score: 1.0, source: "External", cause_cancel: true, display: true}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    order_risk = ShopifyAPI::OrderRisk.new(session: @test_session)
    order_risk.order_id = 450789469
    order_risk.message = "This order came from an anonymous proxy"
    order_risk.recommendation = "cancel"
    order_risk.score = 1.0
    order_risk.source = "External"
    order_risk.cause_cancel = true
    order_risk.display = true
    order_risk.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/orders/450789469/risks.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/orders/450789469/risks.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::OrderRisk.all(
      session: @test_session,
      order_id: "450789469",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/orders/450789469/risks.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/orders/450789469/risks/284138680.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::OrderRisk.find(
      session: @test_session,
      order_id: "450789469",
      id: "284138680",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/orders/450789469/risks/284138680.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/orders/450789469/risks/284138680.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "risk" => hash_including({id: 284138680, message: "After further review, this is a legitimate order", recommendation: "accept", source: "External", cause_cancel: false, score: 0.0}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    order_risk = ShopifyAPI::OrderRisk.new(session: @test_session)
    order_risk.order_id = 450789469
    order_risk.id = 284138680
    order_risk.message = "After further review, this is a legitimate order"
    order_risk.recommendation = "accept"
    order_risk.source = "External"
    order_risk.cause_cancel = false
    order_risk.score = 0.0
    order_risk.save()

    assert_requested(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/orders/450789469/risks/284138680.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/orders/450789469/risks/284138680.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::OrderRisk.delete(
      session: @test_session,
      order_id: "450789469",
      id: "284138680",
    )

    assert_requested(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/2022-01/orders/450789469/risks/284138680.json")
  end

end
