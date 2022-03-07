# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class DraftOrder202107Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-07")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "draft_order" => hash_including({"line_items" => [{"variant_id" => 447654529, "quantity" => 1}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    draft_order = ShopifyAPI::DraftOrder.new(session: @test_session)
    draft_order.line_items = [
      {
        "variant_id" => 447654529,
        "quantity" => 1
      }
    ]
    draft_order.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "draft_order" => hash_including({"line_items" => [{"title" => "Custom Tee", "price" => "20.00", "quantity" => 2}], "applied_discount" => {"description" => "Custom discount", "value_type" => "fixed_amount", "value" => "10.0", "amount" => "10.00", "title" => "Custom"}, "customer" => {"id" => 207119551}, "use_customer_default_address" => true}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    draft_order = ShopifyAPI::DraftOrder.new(session: @test_session)
    draft_order.line_items = [
      {
        "title" => "Custom Tee",
        "price" => "20.00",
        "quantity" => 2
      }
    ]
    draft_order.applied_discount = {
      "description" => "Custom discount",
      "value_type" => "fixed_amount",
      "value" => "10.0",
      "amount" => "10.00",
      "title" => "Custom"
    }
    draft_order.customer = {
      "id" => 207119551
    }
    draft_order.use_customer_default_address = true
    draft_order.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "draft_order" => hash_including({"line_items" => [{"title" => "Custom Tee", "price" => "20.00", "quantity" => 1, "applied_discount" => {"description" => "Custom discount", "value_type" => "fixed_amount", "value" => "10.0", "amount" => "10.0", "title" => "Custom"}}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    draft_order = ShopifyAPI::DraftOrder.new(session: @test_session)
    draft_order.line_items = [
      {
        "title" => "Custom Tee",
        "price" => "20.00",
        "quantity" => 1,
        "applied_discount" => {
            "description" => "Custom discount",
            "value_type" => "fixed_amount",
            "value" => "10.0",
            "amount" => "10.0",
            "title" => "Custom"
          }
      }
    ]
    draft_order.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "draft_order" => hash_including({"line_items" => [{"title" => "Custom Tee", "price" => "20.00", "quantity" => 1, "applied_discount" => {"description" => "Custom discount", "value_type" => "percentage", "value" => "10.0", "amount" => "2.0", "title" => "Custom"}}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    draft_order = ShopifyAPI::DraftOrder.new(session: @test_session)
    draft_order.line_items = [
      {
        "title" => "Custom Tee",
        "price" => "20.00",
        "quantity" => 1,
        "applied_discount" => {
            "description" => "Custom discount",
            "value_type" => "percentage",
            "value" => "10.0",
            "amount" => "2.0",
            "title" => "Custom"
          }
      }
    ]
    draft_order.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "draft_order" => hash_including({"line_items" => [{"title" => "Custom Tee", "price" => "20.00", "quantity" => 2}], "customer" => {"id" => 207119551}, "use_customer_default_address" => true}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    draft_order = ShopifyAPI::DraftOrder.new(session: @test_session)
    draft_order.line_items = [
      {
        "title" => "Custom Tee",
        "price" => "20.00",
        "quantity" => 2
      }
    ]
    draft_order.customer = {
      "id" => 207119551
    }
    draft_order.use_customer_default_address = true
    draft_order.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::DraftOrder.all(
      session: @test_session,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/994118539.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "draft_order" => hash_including({"id" => 994118539, "note" => "Customer contacted us about a custom engraving on this iPod"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    draft_order = ShopifyAPI::DraftOrder.new(session: @test_session)
    draft_order.id = 994118539
    draft_order.note = "Customer contacted us about a custom engraving on this iPod"
    draft_order.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/994118539.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/994118539.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "draft_order" => hash_including({"id" => 994118539, "applied_discount" => {"description" => "Custom discount", "value_type" => "percentage", "value" => "10.0", "amount" => "19.90", "title" => "Custom"}}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    draft_order = ShopifyAPI::DraftOrder.new(session: @test_session)
    draft_order.id = 994118539
    draft_order.applied_discount = {
      "description" => "Custom discount",
      "value_type" => "percentage",
      "value" => "10.0",
      "amount" => "19.90",
      "title" => "Custom"
    }
    draft_order.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/994118539.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/994118539.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::DraftOrder.find(
      session: @test_session,
      id: 994118539,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/994118539.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/994118539.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::DraftOrder.delete(
      session: @test_session,
      id: 994118539,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/994118539.json")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::DraftOrder.count(
      session: @test_session,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/count.json")
  end

  sig do
    void
  end
  def test_12()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/994118539/send_invoice.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({"draft_order_invoice" => {"to" => "first@example.com", "from" => "j.smith@example.com", "bcc" => ["j.smith@example.com"], "subject" => "Apple Computer Invoice", "custom_message" => "Thank you for ordering!"}})
      )
      .to_return(status: 200, body: "{}", headers: {})

    draft_order = ShopifyAPI::DraftOrder.new(session: @test_session)
    draft_order.id = 994118539
    draft_order.send_invoice(
      body: {"draft_order_invoice" => {"to" => "first@example.com", "from" => "j.smith@example.com", "bcc" => ["j.smith@example.com"], "subject" => "Apple Computer Invoice", "custom_message" => "Thank you for ordering!"}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/994118539/send_invoice.json")
  end

  sig do
    void
  end
  def test_13()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/994118539/send_invoice.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({"draft_order_invoice" => {}})
      )
      .to_return(status: 200, body: "{}", headers: {})

    draft_order = ShopifyAPI::DraftOrder.new(session: @test_session)
    draft_order.id = 994118539
    draft_order.send_invoice(
      body: {"draft_order_invoice" => {}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/994118539/send_invoice.json")
  end

  sig do
    void
  end
  def test_14()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/994118539/complete.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    draft_order = ShopifyAPI::DraftOrder.new(session: @test_session)
    draft_order.id = 994118539
    draft_order.complete()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/994118539/complete.json")
  end

  sig do
    void
  end
  def test_15()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/994118539/complete.json?payment_pending=true")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    draft_order = ShopifyAPI::DraftOrder.new(session: @test_session)
    draft_order.id = 994118539
    draft_order.complete(
      payment_pending: "true",
    )

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/994118539/complete.json?payment_pending=true")
  end

end
