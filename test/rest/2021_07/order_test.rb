# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Order202107Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-07")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json?status=any")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Order.all(
      session: @test_session,
      status: "any",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json?status=any")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json?ids=1073459980")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Order.all(
      session: @test_session,
      ids: "1073459980",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json?ids=1073459980")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json?financial_status=authorized")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Order.all(
      session: @test_session,
      financial_status: "authorized",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json?financial_status=authorized")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json?updated_at_min=2005-07-31T15%3A57%3A11-04%3A00")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Order.all(
      session: @test_session,
      updated_at_min: "2005-07-31T15:57:11-04:00",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json?updated_at_min=2005-07-31T15%3A57%3A11-04%3A00")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json?fields=created_at%2Cid%2Cname%2Ctotal-price")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Order.all(
      session: @test_session,
      fields: "created_at,id,name,total-price",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json?fields=created_at%2Cid%2Cname%2Ctotal-price")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json?since_id=123")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Order.all(
      session: @test_session,
      since_id: "123",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json?since_id=123")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Order.find(
      session: @test_session,
      id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json?fields=id%2Cline_items%2Cname%2Ctotal_price")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Order.find(
      session: @test_session,
      id: 450789469,
      fields: "id,line_items,name,total_price",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json?fields=id%2Cline_items%2Cname%2Ctotal_price")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "order" => hash_including({"id" => 450789469, "note" => "Customer contacted us about a custom engraving on this iPod"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.id = 450789469
    order.note = "Customer contacted us about a custom engraving on this iPod"
    order.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "order" => hash_including({"id" => 450789469, "note_attributes" => [{"name" => "colour", "value" => "red"}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.id = 450789469
    order.note_attributes = [
      {
        "name" => "colour",
        "value" => "red"
      }
    ]
    order.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "order" => hash_including({"id" => 450789469, "email" => "a-different@email.com"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.id = 450789469
    order.email = "a-different@email.com"
    order.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
  end

  sig do
    void
  end
  def test_12()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "order" => hash_including({"id" => 450789469, "phone" => " 15145556677"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.id = 450789469
    order.phone = " 15145556677"
    order.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
  end

  sig do
    void
  end
  def test_13()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "order" => hash_including({"id" => 450789469, "buyer_accepts_marketing" => true}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.id = 450789469
    order.buyer_accepts_marketing = true
    order.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
  end

  sig do
    void
  end
  def test_14()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "order" => hash_including({"id" => 450789469, "shipping_address" => {"address1" => "123 Ship Street", "city" => "Shipsville"}}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.id = 450789469
    order.shipping_address = {
      "address1" => "123 Ship Street",
      "city" => "Shipsville"
    }
    order.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
  end

  sig do
    void
  end
  def test_15()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "order" => hash_including({"id" => 450789469, "customer" => nil}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.id = 450789469
    order.customer = nil
    order.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
  end

  sig do
    void
  end
  def test_16()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "order" => hash_including({"id" => 450789469, "tags" => "External, Inbound, Outbound"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.id = 450789469
    order.tags = "External, Inbound, Outbound"
    order.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
  end

  sig do
    void
  end
  def test_17()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "order" => hash_including({"id" => 450789469, "metafields" => [{"key" => "new", "value" => "newvalue", "type" => "single_line_text_field", "namespace" => "global"}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.id = 450789469
    order.metafields = [
      {
        "key" => "new",
        "value" => "newvalue",
        "type" => "single_line_text_field",
        "namespace" => "global"
      }
    ]
    order.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
  end

  sig do
    void
  end
  def test_18()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Order.delete(
      session: @test_session,
      id: 450789469,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469.json")
  end

  sig do
    void
  end
  def test_19()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders/count.json?status=any")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Order.count(
      session: @test_session,
      status: "any",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders/count.json?status=any")
  end

  sig do
    void
  end
  def test_20()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders/count.json?financial_status=authorized")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Order.count(
      session: @test_session,
      financial_status: "authorized",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders/count.json?financial_status=authorized")
  end

  sig do
    void
  end
  def test_21()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/close.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.id = 450789469
    order.close()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/close.json")
  end

  sig do
    void
  end
  def test_22()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/open.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.id = 450789469
    order.open()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/open.json")
  end

  sig do
    void
  end
  def test_23()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/cancel.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.id = 450789469
    order.cancel()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/cancel.json")
  end

  sig do
    void
  end
  def test_24()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/cancel.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({"amount" => "10.00", "currency" => "USD"})
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.id = 450789469
    order.cancel(
      body: {"amount" => "10.00", "currency" => "USD"},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/cancel.json")
  end

  sig do
    void
  end
  def test_25()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/cancel.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({"refund" => {"note" => "Customer made a mistake", "shipping" => {"full_refund" => true}, "refund_line_items" => [{"line_item_id" => 466157049, "quantity" => 1, "restock_type" => "cancel", "location_id" => 24826418}], "transactions" => [{"parent_id" => 1068278509, "amount" => "10.00", "kind" => "refund", "gateway" => "bogus"}, {"parent_id" => 1068278510, "amount" => "100.00", "kind" => "refund", "gateway" => "gift_card"}]}})
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.id = 450789469
    order.cancel(
      body: {"refund" => {"note" => "Customer made a mistake", "shipping" => {"full_refund" => true}, "refund_line_items" => [{"line_item_id" => 466157049, "quantity" => 1, "restock_type" => "cancel", "location_id" => 24826418}], "transactions" => [{"parent_id" => 1068278509, "amount" => "10.00", "kind" => "refund", "gateway" => "bogus"}, {"parent_id" => 1068278510, "amount" => "100.00", "kind" => "refund", "gateway" => "gift_card"}]}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/cancel.json")
  end

  sig do
    void
  end
  def test_26()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "order" => hash_including({"line_items" => [{"variant_id" => 447654529, "quantity" => 1}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.line_items = [
      {
        "variant_id" => 447654529,
        "quantity" => 1
      }
    ]
    order.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json")
  end

  sig do
    void
  end
  def test_27()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "order" => hash_including({"email" => "foo@example.com", "fulfillment_status" => "fulfilled", "send_receipt" => true, "send_fulfillment_receipt" => true, "line_items" => [{"variant_id" => 457924702, "quantity" => 1}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.email = "foo@example.com"
    order.fulfillment_status = "fulfilled"
    order.send_receipt = true
    order.send_fulfillment_receipt = true
    order.line_items = [
      {
        "variant_id" => 457924702,
        "quantity" => 1
      }
    ]
    order.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json")
  end

  sig do
    void
  end
  def test_28()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "order" => hash_including({"email" => "foo@example.com", "fulfillment_status" => "fulfilled", "line_items" => [{"variant_id" => 447654529, "quantity" => 1}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.email = "foo@example.com"
    order.fulfillment_status = "fulfilled"
    order.line_items = [
      {
        "variant_id" => 447654529,
        "quantity" => 1
      }
    ]
    order.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json")
  end

  sig do
    void
  end
  def test_29()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "order" => hash_including({"email" => "foo@example.com", "fulfillment_status" => "fulfilled", "fulfillments" => [{"location_id" => 24826418}], "line_items" => [{"variant_id" => 447654529, "quantity" => 1}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.email = "foo@example.com"
    order.fulfillment_status = "fulfilled"
    order.fulfillments = [
      {
        "location_id" => 24826418
      }
    ]
    order.line_items = [
      {
        "variant_id" => 447654529,
        "quantity" => 1
      }
    ]
    order.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json")
  end

  sig do
    void
  end
  def test_30()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "order" => hash_including({"line_items" => [{"title" => "Big Brown Bear Boots", "price" => 74.99, "grams" => "1300", "quantity" => 3, "tax_lines" => [{"price" => 13.5, "rate" => 0.06, "title" => "State tax"}]}], "transactions" => [{"kind" => "sale", "status" => "success", "amount" => 238.47}], "total_tax" => 13.5, "currency" => "EUR"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.line_items = [
      {
        "title" => "Big Brown Bear Boots",
        "price" => 74.99,
        "grams" => "1300",
        "quantity" => 3,
        "tax_lines" => [
            {
                  "price" => 13.5,
                  "rate" => 0.06,
                  "title" => "State tax"
                }
          ]
      }
    ]
    order.transactions = [
      {
        "kind" => "sale",
        "status" => "success",
        "amount" => 238.47
      }
    ]
    order.total_tax = 13.5
    order.currency = "EUR"
    order.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json")
  end

  sig do
    void
  end
  def test_31()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "order" => hash_including({"line_items" => [{"title" => "Red Leather Coat", "price" => 129.99, "grams" => "1700", "quantity" => 1}, {"title" => "Blue Suede Shoes", "price" => 85.95, "grams" => "750", "quantity" => 1, "taxable" => false}, {"title" => "Raspberry Beret", "price" => 19.99, "grams" => "320", "quantity" => 2}], "tax_lines" => [{"price" => 10.2, "rate" => 0.06, "title" => "State tax"}, {"price" => 4.25, "rate" => 0.025, "title" => "County tax"}], "total_tax" => 14.45}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.line_items = [
      {
        "title" => "Red Leather Coat",
        "price" => 129.99,
        "grams" => "1700",
        "quantity" => 1
      },
      {
        "title" => "Blue Suede Shoes",
        "price" => 85.95,
        "grams" => "750",
        "quantity" => 1,
        "taxable" => false
      },
      {
        "title" => "Raspberry Beret",
        "price" => 19.99,
        "grams" => "320",
        "quantity" => 2
      }
    ]
    order.tax_lines = [
      {
        "price" => 10.2,
        "rate" => 0.06,
        "title" => "State tax"
      },
      {
        "price" => 4.25,
        "rate" => 0.025,
        "title" => "County tax"
      }
    ]
    order.total_tax = 14.45
    order.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json")
  end

  sig do
    void
  end
  def test_32()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "order" => hash_including({"line_items" => [{"variant_id" => 447654529, "quantity" => 1}], "customer" => {"id" => 207119551}, "financial_status" => "pending"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.line_items = [
      {
        "variant_id" => 447654529,
        "quantity" => 1
      }
    ]
    order.customer = {
      "id" => 207119551
    }
    order.financial_status = "pending"
    order.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json")
  end

  sig do
    void
  end
  def test_33()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "order" => hash_including({"line_items" => [{"variant_id" => 447654529, "quantity" => 1}], "customer" => {"first_name" => "Paul", "last_name" => "Norman", "email" => "paul.norman@example.com"}, "billing_address" => {"first_name" => "John", "last_name" => "Smith", "address1" => "123 Fake Street", "phone" => "555-555-5555", "city" => "Fakecity", "province" => "Ontario", "country" => "Canada", "zip" => "K2P 1L4"}, "shipping_address" => {"first_name" => "Jane", "last_name" => "Smith", "address1" => "123 Fake Street", "phone" => "777-777-7777", "city" => "Fakecity", "province" => "Ontario", "country" => "Canada", "zip" => "K2P 1L4"}, "email" => "jane@example.com", "transactions" => [{"kind" => "authorization", "status" => "success", "amount" => 50.0}], "financial_status" => "partially_paid"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.line_items = [
      {
        "variant_id" => 447654529,
        "quantity" => 1
      }
    ]
    order.customer = {
      "first_name" => "Paul",
      "last_name" => "Norman",
      "email" => "paul.norman@example.com"
    }
    order.billing_address = {
      "first_name" => "John",
      "last_name" => "Smith",
      "address1" => "123 Fake Street",
      "phone" => "555-555-5555",
      "city" => "Fakecity",
      "province" => "Ontario",
      "country" => "Canada",
      "zip" => "K2P 1L4"
    }
    order.shipping_address = {
      "first_name" => "Jane",
      "last_name" => "Smith",
      "address1" => "123 Fake Street",
      "phone" => "777-777-7777",
      "city" => "Fakecity",
      "province" => "Ontario",
      "country" => "Canada",
      "zip" => "K2P 1L4"
    }
    order.email = "jane@example.com"
    order.transactions = [
      {
        "kind" => "authorization",
        "status" => "success",
        "amount" => 50.0
      }
    ]
    order.financial_status = "partially_paid"
    order.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json")
  end

  sig do
    void
  end
  def test_34()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "order" => hash_including({"line_items" => [{"variant_id" => 447654529, "quantity" => 1}], "email" => "jane@example.com", "phone" => "18885551234", "billing_address" => {"first_name" => "John", "last_name" => "Smith", "address1" => "123 Fake Street", "phone" => "555-555-5555", "city" => "Fakecity", "province" => "Ontario", "country" => "Canada", "zip" => "K2P 1L4"}, "shipping_address" => {"first_name" => "Jane", "last_name" => "Smith", "address1" => "123 Fake Street", "phone" => "777-777-7777", "city" => "Fakecity", "province" => "Ontario", "country" => "Canada", "zip" => "K2P 1L4"}, "transactions" => [{"kind" => "sale", "status" => "success", "amount" => 50.0}], "financial_status" => "paid", "discount_codes" => [{"code" => "FAKE30", "amount" => "9.00", "type" => "percentage"}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    order = ShopifyAPI::Order.new(session: @test_session)
    order.line_items = [
      {
        "variant_id" => 447654529,
        "quantity" => 1
      }
    ]
    order.email = "jane@example.com"
    order.phone = "18885551234"
    order.billing_address = {
      "first_name" => "John",
      "last_name" => "Smith",
      "address1" => "123 Fake Street",
      "phone" => "555-555-5555",
      "city" => "Fakecity",
      "province" => "Ontario",
      "country" => "Canada",
      "zip" => "K2P 1L4"
    }
    order.shipping_address = {
      "first_name" => "Jane",
      "last_name" => "Smith",
      "address1" => "123 Fake Street",
      "phone" => "777-777-7777",
      "city" => "Fakecity",
      "province" => "Ontario",
      "country" => "Canada",
      "zip" => "K2P 1L4"
    }
    order.transactions = [
      {
        "kind" => "sale",
        "status" => "success",
        "amount" => 50.0
      }
    ]
    order.financial_status = "paid"
    order.discount_codes = [
      {
        "code" => "FAKE30",
        "amount" => "9.00",
        "type" => "percentage"
      }
    ]
    order.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders.json")
  end

end
