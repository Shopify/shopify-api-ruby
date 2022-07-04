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

class DisputeEvidence202207Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/shopify_payments/disputes/598735659/dispute_evidences.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"dispute_evidence" => {"id" => 819974671, "payments_dispute_id" => 598735659, "access_activity_log" => nil, "billing_address" => {"id" => 867402159, "address1" => "123 Amoebobacterieae St", "address2" => "", "city" => "Ottawa", "province" => "Ontario", "province_code" => "ON", "country" => "Canada", "country_code" => "CA", "zip" => "K2P0V6"}, "cancellation_policy_disclosure" => nil, "cancellation_rebuttal" => nil, "customer_email_address" => "example@shopify.com", "customer_first_name" => "Kermit", "customer_last_name" => "the Frog", "product_description" => "Product name: Draft\nTitle: 151cm\nPrice: $10.00\nQuantity: 1\nProduct Description: good board", "refund_policy_disclosure" => nil, "refund_refusal_explanation" => nil, "shipping_address" => {"id" => 867402159, "address1" => "123 Amoebobacterieae St", "address2" => "", "city" => "Ottawa", "province" => "Ontario", "province_code" => "ON", "country" => "Canada", "country_code" => "CA", "zip" => "K2P0V6"}, "uncategorized_text" => "Sample uncategorized text", "created_at" => "2022-07-02T01:30:21-04:00", "updated_at" => "2022-07-02T01:31:13-04:00", "submitted_by_merchant_on" => nil, "fulfillments" => [{"shipping_carrier" => "UPS", "shipping_tracking_number" => "1234", "shipping_date" => "2017-01-01"}, {"shipping_carrier" => "FedEx", "shipping_tracking_number" => "4321", "shipping_date" => "2017-01-02"}], "dispute_evidence_files" => {"cancellation_policy_file_id" => nil, "customer_communication_file_id" => 539650252, "customer_signature_file_id" => 799719586, "refund_policy_file_id" => nil, "service_documentation_file_id" => nil, "shipping_documentation_file_id" => 799719586, "uncategorized_file_id" => 567271523}}}), headers: {})

    ShopifyAPI::DisputeEvidence.find(
      dispute_id: 598735659,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/shopify_payments/disputes/598735659/dispute_evidences.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-07/shopify_payments/disputes/598735659/dispute_evidences.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "dispute_evidence" => hash_including({"refund_refusal_explanation" => "Product must have receipt of proof of purchase"}) }
      )
      .to_return(status: 200, body: JSON.generate({"dispute_evidence" => {"id" => 819974671, "payments_dispute_id" => 598735659, "access_activity_log" => nil, "billing_address" => {"id" => 867402159, "address1" => "123 Amoebobacterieae St", "address2" => "", "city" => "Ottawa", "province" => "Ontario", "province_code" => "ON", "country" => "Canada", "country_code" => "CA", "zip" => "K2P0V6"}, "cancellation_policy_disclosure" => nil, "cancellation_rebuttal" => nil, "customer_email_address" => "example@shopify.com", "customer_first_name" => "Kermit", "customer_last_name" => "the Frog", "product_description" => "Product name: Draft\nTitle: 151cm\nPrice: $10.00\nQuantity: 1\nProduct Description: good board", "refund_policy_disclosure" => nil, "refund_refusal_explanation" => "Product must have receipt of proof of purchase", "shipping_address" => {"id" => 867402159, "address1" => "123 Amoebobacterieae St", "address2" => "", "city" => "Ottawa", "province" => "Ontario", "province_code" => "ON", "country" => "Canada", "country_code" => "CA", "zip" => "K2P0V6"}, "uncategorized_text" => "Sample uncategorized text", "created_at" => "2022-07-02T01:30:21-04:00", "updated_at" => "2022-07-02T01:31:17-04:00", "submitted_by_merchant_on" => nil, "fulfillments" => [{"shipping_carrier" => "UPS", "shipping_tracking_number" => "1234", "shipping_date" => "2017-01-01"}, {"shipping_carrier" => "FedEx", "shipping_tracking_number" => "4321", "shipping_date" => "2017-01-02"}], "dispute_evidence_files" => {"cancellation_policy_file_id" => nil, "customer_communication_file_id" => 539650252, "customer_signature_file_id" => 799719586, "refund_policy_file_id" => nil, "service_documentation_file_id" => nil, "shipping_documentation_file_id" => 799719586, "uncategorized_file_id" => 567271523}}}), headers: {})

    dispute_evidence = ShopifyAPI::DisputeEvidence.new
    dispute_evidence.dispute_id = 598735659
    dispute_evidence.refund_refusal_explanation = "Product must have receipt of proof of purchase"
    dispute_evidence.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-07/shopify_payments/disputes/598735659/dispute_evidences.json")
  end

end
