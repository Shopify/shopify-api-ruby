# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class PaymentUnstableTest < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "unstable")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/unstable/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x/payments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "payment" => hash_including({request_details: {ip_address: "123.1.1.1", accept_language: "en-US,en;q=0.8,fr;q=0.6", user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36"}, amount: "398.00", session_id: "global-4f10a3a42a3b4d41", unique_token: "client-side-idempotency-token"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    payment = ShopifyAPI::Payment.new(session: @test_session)
    payment.checkout_id = "7yjf4v2we7gamku6a6h7tvm8h3mmvs4x"
    payment.request_details = {
      ip_address: "123.1.1.1",
      accept_language: "en-US,en;q=0.8,fr;q=0.6",
      user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36"
    }
    payment.amount = "398.00"
    payment.session_id = "global-4f10a3a42a3b4d41"
    payment.unique_token = "client-side-idempotency-token"
    payment.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/unstable/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x/payments.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/unstable/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x/payments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Payment.all(
      session: @test_session,
      checkout_id: "7yjf4v2we7gamku6a6h7tvm8h3mmvs4x",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/unstable/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x/payments.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/unstable/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x/payments/25428999.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Payment.find(
      session: @test_session,
      checkout_id: "7yjf4v2we7gamku6a6h7tvm8h3mmvs4x",
      id: 25428999,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/unstable/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x/payments/25428999.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/unstable/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x/payments/25428999.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Payment.find(
      session: @test_session,
      checkout_id: "7yjf4v2we7gamku6a6h7tvm8h3mmvs4x",
      id: 25428999,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/unstable/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x/payments/25428999.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/unstable/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x/payments/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Payment.count(
      session: @test_session,
      checkout_id: "7yjf4v2we7gamku6a6h7tvm8h3mmvs4x",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/unstable/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x/payments/count.json")
  end

end
