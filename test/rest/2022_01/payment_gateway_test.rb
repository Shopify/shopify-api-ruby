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

class PaymentGateway202201Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/payment_gateways.json?disabled=false")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"payment_gateways" => [{"disabled" => false, "id" => 431363653, "name" => "shopify_payments", "provider_id" => 87, "sandbox" => false, "supports_network_tokenization" => nil, "type" => "DirectPaymentGateway", "enabled_card_brands" => ["visa", "master", "american_express", "discover", "diners_club"], "processing_method" => "direct", "service_name" => "Shopify Payments", "metadata" => {"google_pay_merchant_id" => 548380009}, "created_at" => "2011-12-31T19:00:00-05:00", "updated_at" => "2022-10-03T12:24:45-04:00", "credential4" => nil, "attachment" => nil}]}), headers: {})

    ShopifyAPI::PaymentGateway.all(
      disabled: "false",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/payment_gateways.json?disabled=false")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/payment_gateways.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"payment_gateways" => [{"disabled" => false, "id" => 431363653, "name" => "shopify_payments", "provider_id" => 87, "sandbox" => false, "supports_network_tokenization" => nil, "type" => "DirectPaymentGateway", "enabled_card_brands" => ["visa", "master", "american_express", "discover", "diners_club"], "processing_method" => "direct", "service_name" => "Shopify Payments", "metadata" => {"google_pay_merchant_id" => 548380009}, "created_at" => "2011-12-31T19:00:00-05:00", "updated_at" => "2022-10-03T12:24:52-04:00", "credential4" => nil, "attachment" => nil}, {"disabled" => true, "id" => 170508070, "name" => "Cash on Delivery (COD)", "provider_id" => 140, "sandbox" => false, "supports_network_tokenization" => nil, "type" => "ManualPaymentGateway", "enabled_card_brands" => [], "processing_method" => "manual", "service_name" => "Cash on Delivery (COD)", "metadata" => {}, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00"}]}), headers: {})

    ShopifyAPI::PaymentGateway.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/payment_gateways.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/payment_gateways/431363653.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"payment" => {"disabled" => false, "id" => 431363653, "name" => "shopify_payments", "provider_id" => 87, "sandbox" => false, "supports_network_tokenization" => nil, "type" => "DirectPaymentGateway", "enabled_card_brands" => ["visa", "master", "american_express", "discover", "diners_club"], "processing_method" => "direct", "service_name" => "Shopify Payments", "metadata" => {"google_pay_merchant_id" => 548380009}, "created_at" => "2011-12-31T19:00:00-05:00", "updated_at" => "2022-10-03T12:24:50-04:00", "credential4" => nil, "attachment" => nil}}), headers: {})

    ShopifyAPI::PaymentGateway.find(
      id: 431363653,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/payment_gateways/431363653.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-01/payment_gateways/170508070.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "payment_gateway" => hash_including({"sandbox" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"payment_gateway" => {"disabled" => false, "id" => 170508070, "name" => "Cash on Delivery (COD)", "provider_id" => 140, "sandbox" => true, "supports_network_tokenization" => nil, "type" => "ManualPaymentGateway", "enabled_card_brands" => [], "processing_method" => "manual", "service_name" => "Cash on Delivery (COD)", "metadata" => {}, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:24:52-04:00"}}), headers: {})

    payment_gateway = ShopifyAPI::PaymentGateway.new
    payment_gateway.id = 170508070
    payment_gateway.sandbox = true
    payment_gateway.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-01/payment_gateways/170508070.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-01/payment_gateways/170508070.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::PaymentGateway.delete(
      id: 170508070,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-01/payment_gateways/170508070.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/payment_gateways.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "payment_gateway" => hash_including({"credential1" => "someone@example.com", "provider_id" => 7}) }
      )
      .to_return(status: 200, body: JSON.generate({"payment_gateway" => {"disabled" => false, "id" => 1048196722, "name" => "authorize_net", "provider_id" => 7, "sandbox" => false, "supports_network_tokenization" => nil, "type" => "DirectPaymentGateway", "enabled_card_brands" => ["visa", "master", "american_express", "discover", "diners_club", "jcb"], "processing_method" => "direct", "service_name" => "Authorize.net", "metadata" => {}, "created_at" => "2022-10-03T12:24:47-04:00", "updated_at" => "2022-10-03T12:24:47-04:00", "credential1" => "someone@example.com", "credential3" => nil, "credential4" => nil, "attachment" => nil}}), headers: {})

    payment_gateway = ShopifyAPI::PaymentGateway.new
    payment_gateway.credential1 = "someone@example.com"
    payment_gateway.provider_id = 7
    payment_gateway.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/payment_gateways.json")
  end

end
