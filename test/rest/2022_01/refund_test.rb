# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Refund202201Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-01")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/refunds.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"refunds" => [{"id" => 509562969, "order_id" => 450789469, "created_at" => "2022-03-02T19:40:00-05:00", "note" => "it broke during shipping", "user_id" => 548380009, "processed_at" => "2022-03-02T19:40:00-05:00", "restock" => true, "admin_graphql_api_id" => "gid://shopify/Refund/509562969", "refund_line_items" => [{"id" => 104689539, "quantity" => 1, "line_item_id" => 703073504, "location_id" => 487838322, "restock_type" => "legacy_restock", "subtotal" => 195.67, "total_tax" => 3.98, "subtotal_set" => {"shop_money" => {"amount" => "195.67", "currency_code" => "USD"}, "presentment_money" => {"amount" => "195.67", "currency_code" => "USD"}}, "total_tax_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "line_item" => {"id" => 703073504, "variant_id" => 457924702, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008BLACK", "variant_title" => "black", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - black", "variant_inventory_management" => "shopify", "properties" => [], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => nil, "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.33", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}}], "admin_graphql_api_id" => "gid://shopify/LineItem/703073504", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}}, {"id" => 709875399, "quantity" => 1, "line_item_id" => 466157049, "location_id" => 487838322, "restock_type" => "legacy_restock", "subtotal" => 195.66, "total_tax" => 3.98, "subtotal_set" => {"shop_money" => {"amount" => "195.66", "currency_code" => "USD"}, "presentment_money" => {"amount" => "195.66", "currency_code" => "USD"}}, "total_tax_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "line_item" => {"id" => 466157049, "variant_id" => 39072856, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008GREEN", "variant_title" => "green", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - green", "variant_inventory_management" => "shopify", "properties" => [{"name" => "Custom Engraving Front", "value" => "Happy Birthday"}, {"name" => "Custom Engraving Back", "value" => "Merry Christmas"}], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => nil, "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.34", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.34", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.34", "currency_code" => "USD"}}}], "admin_graphql_api_id" => "gid://shopify/LineItem/466157049", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}}], "transactions" => [{"id" => 179259969, "order_id" => 450789469, "kind" => "refund", "gateway" => "bogus", "status" => "success", "message" => nil, "created_at" => "2005-08-05T12:59:12-04:00", "test" => false, "authorization" => "authorization-key", "location_id" => nil, "user_id" => nil, "parent_id" => 801038806, "processed_at" => "2005-08-05T12:59:12-04:00", "device_id" => nil, "error_code" => nil, "source_name" => "web", "receipt" => {}, "amount" => "209.00", "currency" => "USD", "admin_graphql_api_id" => "gid://shopify/OrderTransaction/179259969"}], "order_adjustments" => []}]}), headers: {})

    ShopifyAPI::Refund.all(
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/refunds.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/refunds.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "refund" => hash_including({"currency" => "USD", "notify" => true, "note" => "wrong size", "shipping" => {"full_refund" => true}, "refund_line_items" => [{"line_item_id" => 518995019, "quantity" => 1, "restock_type" => "return", "location_id" => 487838322}], "transactions" => [{"parent_id" => 801038806, "amount" => 41.94, "kind" => "refund", "gateway" => "bogus"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"refund" => {"id" => 929361462, "order_id" => 450789469, "created_at" => "2022-03-02T19:40:41-05:00", "note" => "wrong size", "user_id" => nil, "processed_at" => "2022-03-02T19:40:41-05:00", "restock" => false, "duties" => [], "total_duties_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "additional_fees" => [], "total_additional_fees_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "admin_graphql_api_id" => "gid://shopify/Refund/929361462", "refund_line_items" => [{"location_id" => nil, "restock_type" => "no_restock", "quantity" => 1, "id" => 1058498307, "line_item_id" => 518995019, "subtotal" => 195.67, "total_tax" => 3.98, "subtotal_set" => {"shop_money" => {"amount" => "195.67", "currency_code" => "USD"}, "presentment_money" => {"amount" => "195.67", "currency_code" => "USD"}}, "total_tax_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "line_item" => {"id" => 518995019, "variant_id" => 49148385, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008RED", "variant_title" => "red", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - red", "variant_inventory_management" => "shopify", "properties" => [], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => nil, "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.33", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/518995019", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}}], "transactions" => [{"id" => 1068278463, "order_id" => 450789469, "kind" => "refund", "gateway" => "bogus", "status" => "success", "message" => "Bogus Gateway: Forced success", "created_at" => "2022-03-02T19:40:40-05:00", "test" => true, "authorization" => nil, "location_id" => nil, "user_id" => nil, "parent_id" => 801038806, "processed_at" => "2022-03-02T19:40:40-05:00", "device_id" => nil, "error_code" => nil, "source_name" => "755357713", "receipt" => {}, "amount" => "41.94", "currency" => "USD", "admin_graphql_api_id" => "gid://shopify/OrderTransaction/1068278463"}], "order_adjustments" => []}}), headers: {})

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

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/refunds.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/refunds.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "refund" => hash_including({"currency" => "USD", "shipping" => {"amount" => 5.0}, "transactions" => [{"parent_id" => 801038806, "amount" => 5.0, "kind" => "refund", "gateway" => "bogus"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"refund" => {"id" => 929361463, "order_id" => 450789469, "created_at" => "2022-03-02T19:40:44-05:00", "note" => nil, "user_id" => nil, "processed_at" => "2022-03-02T19:40:44-05:00", "restock" => false, "duties" => [], "total_duties_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "additional_fees" => [], "total_additional_fees_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "admin_graphql_api_id" => "gid://shopify/Refund/929361463", "refund_line_items" => [], "transactions" => [{"id" => 1068278464, "order_id" => 450789469, "kind" => "refund", "gateway" => "bogus", "status" => "success", "message" => "Bogus Gateway: Forced success", "created_at" => "2022-03-02T19:40:43-05:00", "test" => true, "authorization" => nil, "location_id" => nil, "user_id" => nil, "parent_id" => 801038806, "processed_at" => "2022-03-02T19:40:43-05:00", "device_id" => nil, "error_code" => nil, "source_name" => "755357713", "receipt" => {}, "amount" => "5.00", "currency" => "USD", "admin_graphql_api_id" => "gid://shopify/OrderTransaction/1068278464"}], "order_adjustments" => [{"id" => 1030976842, "order_id" => 450789469, "refund_id" => 929361463, "amount" => "-5.00", "tax_amount" => "0.00", "kind" => "shipping_refund", "reason" => "Shipping refund", "amount_set" => {"shop_money" => {"amount" => "-5.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "-5.00", "currency_code" => "USD"}}, "tax_amount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}}]}}), headers: {})

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

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/refunds.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/refunds/509562969.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"refund" => {"id" => 509562969, "order_id" => 450789469, "created_at" => "2022-03-02T19:40:00-05:00", "note" => "it broke during shipping", "user_id" => 548380009, "processed_at" => "2022-03-02T19:40:00-05:00", "restock" => true, "duties" => [], "total_duties_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "additional_fees" => [], "total_additional_fees_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "admin_graphql_api_id" => "gid://shopify/Refund/509562969", "refund_line_items" => [{"id" => 104689539, "quantity" => 1, "line_item_id" => 703073504, "location_id" => 487838322, "restock_type" => "legacy_restock", "subtotal" => 195.67, "total_tax" => 3.98, "subtotal_set" => {"shop_money" => {"amount" => "195.67", "currency_code" => "USD"}, "presentment_money" => {"amount" => "195.67", "currency_code" => "USD"}}, "total_tax_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "line_item" => {"id" => 703073504, "variant_id" => 457924702, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008BLACK", "variant_title" => "black", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - black", "variant_inventory_management" => "shopify", "properties" => [], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => nil, "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.33", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/703073504", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}}, {"id" => 709875399, "quantity" => 1, "line_item_id" => 466157049, "location_id" => 487838322, "restock_type" => "legacy_restock", "subtotal" => 195.66, "total_tax" => 3.98, "subtotal_set" => {"shop_money" => {"amount" => "195.66", "currency_code" => "USD"}, "presentment_money" => {"amount" => "195.66", "currency_code" => "USD"}}, "total_tax_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "line_item" => {"id" => 466157049, "variant_id" => 39072856, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008GREEN", "variant_title" => "green", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - green", "variant_inventory_management" => "shopify", "properties" => [{"name" => "Custom Engraving Front", "value" => "Happy Birthday"}, {"name" => "Custom Engraving Back", "value" => "Merry Christmas"}], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => nil, "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.34", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.34", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.34", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/466157049", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}}], "transactions" => [{"id" => 179259969, "order_id" => 450789469, "kind" => "refund", "gateway" => "bogus", "status" => "success", "message" => nil, "created_at" => "2005-08-05T12:59:12-04:00", "test" => false, "authorization" => "authorization-key", "location_id" => nil, "user_id" => nil, "parent_id" => 801038806, "processed_at" => "2005-08-05T12:59:12-04:00", "device_id" => nil, "error_code" => nil, "source_name" => "web", "receipt" => {}, "amount" => "209.00", "currency" => "USD", "admin_graphql_api_id" => "gid://shopify/OrderTransaction/179259969"}], "order_adjustments" => []}}), headers: {})

    ShopifyAPI::Refund.find(
      order_id: 450789469,
      id: 509562969,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/refunds/509562969.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/refunds/calculate.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "refund" => hash_including({"shipping" => {"full_refund" => true}, "refund_line_items" => [{"line_item_id" => 518995019, "quantity" => 1, "restock_type" => "no_restock"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"refund" => {"shipping" => {"amount" => "5.00", "tax" => "0.00", "maximum_refundable" => "5.00"}, "duties" => [], "total_duties_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "additional_fees" => [], "total_additional_fees_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "refund_line_items" => [{"quantity" => 1, "line_item_id" => 518995019, "location_id" => nil, "restock_type" => "no_restock", "price" => "199.00", "subtotal" => "195.67", "total_tax" => "3.98", "discounted_price" => "199.00", "discounted_total_price" => "199.00", "total_cart_discount_amount" => "3.33"}], "transactions" => [{"order_id" => 450789469, "kind" => "suggested_refund", "gateway" => "bogus", "parent_id" => 801038806, "amount" => "41.94", "currency" => "USD", "maximum_refundable" => "41.94"}], "currency" => "USD"}}), headers: {})

    refund = ShopifyAPI::Refund.new
    refund.order_id = 450789469
    refund.calculate(
      body: {"refund" => {"shipping" => {"full_refund" => true}, "refund_line_items" => [{"line_item_id" => 518995019, "quantity" => 1, "restock_type" => "no_restock"}]}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/refunds/calculate.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/refunds/calculate.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "refund" => hash_including({"currency" => "USD", "shipping" => {"full_refund" => true}, "refund_line_items" => [{"line_item_id" => 518995019, "quantity" => 1, "restock_type" => "no_restock"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"refund" => {"shipping" => {"amount" => "5.00", "tax" => "0.00", "maximum_refundable" => "5.00"}, "duties" => [], "total_duties_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "additional_fees" => [], "total_additional_fees_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "refund_line_items" => [{"quantity" => 1, "line_item_id" => 518995019, "location_id" => nil, "restock_type" => "no_restock", "price" => "199.00", "subtotal" => "195.67", "total_tax" => "3.98", "discounted_price" => "199.00", "discounted_total_price" => "199.00", "total_cart_discount_amount" => "3.33"}], "transactions" => [{"order_id" => 450789469, "kind" => "suggested_refund", "gateway" => "bogus", "parent_id" => 801038806, "amount" => "41.94", "currency" => "USD", "maximum_refundable" => "41.94"}], "currency" => "USD"}}), headers: {})

    refund = ShopifyAPI::Refund.new
    refund.order_id = 450789469
    refund.calculate(
      body: {"refund" => {"currency" => "USD", "shipping" => {"full_refund" => true}, "refund_line_items" => [{"line_item_id" => 518995019, "quantity" => 1, "restock_type" => "no_restock"}]}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/refunds/calculate.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/refunds/calculate.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "refund" => hash_including({"currency" => "USD", "shipping" => {"amount" => 2.0}}) }
      )
      .to_return(status: 200, body: JSON.generate({"refund" => {"shipping" => {"amount" => "2.00", "tax" => "0.00", "maximum_refundable" => "5.00"}, "duties" => [], "total_duties_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "additional_fees" => [], "total_additional_fees_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "refund_line_items" => [], "transactions" => [{"order_id" => 450789469, "kind" => "suggested_refund", "gateway" => "bogus", "parent_id" => 801038806, "amount" => "2.00", "currency" => "USD", "maximum_refundable" => "41.94"}], "currency" => "USD"}}), headers: {})

    refund = ShopifyAPI::Refund.new
    refund.order_id = 450789469
    refund.calculate(
      body: {"refund" => {"currency" => "USD", "shipping" => {"amount" => 2.0}}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/refunds/calculate.json")
  end

end
