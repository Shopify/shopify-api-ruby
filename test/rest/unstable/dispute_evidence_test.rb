# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class DisputeEvidenceUnstableTest < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "unstable")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/unstable/shopify_payments/disputes/598735659/dispute_evidences.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::DisputeEvidence.all(
      dispute_id: 598735659,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/unstable/shopify_payments/disputes/598735659/dispute_evidences.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/unstable/shopify_payments/disputes/598735659/dispute_evidences.json?dispute_evidence%5Brefund_refusal_explanation%5D=Product+must+have+receipt+of+proof+of+purchase")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    dispute_evidence = ShopifyAPI::DisputeEvidence.new
    dispute_evidence.dispute_id = 598735659
    dispute_evidence.save(
      dispute_evidence: {"refund_refusal_explanation" => "Product must have receipt of proof of purchase"},
    )

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/unstable/shopify_payments/disputes/598735659/dispute_evidences.json?dispute_evidence%5Brefund_refusal_explanation%5D=Product+must+have+receipt+of+proof+of+purchase")
  end

end
