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

class PaymentGateway202410Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2024-10")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2024-10/payment_gateways.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"payment_gateways" => [{"disabled" => true, "id" => 170508070, "name" => "Cash on Delivery (COD)", "provider_id" => 140, "sandbox" => false, "supports_network_tokenization" => nil, "type" => "ManualPaymentGateway", "enabled_card_brands" => [], "processing_method" => "manual", "service_name" => "Cash on Delivery (COD)", "metadata" => {}, "created_at" => "2024-10-02T08:59:11-05:00", "updated_at" => "2024-10-02T08:59:11-05:00"}, {"disabled" => false, "id" => 431363653, "name" => "shopify_payments", "provider_id" => 87, "sandbox" => false, "supports_network_tokenization" => nil, "type" => "DirectPaymentGateway", "enabled_card_brands" => ["visa", "master", "american_express", "discover", "diners_club"], "processing_method" => "direct", "service_name" => "Shopify Payments", "metadata" => {"google_pay_merchant_id" => 548380009}, "created_at" => "2011-12-31T19:00:00-05:00", "updated_at" => "2024-10-02T09:02:13-05:00", "credential4" => nil, "attachment" => nil}]}), headers: {})

    response = ShopifyAPI::PaymentGateway.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2024-10/payment_gateways.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2024-10/payment_gateways.json?disabled=false")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"payment_gateways" => [{"disabled" => false, "id" => 431363653, "name" => "shopify_payments", "provider_id" => 87, "sandbox" => false, "supports_network_tokenization" => nil, "type" => "DirectPaymentGateway", "enabled_card_brands" => ["visa", "master", "american_express", "discover", "diners_club"], "processing_method" => "direct", "service_name" => "Shopify Payments", "metadata" => {"google_pay_merchant_id" => 548380009}, "created_at" => "2011-12-31T19:00:00-05:00", "updated_at" => "2024-10-02T09:02:10-05:00", "credential4" => nil, "attachment" => nil}]}), headers: {})

    response = ShopifyAPI::PaymentGateway.all(
      disabled: "false",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2024-10/payment_gateways.json?disabled=false")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2024-10/payment_gateways.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "payment_gateway" => hash_including({"credential1" => "someone@example.com", "provider_id" => 7}) }
      )
      .to_return(status: 200, body: JSON.generate({"payment_gateway" => {"disabled" => false, "id" => 1070028413, "name" => "authorize_net", "provider_id" => 7, "sandbox" => false, "supports_network_tokenization" => nil, "type" => "DirectPaymentGateway", "enabled_card_brands" => ["visa", "master", "american_express", "discover", "diners_club", "jcb"], "processing_method" => "direct", "service_name" => "Authorize.net", "metadata" => {}, "created_at" => "2024-10-02T09:02:15-05:00", "updated_at" => "2024-10-02T09:02:15-05:00", "credential1" => "someone@example.com", "credential3" => nil, "credential4" => nil, "attachment" => nil}}), headers: {})

    response = payment_gateway = ShopifyAPI::PaymentGateway.new
    payment_gateway.credential1 = "someone@example.com"
    payment_gateway.provider_id = 7
    payment_gateway.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2024-10/payment_gateways.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2024-10/payment_gateways/431363653.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"payment" => {"disabled" => false, "id" => 431363653, "name" => "shopify_payments", "provider_id" => 87, "sandbox" => false, "supports_network_tokenization" => nil, "type" => "DirectPaymentGateway", "enabled_card_brands" => ["visa", "master", "american_express", "discover", "diners_club"], "processing_method" => "direct", "service_name" => "Shopify Payments", "metadata" => {"google_pay_merchant_id" => 548380009}, "created_at" => "2011-12-31T19:00:00-05:00", "updated_at" => "2024-10-02T09:02:14-05:00", "credential4" => nil, "attachment" => nil}}), headers: {})

    response = ShopifyAPI::PaymentGateway.find(
      id: 431363653,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2024-10/payment_gateways/431363653.json")

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
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2024-10/payment_gateways/170508070.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "payment_gateway" => hash_including({"sandbox" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"payment_gateway" => {"disabled" => false, "id" => 170508070, "name" => "Cash on Delivery (COD)", "provider_id" => 140, "sandbox" => true, "supports_network_tokenization" => nil, "type" => "ManualPaymentGateway", "enabled_card_brands" => [], "processing_method" => "manual", "service_name" => "Cash on Delivery (COD)", "metadata" => {}, "created_at" => "2024-10-02T08:59:11-05:00", "updated_at" => "2024-10-02T09:02:13-05:00"}}), headers: {})

    response = payment_gateway = ShopifyAPI::PaymentGateway.new
    payment_gateway.id = 170508070
    payment_gateway.sandbox = true
    payment_gateway.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2024-10/payment_gateways/170508070.json")

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
  def test_6()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2024-10/payment_gateways/170508070.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    response = ShopifyAPI::PaymentGateway.delete(
      id: 170508070,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2024-10/payment_gateways/170508070.json")

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
