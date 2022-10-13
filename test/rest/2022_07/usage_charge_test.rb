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

class UsageCharge202207Test < Test::Unit::TestCase
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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/recurring_application_charges/455696195/usage_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "usage_charge" => hash_including({"description" => "Super Mega Plan 1000 emails", "price" => 1.0}) }
      )
      .to_return(status: 200, body: JSON.generate({"usage_charge" => {"id" => 1034618208, "description" => "Super Mega Plan 1000 emails", "price" => "1.00", "created_at" => "2022-10-03T12:53:15-04:00", "billing_on" => nil, "balance_used" => 11.0, "balance_remaining" => 89.0, "risk_level" => 0}}), headers: {})

    usage_charge = ShopifyAPI::UsageCharge.new
    usage_charge.recurring_application_charge_id = 455696195
    usage_charge.description = "Super Mega Plan 1000 emails"
    usage_charge.price = 1.0
    usage_charge.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/recurring_application_charges/455696195/usage_charges.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/recurring_application_charges/455696195/usage_charges.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"usage_charges" => [{"id" => 1034618206, "description" => "Super Mega Plan Add-ons", "price" => "10.00", "created_at" => "2022-10-03T12:53:13-04:00", "billing_on" => nil, "balance_used" => 10.0, "balance_remaining" => 90.0, "risk_level" => 0}]}), headers: {})

    ShopifyAPI::UsageCharge.all(
      recurring_application_charge_id: 455696195,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/recurring_application_charges/455696195/usage_charges.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/recurring_application_charges/455696195/usage_charges/1034618210.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"usage_charge" => {"id" => 1034618210, "description" => "Super Mega Plan Add-ons", "price" => "10.00", "created_at" => "2022-10-03T12:53:16-04:00", "billing_on" => nil, "balance_used" => 10.0, "balance_remaining" => 90.0, "risk_level" => 0}}), headers: {})

    ShopifyAPI::UsageCharge.find(
      recurring_application_charge_id: 455696195,
      id: 1034618210,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/recurring_application_charges/455696195/usage_charges/1034618210.json")
  end

end
