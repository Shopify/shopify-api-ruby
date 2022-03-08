# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Refund202104Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/orders/450789469/refunds.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Refund.all(
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/orders/450789469/refunds.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/orders/450789469/refunds.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "refund" => hash_including({"currency" => "USD", "notify" => true, "note" => "wrong size", "shipping" => {"full_refund" => true}, "refund_line_items" => [{"line_item_id" => 518995019, "quantity" => 1, "restock_type" => "return", "location_id" => 487838322}], "transactions" => [{"parent_id" => 801038806, "amount" => 41.94, "kind" => "refund", "gateway" => "bogus"}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    refund = ShopifyAPI::Refund.new
    refund.order_id = 450789469
    refund.currency = "USD"
    refund.notify = true
    refund.note = "wrong size"
    refund.shipping = {
      "full_refund" => true
    }
    refund.refund_line_items = [
      {
        "line_item_id" => 518995019,
        "quantity" => 1,
        "restock_type" => "return",
        "location_id" => 487838322
      }
    ]
    refund.transactions = [
      {
        "parent_id" => 801038806,
        "amount" => 41.94,
        "kind" => "refund",
        "gateway" => "bogus"
      }
    ]
    refund.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/orders/450789469/refunds.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/orders/450789469/refunds.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "refund" => hash_including({"currency" => "USD", "shipping" => {"amount" => 5.0}, "transactions" => [{"parent_id" => 801038806, "amount" => 5.0, "kind" => "refund", "gateway" => "bogus"}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    refund = ShopifyAPI::Refund.new
    refund.order_id = 450789469
    refund.currency = "USD"
    refund.shipping = {
      "amount" => 5.0
    }
    refund.transactions = [
      {
        "parent_id" => 801038806,
        "amount" => 5.0,
        "kind" => "refund",
        "gateway" => "bogus"
      }
    ]
    refund.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/orders/450789469/refunds.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/orders/450789469/refunds/509562969.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Refund.find(
      order_id: 450789469,
      id: 509562969,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/orders/450789469/refunds/509562969.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/orders/450789469/refunds/calculate.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "refund" => hash_including({"shipping" => {"full_refund" => true}, "refund_line_items" => [{"line_item_id" => 518995019, "quantity" => 1, "restock_type" => "no_restock"}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    refund = ShopifyAPI::Refund.new
    refund.order_id = 450789469
    refund.calculate(
      body: {"refund" => {"shipping" => {"full_refund" => true}, "refund_line_items" => [{"line_item_id" => 518995019, "quantity" => 1, "restock_type" => "no_restock"}]}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/orders/450789469/refunds/calculate.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/orders/450789469/refunds/calculate.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "refund" => hash_including({"currency" => "USD", "shipping" => {"full_refund" => true}, "refund_line_items" => [{"line_item_id" => 518995019, "quantity" => 1, "restock_type" => "no_restock"}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    refund = ShopifyAPI::Refund.new
    refund.order_id = 450789469
    refund.calculate(
      body: {"refund" => {"currency" => "USD", "shipping" => {"full_refund" => true}, "refund_line_items" => [{"line_item_id" => 518995019, "quantity" => 1, "restock_type" => "no_restock"}]}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/orders/450789469/refunds/calculate.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/orders/450789469/refunds/calculate.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "refund" => hash_including({"currency" => "USD", "shipping" => {"amount" => 2.0}}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    refund = ShopifyAPI::Refund.new
    refund.order_id = 450789469
    refund.calculate(
      body: {"refund" => {"currency" => "USD", "shipping" => {"amount" => 2.0}}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/orders/450789469/refunds/calculate.json")
  end

end
