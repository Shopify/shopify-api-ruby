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

class Payment202210Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-10")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x/payments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "payment" => hash_including({"request_details" => {"ip_address" => "123.1.1.1", "accept_language" => "en-US,en;q=0.8,fr;q=0.6", "user_agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36"}, "amount" => "398.00", "session_id" => "global-1c6ba91c7587d48d", "unique_token" => "client-side-idempotency-token"}) }
      )
      .to_return(status: 200, body: JSON.generate({"payment" => {"id" => 1071573807, "unique_token" => "client-side-idempotency-token", "payment_processing_error_message" => nil, "next_action" => {"redirect_url" => nil}, "fraudulent" => false, "transaction" => nil, "credit_card" => {"first_name" => "Bob", "last_name" => "Norman", "first_digits" => "424242", "last_digits" => "4242", "brand" => "bogus", "expiry_month" => 9, "expiry_year" => 2024, "customer_id" => 207119551}, "checkout" => {"completed_at" => nil, "created_at" => "2012-10-12T07:05:27-04:00", "currency" => "USD", "presentment_currency" => "USD", "customer_id" => 207119551, "customer_locale" => "en", "device_id" => nil, "discount_code" => nil, "discount_codes" => [], "email" => "bob.norman@mail.example.com", "legal_notice_url" => nil, "location_id" => nil, "name" => "#446514532", "note" => "", "note_attributes" => {"custom engraving" => "Happy Birthday", "colour" => "green"}, "order_id" => nil, "order_status_url" => nil, "order" => nil, "payment_due" => "398.00", "payment_url" => "https://app.local/cardserver/sessions", "payments" => [{"id" => 25428999, "unique_token" => "e01e661f4a99acd9dcdg6f1422d0d6f7", "payment_processing_error_message" => nil, "fraudulent" => false, "transaction" => {"amount" => "598.94", "amount_in" => nil, "amount_out" => nil, "amount_rounding" => nil, "authorization" => "authorization-key", "created_at" => "2005-08-01T11:57:11-04:00", "currency" => "USD", "error_code" => nil, "parent_id" => nil, "gateway" => "bogus", "id" => 389404469, "kind" => "authorization", "message" => nil, "status" => "success", "test" => false, "receipt" => {"testcase" => true, "authorization" => "123456"}, "location_id" => nil, "user_id" => nil, "transaction_group_id" => nil, "device_id" => nil, "payment_details" => {"credit_card_bin" => nil, "avs_result_code" => nil, "cvv_result_code" => nil, "credit_card_number" => "\u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 4242", "credit_card_company" => "Visa", "buyer_action_info" => nil, "credit_card_name" => nil, "credit_card_wallet" => nil, "credit_card_expiration_month" => nil, "credit_card_expiration_year" => nil}}, "credit_card" => nil}, {"id" => 1071573807, "unique_token" => "client-side-idempotency-token", "payment_processing_error_message" => nil, "fraudulent" => false, "transaction" => nil, "credit_card" => {"first_name" => "Bob", "last_name" => "Norman", "first_digits" => "424242", "last_digits" => "4242", "brand" => "bogus", "expiry_month" => 9, "expiry_year" => 2024, "customer_id" => 207119551}}], "phone" => nil, "shopify_payments_account_id" => nil, "privacy_policy_url" => nil, "refund_policy_url" => nil, "requires_shipping" => true, "reservation_time_left" => 0, "reservation_time" => nil, "source_identifier" => nil, "source_name" => "web", "source_url" => nil, "subscription_policy_url" => nil, "subtotal_price" => "398.00", "shipping_policy_url" => nil, "tax_exempt" => false, "taxes_included" => false, "terms_of_sale_url" => nil, "terms_of_service_url" => nil, "token" => "7yjf4v2we7gamku6a6h7tvm8h3mmvs4x", "total_price" => "398.00", "total_tax" => "0.00", "total_tip_received" => "0.00", "total_line_items_price" => "398.00", "updated_at" => "2023-04-03T11:51:33-04:00", "user_id" => nil, "web_url" => "https://checkout.local/548380009/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x", "total_duties" => nil, "total_additional_fees" => nil, "line_items" => [{"id" => "352984dce5b4d7c0", "key" => "352984dce5b4d7c0", "product_id" => 632910392, "variant_id" => 49148385, "sku" => "IPOD2008RED", "vendor" => "Apple", "title" => "IPod Nano - 8GB", "variant_title" => "Red", "image_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1680536691", "taxable" => true, "requires_shipping" => true, "gift_card" => false, "price" => "199.00", "compare_at_price" => nil, "line_price" => "199.00", "properties" => {}, "quantity" => 1, "grams" => 200, "fulfillment_service" => "manual", "applied_discounts" => [], "discount_allocations" => [], "tax_lines" => []}, {"id" => "57309d9cb0356550", "key" => "57309d9cb0356550", "product_id" => 632910392, "variant_id" => 808950810, "sku" => "IPOD2008PINK", "vendor" => "Apple", "title" => "IPod Nano - 8GB", "variant_title" => "Pink", "image_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1680536691", "taxable" => true, "requires_shipping" => true, "gift_card" => false, "price" => "199.00", "compare_at_price" => nil, "line_price" => "199.00", "properties" => {}, "quantity" => 1, "grams" => 200, "fulfillment_service" => "manual", "applied_discounts" => [], "discount_allocations" => [], "tax_lines" => []}], "gift_cards" => [], "tax_lines" => [], "tax_manipulations" => [], "shipping_line" => {"handle" => "shopify-Free%20Shipping-0.00", "price" => "0.00", "title" => "Free Shipping", "tax_lines" => []}, "shipping_rate" => {"id" => "shopify-Free%20Shipping-0.00", "price" => "0.00", "title" => "Free Shipping"}, "shipping_address" => {"id" => 550558813, "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "province_code" => "KY", "country" => "United States", "country_code" => "US", "zip" => "40202"}, "credit_card" => {"first_name" => "Bob", "last_name" => "Norman", "first_digits" => "424242", "last_digits" => "4242", "brand" => "bogus", "expiry_month" => 9, "expiry_year" => 2024, "customer_id" => 207119551}, "billing_address" => {"id" => 550558813, "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "province_code" => "KY", "country" => "United States", "country_code" => "US", "zip" => "40202"}, "applied_discount" => nil, "applied_discounts" => [], "discount_violations" => []}}}), headers: {})

    response = payment = ShopifyAPI::Payment.new
    payment.checkout_id = "7yjf4v2we7gamku6a6h7tvm8h3mmvs4x"
    payment.request_details = {
      "ip_address" => "123.1.1.1",
      "accept_language" => "en-US,en;q=0.8,fr;q=0.6",
      "user_agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36"
    }
    payment.amount = "398.00"
    payment.session_id = "global-1c6ba91c7587d48d"
    payment.unique_token = "client-side-idempotency-token"
    payment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x/payments.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x/payments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"payments" => [{"id" => 25428999, "unique_token" => "e01e661f4a99acd9dcdg6f1422d0d6f7", "payment_processing_error_message" => nil, "transaction" => {"amount" => "598.94", "amount_in" => nil, "amount_out" => nil, "amount_rounding" => nil, "authorization" => "authorization-key", "created_at" => "2005-08-01T11:57:11-04:00", "currency" => "USD", "error_code" => nil, "parent_id" => nil, "gateway" => "bogus", "id" => 389404469, "kind" => "authorization", "message" => nil, "status" => "success", "test" => false}, "credit_card" => nil, "checkout" => {"completed_at" => nil, "created_at" => "2012-10-12T07:05:27-04:00", "currency" => "USD", "presentment_currency" => "USD", "customer_id" => 207119551, "customer_locale" => "en", "device_id" => nil, "discount_code" => nil, "discount_codes" => [], "email" => "bob.norman@mail.example.com", "legal_notice_url" => nil, "location_id" => nil, "name" => "#446514532", "note" => "", "note_attributes" => {"custom engraving" => "Happy Birthday", "colour" => "green"}, "order_id" => nil, "order_status_url" => nil, "order" => nil, "payment_due" => "419.49", "payment_url" => "https://app.local/cardserver/sessions", "payments" => [{"id" => 25428999, "unique_token" => "e01e661f4a99acd9dcdg6f1422d0d6f7", "payment_processing_error_message" => nil, "transaction" => {"amount" => "598.94", "amount_in" => nil, "amount_out" => nil, "amount_rounding" => nil, "authorization" => "authorization-key", "created_at" => "2005-08-01T11:57:11-04:00", "currency" => "USD", "error_code" => nil, "parent_id" => nil, "gateway" => "bogus", "id" => 389404469, "kind" => "authorization", "message" => nil, "status" => "success", "test" => false}, "credit_card" => nil}], "phone" => nil, "shopify_payments_account_id" => nil, "privacy_policy_url" => nil, "refund_policy_url" => nil, "requires_shipping" => true, "reservation_time_left" => 0, "reservation_time" => nil, "source_identifier" => nil, "source_name" => "web", "source_url" => nil, "subscription_policy_url" => nil, "subtotal_price" => "398.00", "shipping_policy_url" => nil, "tax_exempt" => false, "taxes_included" => false, "terms_of_sale_url" => nil, "terms_of_service_url" => nil, "token" => "7yjf4v2we7gamku6a6h7tvm8h3mmvs4x", "total_price" => "419.49", "total_tax" => "21.49", "total_tip_received" => "0.00", "total_line_items_price" => "398.00", "updated_at" => "2012-10-12T07:05:27-04:00", "user_id" => nil, "web_url" => "https://checkout.local/548380009/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x", "total_duties" => nil, "total_additional_fees" => nil, "line_items" => [{"id" => "352984dce5b4d7c0", "key" => "352984dce5b4d7c0", "product_id" => 632910392, "variant_id" => 49148385, "sku" => "IPOD2008RED", "vendor" => "Apple", "title" => "IPod Nano - 8GB", "variant_title" => "Red", "image_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1680536691", "taxable" => true, "requires_shipping" => true, "gift_card" => false, "price" => "199.00", "compare_at_price" => nil, "line_price" => "199.00", "properties" => {}, "quantity" => 1, "grams" => 200, "fulfillment_service" => "manual", "applied_discounts" => [], "discount_allocations" => [], "tax_lines" => []}, {"id" => "57309d9cb0356550", "key" => "57309d9cb0356550", "product_id" => 632910392, "variant_id" => 808950810, "sku" => "IPOD2008PINK", "vendor" => "Apple", "title" => "IPod Nano - 8GB", "variant_title" => "Pink", "image_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1680536691", "taxable" => true, "requires_shipping" => true, "gift_card" => false, "price" => "199.00", "compare_at_price" => nil, "line_price" => "199.00", "properties" => {}, "quantity" => 1, "grams" => 200, "fulfillment_service" => "manual", "applied_discounts" => [], "discount_allocations" => [], "tax_lines" => []}], "gift_cards" => [], "tax_lines" => [{"price" => "21.49", "rate" => 0.06, "title" => "State Tax", "compare_at" => 0.06}], "tax_manipulations" => [], "shipping_line" => {"handle" => "shopify-Free%20Shipping-0.00", "price" => "0.00", "title" => "Free Shipping", "tax_lines" => []}, "shipping_rate" => {"id" => "shopify-Free%20Shipping-0.00", "price" => "0.00", "title" => "Free Shipping"}, "shipping_address" => {"id" => 550558813, "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "province_code" => "KY", "country" => "United States", "country_code" => "US", "zip" => "40202"}, "credit_card" => {"first_name" => "Bob", "last_name" => "Norman", "first_digits" => "1", "last_digits" => "1", "brand" => "bogus", "expiry_month" => 8, "expiry_year" => 2042, "customer_id" => nil}, "billing_address" => {"id" => 550558813, "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "province_code" => "KY", "country" => "United States", "country_code" => "US", "zip" => "40202"}, "applied_discount" => nil, "applied_discounts" => [], "discount_violations" => []}}]}), headers: {})

    response = ShopifyAPI::Payment.all(
      checkout_id: "7yjf4v2we7gamku6a6h7tvm8h3mmvs4x",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x/payments.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x/payments/25428999.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"payment" => {"id" => 25428999, "unique_token" => "e01e661f4a99acd9dcdg6f1422d0d6f7", "payment_processing_error_message" => nil, "next_action" => {"redirect_url" => nil}, "fraudulent" => false, "transaction" => {"amount" => "419.49", "amount_in" => nil, "amount_out" => nil, "amount_rounding" => nil, "authorization" => nil, "created_at" => "2023-04-03T11:51:38-04:00", "currency" => "USD", "error_code" => nil, "parent_id" => nil, "gateway" => "bogus", "id" => 1068278463, "kind" => "authorization", "message" => nil, "status" => "failure", "test" => false, "receipt" => {}, "location_id" => nil, "user_id" => nil, "transaction_group_id" => nil, "device_id" => nil, "payment_details" => nil}, "credit_card" => nil, "checkout" => {"completed_at" => nil, "created_at" => "2012-10-12T07:05:27-04:00", "currency" => "USD", "presentment_currency" => "USD", "customer_id" => 207119551, "customer_locale" => "en", "device_id" => nil, "discount_code" => nil, "discount_codes" => [], "email" => "bob.norman@mail.example.com", "legal_notice_url" => nil, "location_id" => nil, "name" => "#446514532", "note" => "", "note_attributes" => {"custom engraving" => "Happy Birthday", "colour" => "green"}, "order_id" => nil, "order_status_url" => nil, "order" => nil, "payment_due" => "419.49", "payment_url" => "https://app.local/cardserver/sessions", "payments" => [{"id" => 25428999, "unique_token" => "e01e661f4a99acd9dcdg6f1422d0d6f7", "payment_processing_error_message" => nil, "fraudulent" => false, "transaction" => {"amount" => "419.49", "amount_in" => nil, "amount_out" => nil, "amount_rounding" => nil, "authorization" => nil, "created_at" => "2023-04-03T11:51:38-04:00", "currency" => "USD", "error_code" => nil, "parent_id" => nil, "gateway" => "bogus", "id" => 1068278463, "kind" => "authorization", "message" => nil, "status" => "failure", "test" => false, "receipt" => {}, "location_id" => nil, "user_id" => nil, "transaction_group_id" => nil, "device_id" => nil, "payment_details" => nil}, "credit_card" => nil}], "phone" => nil, "shopify_payments_account_id" => nil, "privacy_policy_url" => nil, "refund_policy_url" => nil, "requires_shipping" => true, "reservation_time_left" => 0, "reservation_time" => nil, "source_identifier" => nil, "source_name" => "web", "source_url" => nil, "subscription_policy_url" => nil, "subtotal_price" => "398.00", "shipping_policy_url" => nil, "tax_exempt" => false, "taxes_included" => false, "terms_of_sale_url" => nil, "terms_of_service_url" => nil, "token" => "7yjf4v2we7gamku6a6h7tvm8h3mmvs4x", "total_price" => "419.49", "total_tax" => "21.49", "total_tip_received" => "0.00", "total_line_items_price" => "398.00", "updated_at" => "2012-10-12T07:05:27-04:00", "user_id" => nil, "web_url" => "https://checkout.local/548380009/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x", "total_duties" => nil, "total_additional_fees" => nil, "line_items" => [{"id" => "352984dce5b4d7c0", "key" => "352984dce5b4d7c0", "product_id" => 632910392, "variant_id" => 49148385, "sku" => "IPOD2008RED", "vendor" => "Apple", "title" => "IPod Nano - 8GB", "variant_title" => "Red", "image_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1680536691", "taxable" => true, "requires_shipping" => true, "gift_card" => false, "price" => "199.00", "compare_at_price" => nil, "line_price" => "199.00", "properties" => {}, "quantity" => 1, "grams" => 200, "fulfillment_service" => "manual", "applied_discounts" => [], "discount_allocations" => [], "tax_lines" => []}, {"id" => "57309d9cb0356550", "key" => "57309d9cb0356550", "product_id" => 632910392, "variant_id" => 808950810, "sku" => "IPOD2008PINK", "vendor" => "Apple", "title" => "IPod Nano - 8GB", "variant_title" => "Pink", "image_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1680536691", "taxable" => true, "requires_shipping" => true, "gift_card" => false, "price" => "199.00", "compare_at_price" => nil, "line_price" => "199.00", "properties" => {}, "quantity" => 1, "grams" => 200, "fulfillment_service" => "manual", "applied_discounts" => [], "discount_allocations" => [], "tax_lines" => []}], "gift_cards" => [], "tax_lines" => [{"price" => "21.49", "rate" => 0.06, "title" => "State Tax", "compare_at" => 0.06}], "tax_manipulations" => [], "shipping_line" => {"handle" => "shopify-Free%20Shipping-0.00", "price" => "0.00", "title" => "Free Shipping", "tax_lines" => []}, "shipping_rate" => {"id" => "shopify-Free%20Shipping-0.00", "price" => "0.00", "title" => "Free Shipping"}, "shipping_address" => {"id" => 550558813, "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "province_code" => "KY", "country" => "United States", "country_code" => "US", "zip" => "40202"}, "credit_card" => {"first_name" => "Bob", "last_name" => "Norman", "first_digits" => "1", "last_digits" => "1", "brand" => "bogus", "expiry_month" => 8, "expiry_year" => 2042, "customer_id" => nil}, "billing_address" => {"id" => 550558813, "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "province_code" => "KY", "country" => "United States", "country_code" => "US", "zip" => "40202"}, "applied_discount" => nil, "applied_discounts" => [], "discount_violations" => []}}}), headers: {})

    response = ShopifyAPI::Payment.find(
      checkout_id: "7yjf4v2we7gamku6a6h7tvm8h3mmvs4x",
      id: 25428999,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x/payments/25428999.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x/payments/25428999.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"payment" => {"id" => 25428999, "unique_token" => "e01e661f4a99acd9dcdg6f1422d0d6f7", "payment_processing_error_message" => nil, "next_action" => {"redirect_url" => nil}, "fraudulent" => false, "transaction" => {"amount" => "419.49", "amount_in" => nil, "amount_out" => nil, "amount_rounding" => nil, "authorization" => nil, "created_at" => "2023-04-03T11:51:42-04:00", "currency" => "USD", "error_code" => nil, "parent_id" => nil, "gateway" => "bogus", "id" => 1068278464, "kind" => "authorization", "message" => nil, "status" => "success", "test" => false, "receipt" => {}, "location_id" => nil, "user_id" => nil, "transaction_group_id" => nil, "device_id" => nil, "payment_details" => nil}, "credit_card" => nil, "checkout" => {"completed_at" => nil, "created_at" => "2012-10-12T07:05:27-04:00", "currency" => "USD", "presentment_currency" => "USD", "customer_id" => 207119551, "customer_locale" => "en", "device_id" => nil, "discount_code" => nil, "discount_codes" => [], "email" => "bob.norman@mail.example.com", "legal_notice_url" => nil, "location_id" => nil, "name" => "#446514532", "note" => "", "note_attributes" => {"custom engraving" => "Happy Birthday", "colour" => "green"}, "order_id" => nil, "order_status_url" => nil, "order" => nil, "payment_due" => "419.49", "payment_url" => "https://app.local/cardserver/sessions", "payments" => [{"id" => 25428999, "unique_token" => "e01e661f4a99acd9dcdg6f1422d0d6f7", "payment_processing_error_message" => nil, "fraudulent" => false, "transaction" => {"amount" => "419.49", "amount_in" => nil, "amount_out" => nil, "amount_rounding" => nil, "authorization" => nil, "created_at" => "2023-04-03T11:51:42-04:00", "currency" => "USD", "error_code" => nil, "parent_id" => nil, "gateway" => "bogus", "id" => 1068278464, "kind" => "authorization", "message" => nil, "status" => "success", "test" => false, "receipt" => {}, "location_id" => nil, "user_id" => nil, "transaction_group_id" => nil, "device_id" => nil, "payment_details" => nil}, "credit_card" => nil}], "phone" => nil, "shopify_payments_account_id" => nil, "privacy_policy_url" => nil, "refund_policy_url" => nil, "requires_shipping" => true, "reservation_time_left" => 0, "reservation_time" => nil, "source_identifier" => nil, "source_name" => "web", "source_url" => nil, "subscription_policy_url" => nil, "subtotal_price" => "398.00", "shipping_policy_url" => nil, "tax_exempt" => false, "taxes_included" => false, "terms_of_sale_url" => nil, "terms_of_service_url" => nil, "token" => "7yjf4v2we7gamku6a6h7tvm8h3mmvs4x", "total_price" => "419.49", "total_tax" => "21.49", "total_tip_received" => "0.00", "total_line_items_price" => "398.00", "updated_at" => "2012-10-12T07:05:27-04:00", "user_id" => nil, "web_url" => "https://checkout.local/548380009/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x", "total_duties" => nil, "total_additional_fees" => nil, "line_items" => [{"id" => "352984dce5b4d7c0", "key" => "352984dce5b4d7c0", "product_id" => 632910392, "variant_id" => 49148385, "sku" => "IPOD2008RED", "vendor" => "Apple", "title" => "IPod Nano - 8GB", "variant_title" => "Red", "image_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1680536691", "taxable" => true, "requires_shipping" => true, "gift_card" => false, "price" => "199.00", "compare_at_price" => nil, "line_price" => "199.00", "properties" => {}, "quantity" => 1, "grams" => 200, "fulfillment_service" => "manual", "applied_discounts" => [], "discount_allocations" => [], "tax_lines" => []}, {"id" => "57309d9cb0356550", "key" => "57309d9cb0356550", "product_id" => 632910392, "variant_id" => 808950810, "sku" => "IPOD2008PINK", "vendor" => "Apple", "title" => "IPod Nano - 8GB", "variant_title" => "Pink", "image_url" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1680536691", "taxable" => true, "requires_shipping" => true, "gift_card" => false, "price" => "199.00", "compare_at_price" => nil, "line_price" => "199.00", "properties" => {}, "quantity" => 1, "grams" => 200, "fulfillment_service" => "manual", "applied_discounts" => [], "discount_allocations" => [], "tax_lines" => []}], "gift_cards" => [], "tax_lines" => [{"price" => "21.49", "rate" => 0.06, "title" => "State Tax", "compare_at" => 0.06}], "tax_manipulations" => [], "shipping_line" => {"handle" => "shopify-Free%20Shipping-0.00", "price" => "0.00", "title" => "Free Shipping", "tax_lines" => []}, "shipping_rate" => {"id" => "shopify-Free%20Shipping-0.00", "price" => "0.00", "title" => "Free Shipping"}, "shipping_address" => {"id" => 550558813, "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "province_code" => "KY", "country" => "United States", "country_code" => "US", "zip" => "40202"}, "credit_card" => {"first_name" => "Bob", "last_name" => "Norman", "first_digits" => "1", "last_digits" => "1", "brand" => "bogus", "expiry_month" => 8, "expiry_year" => 2042, "customer_id" => nil}, "billing_address" => {"id" => 550558813, "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "company" => nil, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "province" => "Kentucky", "province_code" => "KY", "country" => "United States", "country_code" => "US", "zip" => "40202"}, "applied_discount" => nil, "applied_discounts" => [], "discount_violations" => []}}}), headers: {})

    response = ShopifyAPI::Payment.find(
      checkout_id: "7yjf4v2we7gamku6a6h7tvm8h3mmvs4x",
      id: 25428999,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x/payments/25428999.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x/payments/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    response = ShopifyAPI::Payment.count(
      checkout_id: "7yjf4v2we7gamku6a6h7tvm8h3mmvs4x",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/checkouts/7yjf4v2we7gamku6a6h7tvm8h3mmvs4x/payments/count.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

end
