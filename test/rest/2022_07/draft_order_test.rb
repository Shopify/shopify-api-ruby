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

class DraftOrder202207Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-07")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "draft_order" => hash_including({"line_items" => [{"title" => "Custom Tee", "price" => "20.00", "quantity" => 2}], "applied_discount" => {"description" => "Custom discount", "value_type" => "fixed_amount", "value" => "10.0", "amount" => "10.00", "title" => "Custom"}, "customer" => {"id" => 207119551}, "use_customer_default_address" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"draft_order" => {"id" => 1069920494, "note" => nil, "email" => "bob.norman@mail.example.com", "taxes_included" => false, "currency" => "USD", "invoice_sent_at" => nil, "created_at" => "2023-02-13T10:30:01-05:00", "updated_at" => "2023-02-13T10:30:01-05:00", "tax_exempt" => false, "completed_at" => nil, "name" => "#D5", "status" => "open", "line_items" => [{"id" => 1066630407, "variant_id" => nil, "product_id" => nil, "title" => "Custom Tee", "variant_title" => nil, "sku" => nil, "vendor" => nil, "quantity" => 2, "requires_shipping" => false, "taxable" => true, "gift_card" => false, "fulfillment_service" => "manual", "grams" => 0, "tax_lines" => [], "applied_discount" => nil, "name" => "Custom Tee", "properties" => [], "custom" => true, "price" => "20.00", "admin_graphql_api_id" => "gid://shopify/DraftOrderLineItem/1066630407"}], "shipping_address" => {"first_name" => nil, "address1" => "Chestnut Street 92", "phone" => "555-625-1199", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => nil, "address2" => "", "company" => nil, "latitude" => nil, "longitude" => nil, "name" => "", "country_code" => "US", "province_code" => "KY"}, "billing_address" => {"first_name" => nil, "address1" => "Chestnut Street 92", "phone" => "555-625-1199", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => nil, "address2" => "", "company" => nil, "latitude" => nil, "longitude" => nil, "name" => "", "country_code" => "US", "province_code" => "KY"}, "invoice_url" => "https://jsmith.myshopify.com/548380009/invoices/95146d7e1a37bb96b0d91e1ea4b0c744", "applied_discount" => {"description" => "Custom discount", "value" => "10.0", "title" => "Custom", "amount" => "10.00", "value_type" => "fixed_amount"}, "order_id" => nil, "shipping_line" => nil, "tax_lines" => [], "tags" => "", "note_attributes" => [], "total_price" => "30.00", "subtotal_price" => "30.00", "total_tax" => "0.00", "presentment_currency" => "USD", "total_line_items_price_set" => {"shop_money" => {"amount" => "40.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "40.00", "currency_code" => "USD"}}, "total_price_set" => {"shop_money" => {"amount" => "30.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "30.00", "currency_code" => "USD"}}, "subtotal_price_set" => {"shop_money" => {"amount" => "30.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "30.00", "currency_code" => "USD"}}, "total_tax_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "total_discounts_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_shipping_price_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "payment_terms" => nil, "admin_graphql_api_id" => "gid://shopify/DraftOrder/1069920494", "customer" => {"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => false, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:18:48-05:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1001", "currency" => "USD", "phone" => "+16136120707", "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => nil, "consent_updated_at" => "2004-06-13T11:57:11-04:00"}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => "2023-02-13T10:18:48-05:00", "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}}}), headers: {})

    draft_order = ShopifyAPI::DraftOrder.new
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
    draft_order.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "draft_order" => hash_including({"line_items" => [{"title" => "Custom Tee", "price" => "20.00", "quantity" => 1, "applied_discount" => {"description" => "Custom discount", "value_type" => "percentage", "value" => "10.0", "amount" => "2.0", "title" => "Custom"}}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"draft_order" => {"id" => 1069920495, "note" => nil, "email" => nil, "taxes_included" => false, "currency" => "USD", "invoice_sent_at" => nil, "created_at" => "2023-02-13T10:30:02-05:00", "updated_at" => "2023-02-13T10:30:02-05:00", "tax_exempt" => false, "completed_at" => nil, "name" => "#D5", "status" => "open", "line_items" => [{"id" => 1066630408, "variant_id" => nil, "product_id" => nil, "title" => "Custom Tee", "variant_title" => nil, "sku" => nil, "vendor" => nil, "quantity" => 1, "requires_shipping" => false, "taxable" => true, "gift_card" => false, "fulfillment_service" => "manual", "grams" => 0, "tax_lines" => [{"rate" => 0.05, "title" => "GST", "price" => "0.90"}, {"rate" => 0.08, "title" => "Tax", "price" => "1.44"}], "applied_discount" => {"description" => "Custom discount", "value" => "10.0", "title" => "Custom", "amount" => "2.00", "value_type" => "percentage"}, "name" => "Custom Tee", "properties" => [], "custom" => true, "price" => "20.00", "admin_graphql_api_id" => "gid://shopify/DraftOrderLineItem/1066630408"}], "shipping_address" => nil, "billing_address" => nil, "invoice_url" => "https://jsmith.myshopify.com/548380009/invoices/05e5a9292baebb993c03dd314970d52e", "applied_discount" => nil, "order_id" => nil, "shipping_line" => nil, "tax_lines" => [{"rate" => 0.05, "title" => "GST", "price" => "0.90"}, {"rate" => 0.08, "title" => "Tax", "price" => "1.44"}], "tags" => "", "note_attributes" => [], "total_price" => "20.34", "subtotal_price" => "18.00", "total_tax" => "2.34", "presentment_currency" => "USD", "total_line_items_price_set" => {"shop_money" => {"amount" => "20.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "20.00", "currency_code" => "USD"}}, "total_price_set" => {"shop_money" => {"amount" => "20.34", "currency_code" => "USD"}, "presentment_money" => {"amount" => "20.34", "currency_code" => "USD"}}, "subtotal_price_set" => {"shop_money" => {"amount" => "18.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "18.00", "currency_code" => "USD"}}, "total_tax_set" => {"shop_money" => {"amount" => "2.34", "currency_code" => "USD"}, "presentment_money" => {"amount" => "2.34", "currency_code" => "USD"}}, "total_discounts_set" => {"shop_money" => {"amount" => "2.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "2.00", "currency_code" => "USD"}}, "total_shipping_price_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "payment_terms" => nil, "admin_graphql_api_id" => "gid://shopify/DraftOrder/1069920495"}}), headers: {})

    draft_order = ShopifyAPI::DraftOrder.new
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
    draft_order.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "draft_order" => hash_including({"line_items" => [{"title" => "Custom Tee", "price" => "20.00", "quantity" => 2}], "customer" => {"id" => 207119551}, "use_customer_default_address" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"draft_order" => {"id" => 1069920492, "note" => nil, "email" => "bob.norman@mail.example.com", "taxes_included" => false, "currency" => "USD", "invoice_sent_at" => nil, "created_at" => "2023-02-13T10:29:37-05:00", "updated_at" => "2023-02-13T10:29:37-05:00", "tax_exempt" => false, "completed_at" => nil, "name" => "#D5", "status" => "open", "line_items" => [{"id" => 1066630404, "variant_id" => nil, "product_id" => nil, "title" => "Custom Tee", "variant_title" => nil, "sku" => nil, "vendor" => nil, "quantity" => 2, "requires_shipping" => false, "taxable" => true, "gift_card" => false, "fulfillment_service" => "manual", "grams" => 0, "tax_lines" => [], "applied_discount" => nil, "name" => "Custom Tee", "properties" => [], "custom" => true, "price" => "20.00", "admin_graphql_api_id" => "gid://shopify/DraftOrderLineItem/1066630404"}], "shipping_address" => {"first_name" => nil, "address1" => "Chestnut Street 92", "phone" => "555-625-1199", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => nil, "address2" => "", "company" => nil, "latitude" => nil, "longitude" => nil, "name" => "", "country_code" => "US", "province_code" => "KY"}, "billing_address" => {"first_name" => nil, "address1" => "Chestnut Street 92", "phone" => "555-625-1199", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => nil, "address2" => "", "company" => nil, "latitude" => nil, "longitude" => nil, "name" => "", "country_code" => "US", "province_code" => "KY"}, "invoice_url" => "https://jsmith.myshopify.com/548380009/invoices/6eaf7a82f7100815ef813b9177fa59c3", "applied_discount" => nil, "order_id" => nil, "shipping_line" => nil, "tax_lines" => [], "tags" => "", "note_attributes" => [], "total_price" => "40.00", "subtotal_price" => "40.00", "total_tax" => "0.00", "presentment_currency" => "USD", "total_line_items_price_set" => {"shop_money" => {"amount" => "40.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "40.00", "currency_code" => "USD"}}, "total_price_set" => {"shop_money" => {"amount" => "40.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "40.00", "currency_code" => "USD"}}, "subtotal_price_set" => {"shop_money" => {"amount" => "40.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "40.00", "currency_code" => "USD"}}, "total_tax_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "total_discounts_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "total_shipping_price_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "payment_terms" => nil, "admin_graphql_api_id" => "gid://shopify/DraftOrder/1069920492", "customer" => {"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => false, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:18:48-05:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1001", "currency" => "USD", "phone" => "+16136120707", "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => nil, "consent_updated_at" => "2004-06-13T11:57:11-04:00"}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => "2023-02-13T10:18:48-05:00", "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}}}), headers: {})

    draft_order = ShopifyAPI::DraftOrder.new
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
    draft_order.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "draft_order" => hash_including({"line_items" => [{"variant_id" => 447654529, "quantity" => 1}], "billing_address" => {"first_name" => "Bob", "last_name" => "Norman", "address1" => "123 Main St", "city" => "Anytown", "province" => "ON", "country" => "Canada", "zip" => "A1B2C3", "phone" => "555-555-5555"}}) }
      )
      .to_return(status: 200, body: JSON.generate({"draft_order" => {"id" => 1069920491, "note" => nil, "email" => nil, "taxes_included" => false, "currency" => "USD", "invoice_sent_at" => nil, "created_at" => "2023-02-13T10:29:35-05:00", "updated_at" => "2023-02-13T10:29:35-05:00", "tax_exempt" => false, "completed_at" => nil, "name" => "#D5", "status" => "open", "line_items" => [{"id" => 1066630403, "variant_id" => 447654529, "product_id" => 921728736, "title" => "IPod Touch 8GB", "variant_title" => "Black", "sku" => "IPOD2009BLACK", "vendor" => "Apple", "quantity" => 1, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "fulfillment_service" => "shipwire-app", "grams" => 567, "tax_lines" => [{"rate" => 0.05, "title" => "GST", "price" => "9.95"}, {"rate" => 0.08, "title" => "Tax", "price" => "15.92"}], "applied_discount" => nil, "name" => "IPod Touch 8GB - Black", "properties" => [], "custom" => false, "price" => "199.00", "admin_graphql_api_id" => "gid://shopify/DraftOrderLineItem/1066630403"}], "shipping_address" => nil, "billing_address" => {"first_name" => "Bob", "address1" => "123 Main St", "phone" => "555-555-5555", "city" => "Anytown", "zip" => "A1B2C3", "province" => "Ontario", "country" => "Canada", "last_name" => "Norman", "address2" => nil, "company" => nil, "latitude" => nil, "longitude" => nil, "name" => "Bob Norman", "country_code" => "CA", "province_code" => "ON"}, "invoice_url" => "https://jsmith.myshopify.com/548380009/invoices/c58f6e0a25b8ca56e2d18f717ab2b0ca", "applied_discount" => nil, "order_id" => nil, "shipping_line" => nil, "tax_lines" => [{"rate" => 0.05, "title" => "GST", "price" => "9.95"}, {"rate" => 0.08, "title" => "Tax", "price" => "15.92"}], "tags" => "", "note_attributes" => [], "total_price" => "224.87", "subtotal_price" => "199.00", "total_tax" => "25.87", "presentment_currency" => "USD", "total_line_items_price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_price_set" => {"shop_money" => {"amount" => "224.87", "currency_code" => "USD"}, "presentment_money" => {"amount" => "224.87", "currency_code" => "USD"}}, "subtotal_price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_tax_set" => {"shop_money" => {"amount" => "25.87", "currency_code" => "USD"}, "presentment_money" => {"amount" => "25.87", "currency_code" => "USD"}}, "total_discounts_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "total_shipping_price_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "payment_terms" => nil, "admin_graphql_api_id" => "gid://shopify/DraftOrder/1069920491", "customer" => {"id" => 1073339460, "email" => nil, "accepts_marketing" => false, "created_at" => "2023-02-13T10:29:34-05:00", "updated_at" => "2023-02-13T10:29:34-05:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 0, "state" => "disabled", "total_spent" => "0.00", "last_order_id" => nil, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "", "last_order_name" => nil, "currency" => "USD", "phone" => nil, "accepts_marketing_updated_at" => "2023-02-13T10:29:34-05:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => nil, "sms_marketing_consent" => nil, "admin_graphql_api_id" => "gid://shopify/Customer/1073339460", "default_address" => {"id" => 1053317294, "customer_id" => 1073339460, "first_name" => "Bob", "last_name" => "Norman", "company" => nil, "address1" => "123 Main St", "address2" => nil, "city" => "Anytown", "province" => nil, "country" => "Canada", "zip" => "A1B2C3", "phone" => "555-555-5555", "name" => "Bob Norman", "province_code" => nil, "country_code" => "CA", "country_name" => "Canada", "default" => true}}}}), headers: {})

    draft_order = ShopifyAPI::DraftOrder.new
    draft_order.line_items = [
      {
        "variant_id" => 447654529,
        "quantity" => 1
      }
    ]
    draft_order.billing_address = {
      "first_name" => "Bob",
      "last_name" => "Norman",
      "address1" => "123 Main St",
      "city" => "Anytown",
      "province" => "ON",
      "country" => "Canada",
      "zip" => "A1B2C3",
      "phone" => "555-555-5555"
    }
    draft_order.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "draft_order" => hash_including({"line_items" => [{"variant_id" => 447654529, "quantity" => 1}], "shipping_address" => {"first_name" => "Bob", "last_name" => "Norman", "address1" => "123 Main St", "city" => "Anytown", "province" => "ON", "country" => "Canada", "zip" => "A1B2C3", "phone" => "555-555-5555"}}) }
      )
      .to_return(status: 200, body: JSON.generate({"draft_order" => {"id" => 1069920497, "note" => nil, "email" => nil, "taxes_included" => false, "currency" => "USD", "invoice_sent_at" => nil, "created_at" => "2023-02-13T10:30:19-05:00", "updated_at" => "2023-02-13T10:30:19-05:00", "tax_exempt" => false, "completed_at" => nil, "name" => "#D5", "status" => "open", "line_items" => [{"id" => 1066630410, "variant_id" => 447654529, "product_id" => 921728736, "title" => "IPod Touch 8GB", "variant_title" => "Black", "sku" => "IPOD2009BLACK", "vendor" => "Apple", "quantity" => 1, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "fulfillment_service" => "shipwire-app", "grams" => 567, "tax_lines" => [{"rate" => 0.05, "title" => "GST", "price" => "9.95"}, {"rate" => 0.08, "title" => "Tax", "price" => "15.92"}], "applied_discount" => nil, "name" => "IPod Touch 8GB - Black", "properties" => [], "custom" => false, "price" => "199.00", "admin_graphql_api_id" => "gid://shopify/DraftOrderLineItem/1066630410"}], "shipping_address" => {"first_name" => "Bob", "address1" => "123 Main St", "phone" => "555-555-5555", "city" => "Anytown", "zip" => "A1B2C3", "province" => "Ontario", "country" => "Canada", "last_name" => "Norman", "address2" => nil, "company" => nil, "latitude" => nil, "longitude" => nil, "name" => "Bob Norman", "country_code" => "CA", "province_code" => "ON"}, "billing_address" => nil, "invoice_url" => "https://jsmith.myshopify.com/548380009/invoices/ab387d8ce82d1620ff120da41fb7a60f", "applied_discount" => nil, "order_id" => nil, "shipping_line" => nil, "tax_lines" => [{"rate" => 0.05, "title" => "GST", "price" => "9.95"}, {"rate" => 0.08, "title" => "Tax", "price" => "15.92"}], "tags" => "", "note_attributes" => [], "total_price" => "224.87", "subtotal_price" => "199.00", "total_tax" => "25.87", "presentment_currency" => "USD", "total_line_items_price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_price_set" => {"shop_money" => {"amount" => "224.87", "currency_code" => "USD"}, "presentment_money" => {"amount" => "224.87", "currency_code" => "USD"}}, "subtotal_price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_tax_set" => {"shop_money" => {"amount" => "25.87", "currency_code" => "USD"}, "presentment_money" => {"amount" => "25.87", "currency_code" => "USD"}}, "total_discounts_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "total_shipping_price_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "payment_terms" => nil, "admin_graphql_api_id" => "gid://shopify/DraftOrder/1069920497", "customer" => {"id" => 1073339461, "email" => nil, "accepts_marketing" => false, "created_at" => "2023-02-13T10:30:19-05:00", "updated_at" => "2023-02-13T10:30:19-05:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 0, "state" => "disabled", "total_spent" => "0.00", "last_order_id" => nil, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "", "last_order_name" => nil, "currency" => "USD", "phone" => nil, "accepts_marketing_updated_at" => "2023-02-13T10:30:19-05:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => nil, "sms_marketing_consent" => nil, "admin_graphql_api_id" => "gid://shopify/Customer/1073339461", "default_address" => {"id" => 1053317297, "customer_id" => 1073339461, "first_name" => "Bob", "last_name" => "Norman", "company" => nil, "address1" => "123 Main St", "address2" => nil, "city" => "Anytown", "province" => nil, "country" => "Canada", "zip" => "A1B2C3", "phone" => "555-555-5555", "name" => "Bob Norman", "province_code" => nil, "country_code" => "CA", "country_name" => "Canada", "default" => true}}}}), headers: {})

    draft_order = ShopifyAPI::DraftOrder.new
    draft_order.line_items = [
      {
        "variant_id" => 447654529,
        "quantity" => 1
      }
    ]
    draft_order.shipping_address = {
      "first_name" => "Bob",
      "last_name" => "Norman",
      "address1" => "123 Main St",
      "city" => "Anytown",
      "province" => "ON",
      "country" => "Canada",
      "zip" => "A1B2C3",
      "phone" => "555-555-5555"
    }
    draft_order.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "draft_order" => hash_including({"line_items" => [{"title" => "Custom Tee", "price" => "20.00", "quantity" => 1, "applied_discount" => {"description" => "Custom discount", "value_type" => "fixed_amount", "value" => "10.0", "amount" => "10.0", "title" => "Custom"}}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"draft_order" => {"id" => 1069920496, "note" => nil, "email" => nil, "taxes_included" => false, "currency" => "USD", "invoice_sent_at" => nil, "created_at" => "2023-02-13T10:30:08-05:00", "updated_at" => "2023-02-13T10:30:08-05:00", "tax_exempt" => false, "completed_at" => nil, "name" => "#D5", "status" => "open", "line_items" => [{"id" => 1066630409, "variant_id" => nil, "product_id" => nil, "title" => "Custom Tee", "variant_title" => nil, "sku" => nil, "vendor" => nil, "quantity" => 1, "requires_shipping" => false, "taxable" => true, "gift_card" => false, "fulfillment_service" => "manual", "grams" => 0, "tax_lines" => [{"rate" => 0.05, "title" => "GST", "price" => "0.50"}, {"rate" => 0.08, "title" => "Tax", "price" => "0.80"}], "applied_discount" => {"description" => "Custom discount", "value" => "10.0", "title" => "Custom", "amount" => "10.00", "value_type" => "fixed_amount"}, "name" => "Custom Tee", "properties" => [], "custom" => true, "price" => "20.00", "admin_graphql_api_id" => "gid://shopify/DraftOrderLineItem/1066630409"}], "shipping_address" => nil, "billing_address" => nil, "invoice_url" => "https://jsmith.myshopify.com/548380009/invoices/8a647b99d9d113c1fa50712ac19216da", "applied_discount" => nil, "order_id" => nil, "shipping_line" => nil, "tax_lines" => [{"rate" => 0.05, "title" => "GST", "price" => "0.50"}, {"rate" => 0.08, "title" => "Tax", "price" => "0.80"}], "tags" => "", "note_attributes" => [], "total_price" => "11.30", "subtotal_price" => "10.00", "total_tax" => "1.30", "presentment_currency" => "USD", "total_line_items_price_set" => {"shop_money" => {"amount" => "20.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "20.00", "currency_code" => "USD"}}, "total_price_set" => {"shop_money" => {"amount" => "11.30", "currency_code" => "USD"}, "presentment_money" => {"amount" => "11.30", "currency_code" => "USD"}}, "subtotal_price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_tax_set" => {"shop_money" => {"amount" => "1.30", "currency_code" => "USD"}, "presentment_money" => {"amount" => "1.30", "currency_code" => "USD"}}, "total_discounts_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_shipping_price_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "payment_terms" => nil, "admin_graphql_api_id" => "gid://shopify/DraftOrder/1069920496"}}), headers: {})

    draft_order = ShopifyAPI::DraftOrder.new
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
    draft_order.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "draft_order" => hash_including({"line_items" => [{"variant_id" => 447654529, "quantity" => 1}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"draft_order" => {"id" => 1069920493, "note" => nil, "email" => nil, "taxes_included" => false, "currency" => "USD", "invoice_sent_at" => nil, "created_at" => "2023-02-13T10:29:49-05:00", "updated_at" => "2023-02-13T10:29:49-05:00", "tax_exempt" => false, "completed_at" => nil, "name" => "#D5", "status" => "open", "line_items" => [{"id" => 1066630405, "variant_id" => 447654529, "product_id" => 921728736, "title" => "IPod Touch 8GB", "variant_title" => "Black", "sku" => "IPOD2009BLACK", "vendor" => "Apple", "quantity" => 1, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "fulfillment_service" => "shipwire-app", "grams" => 567, "tax_lines" => [{"rate" => 0.05, "title" => "GST", "price" => "9.95"}, {"rate" => 0.08, "title" => "Tax", "price" => "15.92"}], "applied_discount" => nil, "name" => "IPod Touch 8GB - Black", "properties" => [], "custom" => false, "price" => "199.00", "admin_graphql_api_id" => "gid://shopify/DraftOrderLineItem/1066630405"}], "shipping_address" => nil, "billing_address" => nil, "invoice_url" => "https://jsmith.myshopify.com/548380009/invoices/82d3e89892d7a92ab3b2a778b78b3021", "applied_discount" => nil, "order_id" => nil, "shipping_line" => nil, "tax_lines" => [{"rate" => 0.05, "title" => "GST", "price" => "9.95"}, {"rate" => 0.08, "title" => "Tax", "price" => "15.92"}], "tags" => "", "note_attributes" => [], "total_price" => "224.87", "subtotal_price" => "199.00", "total_tax" => "25.87", "presentment_currency" => "USD", "total_line_items_price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_price_set" => {"shop_money" => {"amount" => "224.87", "currency_code" => "USD"}, "presentment_money" => {"amount" => "224.87", "currency_code" => "USD"}}, "subtotal_price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_tax_set" => {"shop_money" => {"amount" => "25.87", "currency_code" => "USD"}, "presentment_money" => {"amount" => "25.87", "currency_code" => "USD"}}, "total_discounts_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "total_shipping_price_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "payment_terms" => nil, "admin_graphql_api_id" => "gid://shopify/DraftOrder/1069920493"}}), headers: {})

    draft_order = ShopifyAPI::DraftOrder.new
    draft_order.line_items = [
      {
        "variant_id" => 447654529,
        "quantity" => 1
      }
    ]
    draft_order.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"draft_orders" => [{"id" => 72885271, "note" => "rush order", "email" => "bob.norman@mail.example.com", "taxes_included" => true, "currency" => "USD", "invoice_sent_at" => nil, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:18:48-05:00", "tax_exempt" => false, "completed_at" => nil, "name" => "#D4", "status" => "completed", "line_items" => [{"id" => 498266019, "variant_id" => 39072856, "product_id" => 632910392, "title" => "IPod Nano - 8gb", "variant_title" => "green", "sku" => "IPOD2008GREEN", "vendor" => nil, "quantity" => 2, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "fulfillment_service" => "manual", "grams" => 567, "tax_lines" => [], "applied_discount" => nil, "name" => "IPod Nano - 8gb - green", "properties" => [], "custom" => false, "price" => "199.00", "admin_graphql_api_id" => "gid://shopify/DraftOrderLineItem/498266019"}], "shipping_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "billing_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "invoice_url" => "https://jsmith.myshopify.com/548380009/invoices/f945c7e2b158dbb69fa642cb8d79171f", "applied_discount" => nil, "order_id" => 450789469, "shipping_line" => nil, "tax_lines" => [], "tags" => "", "note_attributes" => [], "total_price" => "409.94", "subtotal_price" => "398.00", "total_tax" => "11.94", "admin_graphql_api_id" => "gid://shopify/DraftOrder/72885271", "customer" => {"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => false, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:18:48-05:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1001", "currency" => "USD", "phone" => "+16136120707", "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}}, {"id" => 622762746, "note" => "rush order", "email" => "bob.norman@mail.example.com", "taxes_included" => false, "currency" => "USD", "invoice_sent_at" => nil, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:18:48-05:00", "tax_exempt" => false, "completed_at" => nil, "name" => "#D1", "status" => "open", "line_items" => [{"id" => 466157049, "variant_id" => 39072856, "product_id" => 632910392, "title" => "IPod Nano - 8gb", "variant_title" => "green", "sku" => "IPOD2008GREEN", "vendor" => nil, "quantity" => 1, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "fulfillment_service" => "manual", "grams" => 567, "tax_lines" => [], "applied_discount" => nil, "name" => "IPod Nano - 8gb - green", "properties" => [], "custom" => false, "price" => "199.00", "admin_graphql_api_id" => "gid://shopify/DraftOrderLineItem/466157049"}, {"id" => 605833968, "variant_id" => nil, "product_id" => nil, "title" => "IPod Nano Engraving", "variant_title" => nil, "sku" => "IPODENGRAVING", "vendor" => nil, "quantity" => 1, "requires_shipping" => false, "taxable" => true, "gift_card" => false, "fulfillment_service" => "manual", "grams" => 0, "tax_lines" => [], "applied_discount" => nil, "name" => "IPod Nano Engraving", "properties" => [], "custom" => true, "price" => "30.00", "admin_graphql_api_id" => "gid://shopify/DraftOrderLineItem/605833968"}, {"id" => 783764327, "variant_id" => 457924702, "product_id" => 632910392, "title" => "IPod Nano - 8gb", "variant_title" => "black", "sku" => "IPOD2008BLACK", "vendor" => nil, "quantity" => 3, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "fulfillment_service" => "manual", "grams" => 567, "tax_lines" => [], "applied_discount" => nil, "name" => "IPod Nano - 8gb - black", "properties" => [], "custom" => false, "price" => "199.00", "admin_graphql_api_id" => "gid://shopify/DraftOrderLineItem/783764327"}], "shipping_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "billing_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "invoice_url" => "https://jsmith.myshopify.com/548380009/invoices/f1df1a91d10a6d7704cf2f0315461api", "applied_discount" => nil, "order_id" => nil, "shipping_line" => {"title" => "custom shipping", "custom" => true, "handle" => nil, "price" => "10.00"}, "tax_lines" => [], "tags" => "", "note_attributes" => [], "total_price" => "836.00", "subtotal_price" => "826.00", "total_tax" => "0.00", "admin_graphql_api_id" => "gid://shopify/DraftOrder/622762746", "customer" => {"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => false, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:18:48-05:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1001", "currency" => "USD", "phone" => "+16136120707", "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}}, {"id" => 691042898, "note" => "rush order", "email" => "bob.norman@mail.example.com", "taxes_included" => true, "currency" => "USD", "invoice_sent_at" => "2016-12-31T19:00:00-05:00", "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:18:48-05:00", "tax_exempt" => false, "completed_at" => "2016-12-31T19:00:00-05:00", "name" => "#D4", "status" => "completed", "line_items" => [{"id" => 158115779, "variant_id" => 39072856, "product_id" => 632910392, "title" => "IPod Nano - 8gb", "variant_title" => "green", "sku" => "IPOD2008GREEN", "vendor" => nil, "quantity" => 1, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "fulfillment_service" => "manual", "grams" => 567, "tax_lines" => [], "applied_discount" => nil, "name" => "IPod Nano - 8gb - green", "properties" => [], "custom" => false, "price" => "199.00", "admin_graphql_api_id" => "gid://shopify/DraftOrderLineItem/158115779"}], "shipping_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "billing_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "invoice_url" => "https://jsmith.myshopify.com/548380009/invoices/56dd92fb7adc1a2c38402b1aab15b2f4", "applied_discount" => nil, "order_id" => 450789469, "shipping_line" => {"title" => "UPS Ground", "custom" => false, "handle" => "ups-3-12.25", "price" => "12.25"}, "tax_lines" => [], "tags" => "", "note_attributes" => [], "total_price" => "409.94", "subtotal_price" => "398.00", "total_tax" => "11.94", "admin_graphql_api_id" => "gid://shopify/DraftOrder/691042898", "customer" => {"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => false, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:18:48-05:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1001", "currency" => "USD", "phone" => "+16136120707", "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}}, {"id" => 994118539, "note" => "rush order", "email" => "bob.norman@mail.example.com", "taxes_included" => false, "currency" => "USD", "invoice_sent_at" => nil, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:18:48-05:00", "tax_exempt" => false, "completed_at" => nil, "name" => "#D2", "status" => "open", "line_items" => [{"id" => 994118539, "variant_id" => 39072856, "product_id" => 632910392, "title" => "IPod Nano - 8gb", "variant_title" => "green", "sku" => "IPOD2008GREEN", "vendor" => nil, "quantity" => 1, "requires_shipping" => false, "taxable" => true, "gift_card" => false, "fulfillment_service" => "manual", "grams" => 567, "tax_lines" => [], "applied_discount" => nil, "name" => "IPod Nano - 8gb - green", "properties" => [], "custom" => false, "price" => "199.00", "admin_graphql_api_id" => "gid://shopify/DraftOrderLineItem/994118539"}], "shipping_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "billing_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "invoice_url" => "https://jsmith.myshopify.com/548380009/invoices/ba8dcf6c022ccad3d47e3909e378e33f", "applied_discount" => {"description" => "$5promo", "value" => "5.0", "title" => nil, "amount" => "5.00", "value_type" => "fixed_amount"}, "order_id" => nil, "shipping_line" => {"title" => "UPS Ground", "custom" => false, "handle" => "ups-3-12.25", "price" => "12.25"}, "tax_lines" => [], "tags" => "Wholesale", "note_attributes" => [], "total_price" => "206.25", "subtotal_price" => "194.00", "total_tax" => "0.00", "admin_graphql_api_id" => "gid://shopify/DraftOrder/994118539", "customer" => {"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => false, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:18:48-05:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1001", "currency" => "USD", "phone" => "+16136120707", "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}}, {"id" => 1012750869, "note" => "rush order", "email" => "bob.norman@mail.example.com", "taxes_included" => false, "currency" => "USD", "invoice_sent_at" => nil, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:18:48-05:00", "tax_exempt" => false, "completed_at" => nil, "name" => "#D2", "status" => "open", "line_items" => [{"id" => 294997122, "variant_id" => 39072856, "product_id" => 632910392, "title" => "IPod Nano - 8gb", "variant_title" => "green", "sku" => "IPOD2008GREEN", "vendor" => nil, "quantity" => 1, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "fulfillment_service" => "manual", "grams" => 567, "tax_lines" => [], "applied_discount" => nil, "name" => "IPod Nano - 8gb - green", "properties" => [], "custom" => false, "price" => "199.00", "admin_graphql_api_id" => "gid://shopify/DraftOrderLineItem/294997122"}], "shipping_address" => nil, "billing_address" => nil, "invoice_url" => "https://jsmith.myshopify.com/548380009/invoices/f1df1a91d10a6d7704cf2f0315461noaddressapi", "applied_discount" => nil, "order_id" => nil, "shipping_line" => nil, "tax_lines" => [], "tags" => "", "note_attributes" => [], "total_price" => "836.00", "subtotal_price" => "826.00", "total_tax" => "0.00", "admin_graphql_api_id" => "gid://shopify/DraftOrder/1012750869"}]}), headers: {})

    ShopifyAPI::DraftOrder.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders/994118539.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "draft_order" => hash_including({"applied_discount" => {"description" => "Custom discount", "value_type" => "percentage", "value" => "10.0", "amount" => "19.90", "title" => "Custom"}}) }
      )
      .to_return(status: 200, body: JSON.generate({"draft_order" => {"id" => 994118539, "note" => "rush order", "email" => "bob.norman@mail.example.com", "taxes_included" => false, "currency" => "USD", "invoice_sent_at" => nil, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:29:57-05:00", "tax_exempt" => false, "completed_at" => nil, "name" => "#D2", "status" => "open", "line_items" => [{"id" => 994118539, "variant_id" => 39072856, "product_id" => 632910392, "title" => "IPod Nano - 8gb", "variant_title" => "green", "sku" => "IPOD2008GREEN", "vendor" => nil, "quantity" => 1, "requires_shipping" => false, "taxable" => true, "gift_card" => false, "fulfillment_service" => "manual", "grams" => 567, "tax_lines" => [], "applied_discount" => nil, "name" => "IPod Nano - 8gb - green", "properties" => [], "custom" => false, "price" => "199.00", "admin_graphql_api_id" => "gid://shopify/DraftOrderLineItem/994118539"}], "shipping_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "billing_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "invoice_url" => "https://jsmith.myshopify.com/548380009/invoices/ba8dcf6c022ccad3d47e3909e378e33f", "applied_discount" => {"description" => "Custom discount", "value" => "10.0", "title" => "Custom", "amount" => "19.90", "value_type" => "percentage"}, "order_id" => nil, "shipping_line" => nil, "tax_lines" => [], "tags" => "Wholesale", "note_attributes" => [], "total_price" => "179.10", "subtotal_price" => "179.10", "total_tax" => "0.00", "presentment_currency" => "USD", "total_line_items_price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_price_set" => {"shop_money" => {"amount" => "179.10", "currency_code" => "USD"}, "presentment_money" => {"amount" => "179.10", "currency_code" => "USD"}}, "subtotal_price_set" => {"shop_money" => {"amount" => "179.10", "currency_code" => "USD"}, "presentment_money" => {"amount" => "179.10", "currency_code" => "USD"}}, "total_tax_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "total_discounts_set" => {"shop_money" => {"amount" => "19.90", "currency_code" => "USD"}, "presentment_money" => {"amount" => "19.90", "currency_code" => "USD"}}, "total_shipping_price_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "payment_terms" => nil, "admin_graphql_api_id" => "gid://shopify/DraftOrder/994118539", "customer" => {"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => false, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:18:48-05:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1001", "currency" => "USD", "phone" => "+16136120707", "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => nil, "consent_updated_at" => "2004-06-13T11:57:11-04:00"}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => "2023-02-13T10:18:48-05:00", "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}}}), headers: {})

    draft_order = ShopifyAPI::DraftOrder.new
    draft_order.id = 994118539
    draft_order.applied_discount = {
      "description" => "Custom discount",
      "value_type" => "percentage",
      "value" => "10.0",
      "amount" => "19.90",
      "title" => "Custom"
    }
    draft_order.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders/994118539.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders/994118539.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "draft_order" => hash_including({"note" => "Customer contacted us about a custom engraving on this iPod"}) }
      )
      .to_return(status: 200, body: JSON.generate({"draft_order" => {"id" => 994118539, "note" => "Customer contacted us about a custom engraving on this iPod", "email" => "bob.norman@mail.example.com", "taxes_included" => false, "currency" => "USD", "invoice_sent_at" => nil, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:29:52-05:00", "tax_exempt" => false, "completed_at" => nil, "name" => "#D2", "status" => "open", "line_items" => [{"id" => 994118539, "variant_id" => 39072856, "product_id" => 632910392, "title" => "IPod Nano - 8gb", "variant_title" => "green", "sku" => "IPOD2008GREEN", "vendor" => nil, "quantity" => 1, "requires_shipping" => false, "taxable" => true, "gift_card" => false, "fulfillment_service" => "manual", "grams" => 567, "tax_lines" => [], "applied_discount" => nil, "name" => "IPod Nano - 8gb - green", "properties" => [], "custom" => false, "price" => "199.00", "admin_graphql_api_id" => "gid://shopify/DraftOrderLineItem/994118539"}], "shipping_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "billing_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "invoice_url" => "https://jsmith.myshopify.com/548380009/invoices/ba8dcf6c022ccad3d47e3909e378e33f", "applied_discount" => {"description" => "$5promo", "value" => "5.0", "title" => nil, "amount" => "5.00", "value_type" => "fixed_amount"}, "order_id" => nil, "shipping_line" => nil, "tax_lines" => [], "tags" => "Wholesale", "note_attributes" => [], "total_price" => "194.00", "subtotal_price" => "194.00", "total_tax" => "0.00", "presentment_currency" => "USD", "total_line_items_price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_price_set" => {"shop_money" => {"amount" => "194.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "194.00", "currency_code" => "USD"}}, "subtotal_price_set" => {"shop_money" => {"amount" => "194.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "194.00", "currency_code" => "USD"}}, "total_tax_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "total_discounts_set" => {"shop_money" => {"amount" => "5.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "5.00", "currency_code" => "USD"}}, "total_shipping_price_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "payment_terms" => nil, "admin_graphql_api_id" => "gid://shopify/DraftOrder/994118539", "customer" => {"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => false, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:18:48-05:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1001", "currency" => "USD", "phone" => "+16136120707", "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => nil, "consent_updated_at" => "2004-06-13T11:57:11-04:00"}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => "2023-02-13T10:18:48-05:00", "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}}}), headers: {})

    draft_order = ShopifyAPI::DraftOrder.new
    draft_order.id = 994118539
    draft_order.note = "Customer contacted us about a custom engraving on this iPod"
    draft_order.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders/994118539.json")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders/994118539.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "draft_order" => hash_including({"line_items" => [{"variant_id" => 447654529, "quantity" => 1}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"draft_order" => {"id" => 994118539, "note" => "rush order", "email" => "bob.norman@mail.example.com", "taxes_included" => false, "currency" => "USD", "invoice_sent_at" => nil, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:29:59-05:00", "tax_exempt" => false, "completed_at" => nil, "name" => "#D2", "status" => "open", "line_items" => [{"id" => 1066630406, "variant_id" => 447654529, "product_id" => 921728736, "title" => "IPod Touch 8GB", "variant_title" => "Black", "sku" => "IPOD2009BLACK", "vendor" => "Apple", "quantity" => 1, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "fulfillment_service" => "shipwire-app", "grams" => 567, "tax_lines" => [], "applied_discount" => nil, "name" => "IPod Touch 8GB - Black", "properties" => [], "custom" => false, "price" => "199.00", "admin_graphql_api_id" => "gid://shopify/DraftOrderLineItem/1066630406"}], "shipping_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "billing_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "invoice_url" => "https://jsmith.myshopify.com/548380009/invoices/ba8dcf6c022ccad3d47e3909e378e33f", "applied_discount" => {"description" => "$5promo", "value" => "5.0", "title" => nil, "amount" => "5.00", "value_type" => "fixed_amount"}, "order_id" => nil, "shipping_line" => {"title" => "UPS Ground", "custom" => false, "handle" => "ups-3-12.25", "price" => "12.25"}, "tax_lines" => [], "tags" => "Wholesale", "note_attributes" => [], "total_price" => "206.25", "subtotal_price" => "194.00", "total_tax" => "0.00", "presentment_currency" => "USD", "total_line_items_price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_price_set" => {"shop_money" => {"amount" => "206.25", "currency_code" => "USD"}, "presentment_money" => {"amount" => "206.25", "currency_code" => "USD"}}, "subtotal_price_set" => {"shop_money" => {"amount" => "194.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "194.00", "currency_code" => "USD"}}, "total_tax_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "total_discounts_set" => {"shop_money" => {"amount" => "5.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "5.00", "currency_code" => "USD"}}, "total_shipping_price_set" => {"shop_money" => {"amount" => "12.25", "currency_code" => "USD"}, "presentment_money" => {"amount" => "12.25", "currency_code" => "USD"}}, "payment_terms" => nil, "admin_graphql_api_id" => "gid://shopify/DraftOrder/994118539", "customer" => {"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => false, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:18:48-05:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1001", "currency" => "USD", "phone" => "+16136120707", "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => nil, "consent_updated_at" => "2004-06-13T11:57:11-04:00"}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => "2023-02-13T10:18:48-05:00", "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}}}), headers: {})

    draft_order = ShopifyAPI::DraftOrder.new
    draft_order.id = 994118539
    draft_order.line_items = [
      {
        "variant_id" => 447654529,
        "quantity" => 1
      }
    ]
    draft_order.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders/994118539.json")
  end

  sig do
    void
  end
  def test_12()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders/994118539.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"draft_order" => {"id" => 994118539, "note" => "rush order", "email" => "bob.norman@mail.example.com", "taxes_included" => false, "currency" => "USD", "invoice_sent_at" => nil, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:18:48-05:00", "tax_exempt" => false, "completed_at" => nil, "name" => "#D2", "status" => "open", "line_items" => [{"id" => 994118539, "variant_id" => 39072856, "product_id" => 632910392, "title" => "IPod Nano - 8gb", "variant_title" => "green", "sku" => "IPOD2008GREEN", "vendor" => nil, "quantity" => 1, "requires_shipping" => false, "taxable" => true, "gift_card" => false, "fulfillment_service" => "manual", "grams" => 567, "tax_lines" => [], "applied_discount" => nil, "name" => "IPod Nano - 8gb - green", "properties" => [], "custom" => false, "price" => "199.00", "admin_graphql_api_id" => "gid://shopify/DraftOrderLineItem/994118539"}], "shipping_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "billing_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "invoice_url" => "https://jsmith.myshopify.com/548380009/invoices/ba8dcf6c022ccad3d47e3909e378e33f", "applied_discount" => {"description" => "$5promo", "value" => "5.0", "title" => nil, "amount" => "5.00", "value_type" => "fixed_amount"}, "order_id" => nil, "shipping_line" => {"title" => "UPS Ground", "custom" => false, "handle" => "ups-3-12.25", "price" => "12.25"}, "tax_lines" => [], "tags" => "Wholesale", "note_attributes" => [], "total_price" => "206.25", "subtotal_price" => "194.00", "total_tax" => "0.00", "payment_terms" => nil, "admin_graphql_api_id" => "gid://shopify/DraftOrder/994118539", "customer" => {"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => false, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:18:48-05:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 1, "state" => "disabled", "total_spent" => "199.65", "last_order_id" => 450789469, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1001", "currency" => "USD", "phone" => "+16136120707", "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => nil, "consent_updated_at" => "2004-06-13T11:57:11-04:00"}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => "2023-02-13T10:18:48-05:00", "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}}}), headers: {})

    ShopifyAPI::DraftOrder.find(
      id: 994118539,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders/994118539.json")
  end

  sig do
    void
  end
  def test_13()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders/994118539.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::DraftOrder.delete(
      id: 994118539,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders/994118539.json")
  end

  sig do
    void
  end
  def test_14()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 5}), headers: {})

    ShopifyAPI::DraftOrder.count

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders/count.json")
  end

  sig do
    void
  end
  def test_15()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders/994118539/send_invoice.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({"draft_order_invoice" => {"to" => "first@example.com", "from" => "j.smith@example.com", "bcc" => ["j.smith@example.com"], "subject" => "Apple Computer Invoice", "custom_message" => "Thank you for ordering!"}})
      )
      .to_return(status: 200, body: JSON.generate({"draft_order_invoice" => {"to" => "first@example.com", "from" => "j.smith@example.com", "subject" => "Apple Computer Invoice", "custom_message" => "Thank you for ordering!", "bcc" => ["j.smith@example.com"]}}), headers: {})

    draft_order = ShopifyAPI::DraftOrder.new
    draft_order.id = 994118539
    draft_order.send_invoice(
      body: {"draft_order_invoice" => {"to" => "first@example.com", "from" => "j.smith@example.com", "bcc" => ["j.smith@example.com"], "subject" => "Apple Computer Invoice", "custom_message" => "Thank you for ordering!"}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders/994118539/send_invoice.json")
  end

  sig do
    void
  end
  def test_16()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders/994118539/send_invoice.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({"draft_order_invoice" => {}})
      )
      .to_return(status: 200, body: JSON.generate({"draft_order_invoice" => {"to" => "bob.norman@mail.example.com", "from" => "j.smith@example.com", "subject" => "Draft Order #D2", "custom_message" => "", "bcc" => []}}), headers: {})

    draft_order = ShopifyAPI::DraftOrder.new
    draft_order.id = 994118539
    draft_order.send_invoice(
      body: {"draft_order_invoice" => {}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders/994118539/send_invoice.json")
  end

  sig do
    void
  end
  def test_17()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders/994118539/complete.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"draft_order" => {"id" => 994118539, "note" => "rush order", "email" => "bob.norman@mail.example.com", "taxes_included" => false, "currency" => "USD", "invoice_sent_at" => nil, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:29:47-05:00", "tax_exempt" => false, "completed_at" => "2023-02-13T10:29:47-05:00", "name" => "#D2", "status" => "completed", "line_items" => [{"id" => 994118539, "variant_id" => 39072856, "product_id" => 632910392, "title" => "IPod Nano - 8gb", "variant_title" => "green", "sku" => "IPOD2008GREEN", "vendor" => nil, "quantity" => 1, "requires_shipping" => false, "taxable" => true, "gift_card" => false, "fulfillment_service" => "manual", "grams" => 567, "tax_lines" => [], "applied_discount" => nil, "name" => "IPod Nano - 8gb - green", "properties" => [], "custom" => false, "price" => "199.00", "admin_graphql_api_id" => "gid://shopify/DraftOrderLineItem/994118539"}], "shipping_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "billing_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "invoice_url" => "https://jsmith.myshopify.com/548380009/invoices/ba8dcf6c022ccad3d47e3909e378e33f", "applied_discount" => {"description" => "$5promo", "value" => "5.0", "title" => nil, "amount" => "5.00", "value_type" => "fixed_amount"}, "order_id" => 1073459966, "shipping_line" => {"title" => "UPS Ground", "custom" => false, "handle" => "ups-3-12.25", "price" => "12.25"}, "tax_lines" => [], "tags" => "Wholesale", "note_attributes" => [], "total_price" => "206.25", "subtotal_price" => "194.00", "total_tax" => "0.00", "presentment_currency" => "USD", "total_line_items_price_set" => {"shop_money" => {"amount" => "826.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "826.00", "currency_code" => "USD"}}, "total_price_set" => {"shop_money" => {"amount" => "206.25", "currency_code" => "USD"}, "presentment_money" => {"amount" => "206.25", "currency_code" => "USD"}}, "subtotal_price_set" => {"shop_money" => {"amount" => "194.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "194.00", "currency_code" => "USD"}}, "total_tax_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "total_discounts_set" => {"shop_money" => {"amount" => "5.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "5.00", "currency_code" => "USD"}}, "total_shipping_price_set" => {"shop_money" => {"amount" => "12.25", "currency_code" => "USD"}, "presentment_money" => {"amount" => "12.25", "currency_code" => "USD"}}, "payment_terms" => nil, "admin_graphql_api_id" => "gid://shopify/DraftOrder/994118539", "customer" => {"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => false, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:29:47-05:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 2, "state" => "disabled", "total_spent" => "405.90", "last_order_id" => 1073459966, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1002", "currency" => "USD", "phone" => "+16136120707", "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => nil, "consent_updated_at" => "2004-06-13T11:57:11-04:00"}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => "2023-02-13T10:18:48-05:00", "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}}}), headers: {})

    draft_order = ShopifyAPI::DraftOrder.new
    draft_order.id = 994118539
    draft_order.complete

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders/994118539/complete.json")
  end

  sig do
    void
  end
  def test_18()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders/994118539/complete.json?payment_pending=true")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"draft_order" => {"id" => 994118539, "note" => "rush order", "email" => "bob.norman@mail.example.com", "taxes_included" => false, "currency" => "USD", "invoice_sent_at" => nil, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:30:17-05:00", "tax_exempt" => false, "completed_at" => "2023-02-13T10:30:17-05:00", "name" => "#D2", "status" => "completed", "line_items" => [{"id" => 994118539, "variant_id" => 39072856, "product_id" => 632910392, "title" => "IPod Nano - 8gb", "variant_title" => "green", "sku" => "IPOD2008GREEN", "vendor" => nil, "quantity" => 1, "requires_shipping" => false, "taxable" => true, "gift_card" => false, "fulfillment_service" => "manual", "grams" => 567, "tax_lines" => [], "applied_discount" => nil, "name" => "IPod Nano - 8gb - green", "properties" => [], "custom" => false, "price" => "199.00", "admin_graphql_api_id" => "gid://shopify/DraftOrderLineItem/994118539"}], "shipping_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "billing_address" => {"first_name" => "Bob", "address1" => "Chestnut Street 92", "phone" => "+1(502)-459-2181", "city" => "Louisville", "zip" => "40202", "province" => "Kentucky", "country" => "United States", "last_name" => "Norman", "address2" => "", "company" => nil, "latitude" => 45.41634, "longitude" => -75.6868, "name" => "Bob Norman", "country_code" => "US", "province_code" => "KY"}, "invoice_url" => "https://jsmith.myshopify.com/548380009/invoices/ba8dcf6c022ccad3d47e3909e378e33f", "applied_discount" => {"description" => "$5promo", "value" => "5.0", "title" => nil, "amount" => "5.00", "value_type" => "fixed_amount"}, "order_id" => 1073459967, "shipping_line" => {"title" => "UPS Ground", "custom" => false, "handle" => "ups-3-12.25", "price" => "12.25"}, "tax_lines" => [], "tags" => "Wholesale", "note_attributes" => [], "total_price" => "206.25", "subtotal_price" => "194.00", "total_tax" => "0.00", "presentment_currency" => "USD", "total_line_items_price_set" => {"shop_money" => {"amount" => "826.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "826.00", "currency_code" => "USD"}}, "total_price_set" => {"shop_money" => {"amount" => "206.25", "currency_code" => "USD"}, "presentment_money" => {"amount" => "206.25", "currency_code" => "USD"}}, "subtotal_price_set" => {"shop_money" => {"amount" => "194.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "194.00", "currency_code" => "USD"}}, "total_tax_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "total_discounts_set" => {"shop_money" => {"amount" => "5.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "5.00", "currency_code" => "USD"}}, "total_shipping_price_set" => {"shop_money" => {"amount" => "12.25", "currency_code" => "USD"}, "presentment_money" => {"amount" => "12.25", "currency_code" => "USD"}}, "payment_terms" => nil, "admin_graphql_api_id" => "gid://shopify/DraftOrder/994118539", "customer" => {"id" => 207119551, "email" => "bob.norman@mail.example.com", "accepts_marketing" => false, "created_at" => "2023-02-13T10:18:48-05:00", "updated_at" => "2023-02-13T10:30:17-05:00", "first_name" => "Bob", "last_name" => "Norman", "orders_count" => 2, "state" => "disabled", "total_spent" => "405.90", "last_order_id" => 1073459967, "note" => nil, "verified_email" => true, "multipass_identifier" => nil, "tax_exempt" => false, "tags" => "L\u00E9on, No\u00EBl", "last_order_name" => "#1002", "currency" => "USD", "phone" => "+16136120707", "accepts_marketing_updated_at" => "2005-06-12T11:57:11-04:00", "marketing_opt_in_level" => nil, "tax_exemptions" => [], "email_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => nil, "consent_updated_at" => "2004-06-13T11:57:11-04:00"}, "sms_marketing_consent" => {"state" => "not_subscribed", "opt_in_level" => "single_opt_in", "consent_updated_at" => "2023-02-13T10:18:48-05:00", "consent_collected_from" => "OTHER"}, "admin_graphql_api_id" => "gid://shopify/Customer/207119551", "default_address" => {"id" => 207119551, "customer_id" => 207119551, "first_name" => nil, "last_name" => nil, "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "country" => "United States", "zip" => "40202", "phone" => "555-625-1199", "name" => "", "province_code" => "KY", "country_code" => "US", "country_name" => "United States", "default" => true}}}}), headers: {})

    draft_order = ShopifyAPI::DraftOrder.new
    draft_order.id = 994118539
    draft_order.complete(
      payment_pending: "true",
    )

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-07/draft_orders/994118539/complete.json?payment_pending=true")
  end

end
