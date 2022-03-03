# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Dispute202110Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-10")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/shopify_payments/disputes.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Dispute.all(
      session: @test_session,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/shopify_payments/disputes.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/shopify_payments/disputes.json?status=won")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Dispute.all(
      session: @test_session,
      status: "won",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/shopify_payments/disputes.json?status=won")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/shopify_payments/disputes.json?initiated_at=2013-05-03")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Dispute.all(
      session: @test_session,
      initiated_at: "2013-05-03",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/shopify_payments/disputes.json?initiated_at=2013-05-03")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/shopify_payments/disputes/598735659.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Dispute.find(
      session: @test_session,
      id: 598735659,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/shopify_payments/disputes/598735659.json")
  end

end
