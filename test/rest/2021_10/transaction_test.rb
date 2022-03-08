# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Transaction202110Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2021-10")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/transactions.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Transaction.all(
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/transactions.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/transactions.json?since_id=801038806")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Transaction.all(
      order_id: 450789469,
      since_id: "801038806",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/transactions.json?since_id=801038806")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/transactions.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "transaction" => hash_including({"currency" => "USD", "amount" => "10.00", "kind" => "capture", "parent_id" => 389404469}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    transaction = ShopifyAPI::Transaction.new
    transaction.order_id = 450789469
    transaction.currency = "USD"
    transaction.amount = "10.00"
    transaction.kind = "capture"
    transaction.parent_id = 389404469
    transaction.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/transactions.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/transactions.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "transaction" => hash_including({"currency" => "USD", "amount" => "10.00", "kind" => "void", "parent_id" => 389404469}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    transaction = ShopifyAPI::Transaction.new
    transaction.order_id = 450789469
    transaction.currency = "USD"
    transaction.amount = "10.00"
    transaction.kind = "void"
    transaction.parent_id = 389404469
    transaction.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/transactions.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/transactions.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "transaction" => hash_including({"currency" => "USD", "amount" => "10.00", "kind" => "capture", "parent_id" => 389404469, "test" => true}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    transaction = ShopifyAPI::Transaction.new
    transaction.order_id = 450789469
    transaction.currency = "USD"
    transaction.amount = "10.00"
    transaction.kind = "capture"
    transaction.parent_id = 389404469
    transaction.test = true
    transaction.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/transactions.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/transactions.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "transaction" => hash_including({"kind" => "capture", "authorization" => "authorization-key"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    transaction = ShopifyAPI::Transaction.new
    transaction.order_id = 450789469
    transaction.kind = "capture"
    transaction.authorization = "authorization-key"
    transaction.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/transactions.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/transactions/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Transaction.count(
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/transactions/count.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/transactions/389404469.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Transaction.find(
      order_id: 450789469,
      id: 389404469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/orders/450789469/transactions/389404469.json")
  end

end
