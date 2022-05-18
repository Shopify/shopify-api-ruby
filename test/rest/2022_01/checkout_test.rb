# typed: strict
# frozen_string_literal: true

########################################################################################################################
# This file is auto-generated. If you have an issue, please create a GitHub issue.                                     #
########################################################################################################################

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Checkout202201Test < Test::Unit::TestCase
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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "checkout" => hash_including({"line_items" => [{"variant_id" => 39072856, "quantity" => 5}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"checkout" => {"completed_at" => nil, "created_at" => "2022-04-05T13:20:16-04:00", "currency" => "USD", "presentment_currency" => "USD", "customer_id" => nil, "customer_locale" => "en", "device_id" => nil, "discount_code" => nil, "email" => nil, "legal_notice_url" => nil, "location_id" => nil, "name" => "#1066348321", "note" => "", "note_attributes" => {}, "order_id" => nil, "order_status_url" => nil, "order" => nil, "payment_due" => "995.00", "payment_url" => "https://app.local/cardserver/sessions", "payments" => [], "phone" => nil, "shopify_payments_account_id" => nil, "privacy_policy_url" => nil, "refund_policy_url" => nil, "requires_shipping" => true, "reservation_time_left" => 0, "reservation_time" => nil, "source_identifier" => nil, "source_name" => "755357713", "source_url" => nil, "subscription_policy_url" => nil, "subtotal_price" => "995.00", "shipping_policy_url" => nil, "tax_exempt" => false, "taxes_included" => false, "terms_of_sale_url" => nil, "terms_of_service_url" => nil, "token" => "b78d4099d9415288e788def7df19b7b3", "total_price" => "995.00", "total_tax" => "0.00", "total_tip_received" => "0.00", "total_line_items_price" => "995.00", "updated_at" => "2022-04-05T13:20:16-04:00", "user_id" => nil, "web_url" => "https://jsmith.myshopify.com/548380009/checkouts/b78d4099d9415288e788def7df19b7b3", "total_duties" => nil, "total_additional_fees" => nil, "line_items" => [{"id" => "b999f7f64bca60dac0cb492f81e572d0", "key" => "b999f7f64bca60dac0cb492f81e572d0", "product_id" => 632910392, "variant_id" => 39072856, "sku" => "IPOD2008GREEN", "vendor" => "Apple", "title" => "IPod Nano - 8GB", "variant_title" => "Green", "image_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1649179067", "taxable" => true, "requires_shipping" => true, "gift_card" => false, "price" => "199.00", "compare_at_price" => nil, "line_price" => "995.00", "properties" => {}, "quantity" => 5, "grams" => 567, "fulfillment_service" => "manual", "applied_discounts" => [], "discount_allocations" => [], "tax_lines" => []}], "gift_cards" => [], "tax_lines" => [], "tax_manipulations" => [], "shipping_line" => nil, "shipping_rate" => nil, "shipping_address" => nil, "credit_card" => nil, "billing_address" => nil, "applied_discount" => nil}}), headers: {})

    checkout = ShopifyAPI::Checkout.new
    checkout.line_items = [
      {
        "variant_id" => 39072856,
        "quantity" => 5
      }
    ]
    checkout.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "checkout" => hash_including({"email" => "me@example.com"}) }
      )
      .to_return(status: 200, body: JSON.generate({"checkout" => {"completed_at" => nil, "created_at" => "2022-04-05T13:20:23-04:00", "currency" => "USD", "presentment_currency" => "USD", "customer_id" => 1073339478, "customer_locale" => "en", "device_id" => nil, "discount_code" => nil, "email" => "me@example.com", "legal_notice_url" => nil, "location_id" => nil, "name" => "#1066348322", "note" => "", "note_attributes" => {}, "order_id" => nil, "order_status_url" => nil, "order" => nil, "payment_due" => "0.00", "payment_url" => "https://app.local/cardserver/sessions", "payments" => [], "phone" => nil, "shopify_payments_account_id" => nil, "privacy_policy_url" => nil, "refund_policy_url" => nil, "requires_shipping" => false, "reservation_time_left" => 0, "reservation_time" => nil, "source_identifier" => nil, "source_name" => "755357713", "source_url" => nil, "subscription_policy_url" => nil, "subtotal_price" => "0.00", "shipping_policy_url" => nil, "tax_exempt" => false, "taxes_included" => false, "terms_of_sale_url" => nil, "terms_of_service_url" => nil, "token" => "bc4925b491a7b13f91e432c1b3206fea", "total_price" => "0.00", "total_tax" => "0.00", "total_tip_received" => "0.00", "total_line_items_price" => "0.00", "updated_at" => "2022-04-05T13:20:23-04:00", "user_id" => nil, "web_url" => "https://jsmith.myshopify.com/548380009/checkouts/bc4925b491a7b13f91e432c1b3206fea", "total_duties" => nil, "total_additional_fees" => nil, "line_items" => [], "gift_cards" => [], "tax_lines" => [], "tax_manipulations" => [], "shipping_line" => nil, "shipping_rate" => nil, "shipping_address" => nil, "credit_card" => nil, "billing_address" => nil, "applied_discount" => nil}}), headers: {})

    checkout = ShopifyAPI::Checkout.new
    checkout.email = "me@example.com"
    checkout.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts/b490a9220cd14d7344024f4874f640a6/complete.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"checkout" => {"completed_at" => nil, "created_at" => "2012-10-12T07:05:27-04:00", "currency" => "USD", "presentment_currency" => "USD", "customer_id" => 207119551, "customer_locale" => "en", "device_id" => nil, "discount_code" => nil, "email" => "bob.norman@mail.example.com", "legal_notice_url" => nil, "location_id" => nil, "name" => "#86568385", "note" => "", "note_attributes" => {"custom engraving" => "Happy Birthday", "colour" => "green"}, "order_id" => nil, "order_status_url" => nil, "order" => nil, "payment_due" => "0.00", "payment_url" => "https://app.local/cardserver/sessions", "payments" => [], "phone" => nil, "shopify_payments_account_id" => nil, "privacy_policy_url" => nil, "refund_policy_url" => nil, "requires_shipping" => false, "reservation_time_left" => 0, "reservation_time" => nil, "source_identifier" => nil, "source_name" => "web", "source_url" => nil, "subscription_policy_url" => nil, "subtotal_price" => "0.00", "shipping_policy_url" => nil, "tax_exempt" => false, "taxes_included" => false, "terms_of_sale_url" => nil, "terms_of_service_url" => nil, "token" => "b490a9220cd14d7344024f4874f640a6", "total_price" => "0.00", "total_tax" => "0.00", "total_tip_received" => "0.00", "total_line_items_price" => "0.00", "updated_at" => "2022-04-05T13:20:27-04:00", "user_id" => nil, "web_url" => "https://checkout.local/548380009/checkouts/b490a9220cd14d7344024f4874f640a6", "total_duties" => nil, "total_additional_fees" => nil, "line_items" => [{"id" => 49148385, "key" => 49148385, "product_id" => 632910392, "variant_id" => 49148385, "sku" => "IPOD2008RED", "vendor" => "Apple", "title" => "IPod Nano - 8GB", "variant_title" => "Red", "image_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1649179067", "taxable" => true, "requires_shipping" => false, "gift_card" => false, "price" => "0.00", "compare_at_price" => nil, "line_price" => "0.00", "properties" => {}, "quantity" => 1, "grams" => 200, "fulfillment_service" => "manual", "applied_discounts" => [], "discount_allocations" => [], "tax_lines" => []}], "gift_cards" => [], "tax_lines" => [], "tax_manipulations" => [], "shipping_line" => nil, "shipping_rate" => nil, "shipping_address" => {"id" => 550558813, "first_name" => "Bob", "last_name" => "Norman", "phone" => "555-625-1199", "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "province_code" => "KY", "country" => "United States", "country_code" => "US", "zip" => "40202"}, "credit_card" => nil, "billing_address" => {"id" => 550558813, "first_name" => "Bob", "last_name" => "Norman", "phone" => "555-625-1199", "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "province_code" => "KY", "country" => "United States", "country_code" => "US", "zip" => "40202"}, "applied_discount" => nil}}), headers: {})

    checkout = ShopifyAPI::Checkout.new
    checkout.token = "b490a9220cd14d7344024f4874f640a6"
    checkout.complete()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts/b490a9220cd14d7344024f4874f640a6/complete.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"checkout" => {"completed_at" => nil, "created_at" => "2012-10-12T07:05:27-04:00", "currency" => "USD", "presentment_currency" => "USD", "customer_id" => 207119551, "customer_locale" => "en", "device_id" => nil, "discount_code" => nil, "email" => "bob.norman@mail.example.com", "legal_notice_url" => nil, "location_id" => nil, "name" => "#862052962", "note" => "", "note_attributes" => {"custom engraving" => "Happy Birthday", "colour" => "green"}, "order_id" => nil, "order_status_url" => nil, "order" => nil, "payment_due" => "419.49", "payment_url" => "https://app.local/cardserver/sessions", "payments" => [], "phone" => nil, "shopify_payments_account_id" => nil, "privacy_policy_url" => nil, "refund_policy_url" => nil, "requires_shipping" => true, "reservation_time_left" => 0, "reservation_time" => nil, "source_identifier" => nil, "source_name" => "web", "source_url" => nil, "subscription_policy_url" => nil, "subtotal_price" => "398.00", "shipping_policy_url" => nil, "tax_exempt" => false, "taxes_included" => false, "terms_of_sale_url" => nil, "terms_of_service_url" => nil, "token" => "exuw7apwoycchjuwtiqg8nytfhphr62a", "total_price" => "419.49", "total_tax" => "21.49", "total_tip_received" => "0.00", "total_line_items_price" => "398.00", "updated_at" => "2012-10-12T07:05:27-04:00", "user_id" => nil, "web_url" => "https://checkout.local/548380009/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a", "total_duties" => nil, "total_additional_fees" => nil, "line_items" => [{"id" => "05a0af9e9182479a", "key" => "05a0af9e9182479a", "product_id" => 632910392, "variant_id" => 49148385, "sku" => "IPOD2008RED", "vendor" => "Apple", "title" => "IPod Nano - 8GB", "variant_title" => "Red", "image_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1649179067", "taxable" => true, "requires_shipping" => true, "gift_card" => false, "price" => "199.00", "compare_at_price" => nil, "line_price" => "199.00", "properties" => {}, "quantity" => 1, "grams" => 200, "fulfillment_service" => "manual", "applied_discounts" => [], "discount_allocations" => [], "tax_lines" => []}, {"id" => "b083600b29922b12", "key" => "b083600b29922b12", "product_id" => 632910392, "variant_id" => 808950810, "sku" => "IPOD2008PINK", "vendor" => "Apple", "title" => "IPod Nano - 8GB", "variant_title" => "Pink", "image_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1649179067", "taxable" => true, "requires_shipping" => true, "gift_card" => false, "price" => "199.00", "compare_at_price" => nil, "line_price" => "199.00", "properties" => {}, "quantity" => 1, "grams" => 200, "fulfillment_service" => "manual", "applied_discounts" => [], "discount_allocations" => [], "tax_lines" => []}], "gift_cards" => [], "tax_lines" => [{"price" => "21.49", "rate" => 0.06, "title" => "State Tax", "compare_at" => 0.06}], "tax_manipulations" => [], "shipping_line" => {"handle" => "shopify-Free%20Shipping-0.00", "price" => "0.00", "title" => "Free Shipping", "tax_lines" => []}, "shipping_rate" => {"id" => "shopify-Free%20Shipping-0.00", "price" => "0.00", "title" => "Free Shipping"}, "shipping_address" => {"id" => 550558813, "first_name" => "Bob", "last_name" => "Norman", "phone" => "555-625-1199", "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "province_code" => "KY", "country" => "United States", "country_code" => "US", "zip" => "40202"}, "credit_card" => nil, "billing_address" => {"id" => 550558813, "first_name" => "Bob", "last_name" => "Norman", "phone" => "555-625-1199", "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "province_code" => "KY", "country" => "United States", "country_code" => "US", "zip" => "40202"}, "applied_discount" => nil}}), headers: {})

    ShopifyAPI::Checkout.find(
      token: "exuw7apwoycchjuwtiqg8nytfhphr62a",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts/bd5a8aa1ecd019dd3520ff791ee3a24c.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"checkout" => {"completed_at" => "2005-07-31T11:57:11-04:00", "created_at" => "2012-10-12T07:05:27-04:00", "currency" => "USD", "presentment_currency" => "USD", "customer_id" => 207119551, "customer_locale" => "en", "device_id" => nil, "discount_code" => nil, "email" => "bob.norman@mail.example.com", "legal_notice_url" => nil, "location_id" => nil, "name" => "#901414060", "note" => "", "note_attributes" => {"custom engraving" => "Happy Birthday", "colour" => "green"}, "order_id" => 450789469, "order_status_url" => "https://checkout.local/548380009/checkouts/bd5a8aa1ecd019dd3520ff791ee3a24c/thank_you", "order" => {"id" => 450789469, "name" => "#1001", "status_url" => "https://checkout.local/548380009/checkouts/bd5a8aa1ecd019dd3520ff791ee3a24c/thank_you"}, "payment_due" => "398.00", "payment_url" => "https://app.local/cardserver/sessions", "payments" => [], "phone" => nil, "shopify_payments_account_id" => nil, "privacy_policy_url" => nil, "refund_policy_url" => nil, "requires_shipping" => true, "reservation_time_left" => 0, "reservation_time" => nil, "source_identifier" => nil, "source_name" => "web", "source_url" => nil, "subscription_policy_url" => nil, "subtotal_price" => "398.00", "shipping_policy_url" => nil, "tax_exempt" => false, "taxes_included" => false, "terms_of_sale_url" => nil, "terms_of_service_url" => nil, "token" => "bd5a8aa1ecd019dd3520ff791ee3a24c", "total_price" => "398.00", "total_tax" => "0.00", "total_tip_received" => "0.00", "total_line_items_price" => "398.00", "updated_at" => "2012-10-12T07:05:27-04:00", "user_id" => nil, "web_url" => "https://checkout.local/548380009/checkouts/bd5a8aa1ecd019dd3520ff791ee3a24c", "total_duties" => nil, "total_additional_fees" => nil, "line_items" => [{"id" => "05a0af9e9182479a", "key" => "05a0af9e9182479a", "product_id" => 632910392, "variant_id" => 49148385, "sku" => "IPOD2008RED", "vendor" => "Apple", "title" => "IPod Nano - 8GB", "variant_title" => "Red", "image_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1649179067", "taxable" => true, "requires_shipping" => true, "gift_card" => false, "price" => "199.00", "compare_at_price" => nil, "line_price" => "199.00", "properties" => {}, "quantity" => 1, "grams" => 200, "fulfillment_service" => "manual", "applied_discounts" => [], "discount_allocations" => [], "tax_lines" => []}, {"id" => "b083600b29922b12", "key" => "b083600b29922b12", "product_id" => 632910392, "variant_id" => 808950810, "sku" => "IPOD2008PINK", "vendor" => "Apple", "title" => "IPod Nano - 8GB", "variant_title" => "Pink", "image_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1649179067", "taxable" => true, "requires_shipping" => true, "gift_card" => false, "price" => "199.00", "compare_at_price" => nil, "line_price" => "199.00", "properties" => {}, "quantity" => 1, "grams" => 200, "fulfillment_service" => "manual", "applied_discounts" => [], "discount_allocations" => [], "tax_lines" => []}], "gift_cards" => [], "tax_lines" => [], "tax_manipulations" => [], "shipping_line" => {"handle" => "shopify-Free%20Shipping-0.00", "price" => "0.00", "title" => "Free Shipping", "tax_lines" => []}, "shipping_rate" => {"id" => "shopify-Free%20Shipping-0.00", "price" => "0.00", "title" => "Free Shipping"}, "shipping_address" => {"id" => 550558813, "first_name" => "Bob", "last_name" => "Norman", "phone" => "555-625-1199", "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "province_code" => "KY", "country" => "United States", "country_code" => "US", "zip" => "40202"}, "credit_card" => nil, "billing_address" => {"id" => 550558813, "first_name" => "Bob", "last_name" => "Norman", "phone" => "555-625-1199", "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "province_code" => "KY", "country" => "United States", "country_code" => "US", "zip" => "40202"}, "applied_discount" => nil}}), headers: {})

    ShopifyAPI::Checkout.find(
      token: "bd5a8aa1ecd019dd3520ff791ee3a24c",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts/bd5a8aa1ecd019dd3520ff791ee3a24c.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"checkout" => {"completed_at" => nil, "created_at" => "2012-10-12T07:05:27-04:00", "currency" => "USD", "presentment_currency" => "USD", "customer_id" => 207119551, "customer_locale" => "en", "device_id" => nil, "discount_code" => nil, "email" => "bob.norman@mail.example.com", "legal_notice_url" => nil, "location_id" => nil, "name" => "#446514532", "note" => "", "note_attributes" => {"custom engraving" => "Happy Birthday", "colour" => "green"}, "order_id" => nil, "order_status_url" => nil, "order" => nil, "payment_due" => "419.49", "payment_url" => "https://app.local/cardserver/sessions", "payments" => [{"id" => 25428999, "unique_token" => "e01e661f4a99acd9dcdg6f1422d0d6f7", "payment_processing_error_message" => nil, "fraudulent" => false, "transaction" => {"amount" => "598.94", "amount_in" => nil, "amount_out" => nil, "amount_rounding" => nil, "authorization" => "authorization-key", "created_at" => "2005-08-01T11:57:11-04:00", "currency" => "USD", "error_code" => nil, "parent_id" => nil, "gateway" => "bogus", "id" => 389404469, "kind" => "authorization", "message" => nil, "status" => "success", "test" => false, "receipt" => {"testcase" => true, "authorization" => "123456"}, "location_id" => nil, "user_id" => nil, "transaction_group_id" => nil, "device_id" => nil, "payment_details" => {"credit_card_bin" => nil, "avs_result_code" => nil, "cvv_result_code" => nil, "credit_card_number" => "\u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 4242", "credit_card_company" => "Visa", "credit_card_name" => nil, "credit_card_wallet" => nil, "credit_card_expiration_month" => nil, "credit_card_expiration_year" => nil}}, "credit_card" => nil}], "phone" => nil, "shopify_payments_account_id" => nil, "privacy_policy_url" => nil, "refund_policy_url" => nil, "requires_shipping" => true, "reservation_time_left" => 0, "reservation_time" => nil, "source_identifier" => nil, "source_name" => "web", "source_url" => nil, "subscription_policy_url" => nil, "subtotal_price" => "398.00", "shipping_policy_url" => nil, "tax_exempt" => false, "taxes_included" => false, "terms_of_sale_url" => nil, "terms_of_service_url" => nil, "token" => "7yjf4v2we7gamku6a6h7tvm8h3mmvs4x", "total_price" => "419.49", "total_tax" => "21.49", "total_tip_received" => "0.00", "total_line_items_price" => "398.00", "updated_at" => "2012-10-12T07:05:27-04:00", "user_id" => nil, "web_url" => "https://checkout.local/548380009/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x", "total_duties" => nil, "total_additional_fees" => nil, "line_items" => [{"id" => "05a0af9e9182479a", "key" => "05a0af9e9182479a", "product_id" => 632910392, "variant_id" => 49148385, "sku" => "IPOD2008RED", "vendor" => "Apple", "title" => "IPod Nano - 8GB", "variant_title" => "Red", "image_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1649179067", "taxable" => true, "requires_shipping" => true, "gift_card" => false, "price" => "199.00", "compare_at_price" => nil, "line_price" => "199.00", "properties" => {}, "quantity" => 1, "grams" => 200, "fulfillment_service" => "manual", "applied_discounts" => [], "discount_allocations" => [], "tax_lines" => []}, {"id" => "b083600b29922b12", "key" => "b083600b29922b12", "product_id" => 632910392, "variant_id" => 808950810, "sku" => "IPOD2008PINK", "vendor" => "Apple", "title" => "IPod Nano - 8GB", "variant_title" => "Pink", "image_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1649179067", "taxable" => true, "requires_shipping" => true, "gift_card" => false, "price" => "199.00", "compare_at_price" => nil, "line_price" => "199.00", "properties" => {}, "quantity" => 1, "grams" => 200, "fulfillment_service" => "manual", "applied_discounts" => [], "discount_allocations" => [], "tax_lines" => []}], "gift_cards" => [], "tax_lines" => [{"price" => "21.49", "rate" => 0.06, "title" => "State Tax", "compare_at" => 0.06}], "tax_manipulations" => [], "shipping_line" => {"handle" => "shopify-Free%20Shipping-0.00", "price" => "0.00", "title" => "Free Shipping", "tax_lines" => []}, "shipping_rate" => {"id" => "shopify-Free%20Shipping-0.00", "price" => "0.00", "title" => "Free Shipping"}, "shipping_address" => {"id" => 550558813, "first_name" => "Bob", "last_name" => "Norman", "phone" => "555-625-1199", "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "province_code" => "KY", "country" => "United States", "country_code" => "US", "zip" => "40202"}, "credit_card" => {"first_name" => "Bob", "last_name" => "Norman", "first_digits" => "1", "last_digits" => "1", "brand" => "bogus", "expiry_month" => 8, "expiry_year" => 2042, "customer_id" => nil}, "billing_address" => {"id" => 550558813, "first_name" => "Bob", "last_name" => "Norman", "phone" => "555-625-1199", "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "province_code" => "KY", "country" => "United States", "country_code" => "US", "zip" => "40202"}, "applied_discount" => nil}}), headers: {})

    ShopifyAPI::Checkout.find(
      token: "7yjf4v2we7gamku6a6h7tvm8h3mmvs4x",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "checkout" => hash_including({"email" => "john.smith@example.com", "shipping_address" => {"first_name" => "John", "last_name" => "Smith", "address1" => "126 York St.", "city" => "Los Angeles", "province_code" => "CA", "country_code" => "US", "phone" => "(123)456-7890", "zip" => "90002"}}) }
      )
      .to_return(status: 200, body: JSON.generate({"checkout" => {"completed_at" => nil, "created_at" => "2012-10-12T07:05:27-04:00", "currency" => "USD", "presentment_currency" => "USD", "customer_id" => 1073339479, "customer_locale" => "en", "device_id" => nil, "discount_code" => nil, "email" => "john.smith@example.com", "legal_notice_url" => nil, "location_id" => nil, "name" => "#862052962", "note" => "", "note_attributes" => {"custom engraving" => "Happy Birthday", "colour" => "green"}, "order_id" => nil, "order_status_url" => nil, "order" => nil, "payment_due" => "398.00", "payment_url" => "https://app.local/cardserver/sessions", "payments" => [], "phone" => nil, "shopify_payments_account_id" => nil, "privacy_policy_url" => nil, "refund_policy_url" => nil, "requires_shipping" => true, "reservation_time_left" => 0, "reservation_time" => nil, "source_identifier" => nil, "source_name" => "web", "source_url" => nil, "subscription_policy_url" => nil, "subtotal_price" => "398.00", "shipping_policy_url" => nil, "tax_exempt" => false, "taxes_included" => false, "terms_of_sale_url" => nil, "terms_of_service_url" => nil, "token" => "exuw7apwoycchjuwtiqg8nytfhphr62a", "total_price" => "398.00", "total_tax" => "0.00", "total_tip_received" => "0.00", "total_line_items_price" => "398.00", "updated_at" => "2022-04-05T13:20:37-04:00", "user_id" => nil, "web_url" => "https://checkout.local/548380009/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a", "total_duties" => nil, "total_additional_fees" => nil, "line_items" => [{"id" => "05a0af9e9182479a", "key" => "05a0af9e9182479a", "product_id" => 632910392, "variant_id" => 49148385, "sku" => "IPOD2008RED", "vendor" => "Apple", "title" => "IPod Nano - 8GB", "variant_title" => "Red", "image_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1649179067", "taxable" => true, "requires_shipping" => true, "gift_card" => false, "price" => "199.00", "compare_at_price" => nil, "line_price" => "199.00", "properties" => {}, "quantity" => 1, "grams" => 200, "fulfillment_service" => "manual", "applied_discounts" => [], "discount_allocations" => [], "tax_lines" => []}, {"id" => "b083600b29922b12", "key" => "b083600b29922b12", "product_id" => 632910392, "variant_id" => 808950810, "sku" => "IPOD2008PINK", "vendor" => "Apple", "title" => "IPod Nano - 8GB", "variant_title" => "Pink", "image_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1649179067", "taxable" => true, "requires_shipping" => true, "gift_card" => false, "price" => "199.00", "compare_at_price" => nil, "line_price" => "199.00", "properties" => {}, "quantity" => 1, "grams" => 200, "fulfillment_service" => "manual", "applied_discounts" => [], "discount_allocations" => [], "tax_lines" => []}], "gift_cards" => [], "tax_lines" => [], "tax_manipulations" => [], "shipping_line" => nil, "shipping_rate" => nil, "shipping_address" => {"id" => 550558813, "first_name" => "John", "last_name" => "Smith", "phone" => "(123)456-7890", "company" => nil, "address1" => "126 York St.", "address2" => "", "city" => "Los Angeles", "province" => "California", "province_code" => "CA", "country" => "United States", "country_code" => "US", "zip" => "90002"}, "credit_card" => nil, "billing_address" => {"id" => 550558813, "first_name" => "Bob", "last_name" => "Norman", "phone" => "555-625-1199", "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "province_code" => "KY", "country" => "United States", "country_code" => "US", "zip" => "40202"}, "applied_discount" => nil}}), headers: {})

    checkout = ShopifyAPI::Checkout.new
    checkout.token = "exuw7apwoycchjuwtiqg8nytfhphr62a"
    checkout.email = "john.smith@example.com"
    checkout.shipping_address = {
      "first_name" => "John",
      "last_name" => "Smith",
      "address1" => "126 York St.",
      "city" => "Los Angeles",
      "province_code" => "CA",
      "country_code" => "US",
      "phone" => "(123)456-7890",
      "zip" => "90002"
    }
    checkout.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "checkout" => hash_including({"shipping_line" => {"handle" => "shopify-Free%20Shipping-0.00"}}) }
      )
      .to_return(status: 200, body: JSON.generate({"checkout" => {"completed_at" => nil, "created_at" => "2012-10-12T07:05:27-04:00", "currency" => "USD", "presentment_currency" => "USD", "customer_id" => 207119551, "customer_locale" => "en", "device_id" => nil, "discount_code" => nil, "email" => "bob.norman@mail.example.com", "legal_notice_url" => nil, "location_id" => nil, "name" => "#862052962", "note" => "", "note_attributes" => {"custom engraving" => "Happy Birthday", "colour" => "green"}, "order_id" => nil, "order_status_url" => nil, "order" => nil, "payment_due" => "398.00", "payment_url" => "https://app.local/cardserver/sessions", "payments" => [], "phone" => nil, "shopify_payments_account_id" => nil, "privacy_policy_url" => nil, "refund_policy_url" => nil, "requires_shipping" => true, "reservation_time_left" => 0, "reservation_time" => nil, "source_identifier" => nil, "source_name" => "web", "source_url" => nil, "subscription_policy_url" => nil, "subtotal_price" => "398.00", "shipping_policy_url" => nil, "tax_exempt" => false, "taxes_included" => false, "terms_of_sale_url" => nil, "terms_of_service_url" => nil, "token" => "exuw7apwoycchjuwtiqg8nytfhphr62a", "total_price" => "398.00", "total_tax" => "0.00", "total_tip_received" => "0.00", "total_line_items_price" => "398.00", "updated_at" => "2022-04-05T13:20:41-04:00", "user_id" => nil, "web_url" => "https://checkout.local/548380009/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a", "total_duties" => nil, "total_additional_fees" => nil, "line_items" => [{"id" => "05a0af9e9182479a", "key" => "05a0af9e9182479a", "product_id" => 632910392, "variant_id" => 49148385, "sku" => "IPOD2008RED", "vendor" => "Apple", "title" => "IPod Nano - 8GB", "variant_title" => "Red", "image_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1649179067", "taxable" => true, "requires_shipping" => true, "gift_card" => false, "price" => "199.00", "compare_at_price" => nil, "line_price" => "199.00", "properties" => {}, "quantity" => 1, "grams" => 200, "fulfillment_service" => "manual", "applied_discounts" => [], "discount_allocations" => [], "tax_lines" => []}, {"id" => "b083600b29922b12", "key" => "b083600b29922b12", "product_id" => 632910392, "variant_id" => 808950810, "sku" => "IPOD2008PINK", "vendor" => "Apple", "title" => "IPod Nano - 8GB", "variant_title" => "Pink", "image_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1649179067", "taxable" => true, "requires_shipping" => true, "gift_card" => false, "price" => "199.00", "compare_at_price" => nil, "line_price" => "199.00", "properties" => {}, "quantity" => 1, "grams" => 200, "fulfillment_service" => "manual", "applied_discounts" => [], "discount_allocations" => [], "tax_lines" => []}], "gift_cards" => [], "tax_lines" => [], "tax_manipulations" => [], "shipping_line" => {"handle" => "shopify-Free%20Shipping-0.00", "price" => "0.00", "title" => "Free Shipping", "tax_lines" => []}, "shipping_rate" => {"id" => "shopify-Free%20Shipping-0.00", "price" => "0.00", "title" => "Free Shipping"}, "shipping_address" => {"id" => 550558813, "first_name" => "Bob", "last_name" => "Norman", "phone" => "555-625-1199", "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "province_code" => "KY", "country" => "United States", "country_code" => "US", "zip" => "40202"}, "credit_card" => nil, "billing_address" => {"id" => 550558813, "first_name" => "Bob", "last_name" => "Norman", "phone" => "555-625-1199", "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "province_code" => "KY", "country" => "United States", "country_code" => "US", "zip" => "40202"}, "applied_discount" => nil}}), headers: {})

    checkout = ShopifyAPI::Checkout.new
    checkout.token = "exuw7apwoycchjuwtiqg8nytfhphr62a"
    checkout.shipping_line = {
      "handle" => "shopify-Free%20Shipping-0.00"
    }
    checkout.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a/shipping_rates.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"shipping_rates" => []}), headers: {})

    ShopifyAPI::Checkout.shipping_rates(
      token: "exuw7apwoycchjuwtiqg8nytfhphr62a",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a/shipping_rates.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a/shipping_rates.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"shipping_rates" => [{"id" => "shopify-Free%20Shipping-0.00", "price" => "0.00", "title" => "Free Shipping", "checkout" => {"total_tax" => "0.00", "total_price" => "398.00", "subtotal_price" => "398.00"}, "phone_required" => false, "delivery_range" => nil, "estimated_time_in_transit" => nil, "handle" => "shopify-Free%20Shipping-0.00"}]}), headers: {})

    ShopifyAPI::Checkout.shipping_rates(
      token: "exuw7apwoycchjuwtiqg8nytfhphr62a",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts/exuw7apwoycchjuwtiqg8nytfhphr62a/shipping_rates.json")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts/zs9ru89kuqcdagk8bz4r9hnxt22wwd42/shipping_rates.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"shipping_rates" => []}), headers: {})

    ShopifyAPI::Checkout.shipping_rates(
      token: "zs9ru89kuqcdagk8bz4r9hnxt22wwd42",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/checkouts/zs9ru89kuqcdagk8bz4r9hnxt22wwd42/shipping_rates.json")
  end

end
