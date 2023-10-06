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

class Payout202301Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2023-01")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/shopify_payments/payouts.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"payouts" => [{"id" => 854088011, "status" => "scheduled", "date" => "2013-11-01", "currency" => "USD", "amount" => "43.12", "summary" => {"adjustments_fee_amount" => "0.12", "adjustments_gross_amount" => "2.13", "charges_fee_amount" => "1.32", "charges_gross_amount" => "45.52", "refunds_fee_amount" => "-0.23", "refunds_gross_amount" => "-3.54", "reserved_funds_fee_amount" => "0.00", "reserved_funds_gross_amount" => "0.00", "retried_payouts_fee_amount" => "0.00", "retried_payouts_gross_amount" => "0.00"}}, {"id" => 512467833, "status" => "failed", "date" => "2013-11-01", "currency" => "USD", "amount" => "43.12", "summary" => {"adjustments_fee_amount" => "0.12", "adjustments_gross_amount" => "2.13", "charges_fee_amount" => "1.32", "charges_gross_amount" => "45.52", "refunds_fee_amount" => "-0.23", "refunds_gross_amount" => "-3.54", "reserved_funds_fee_amount" => "0.00", "reserved_funds_gross_amount" => "0.00", "retried_payouts_fee_amount" => "0.00", "retried_payouts_gross_amount" => "0.00"}}, {"id" => 39438702, "status" => "in_transit", "date" => "2013-11-01", "currency" => "USD", "amount" => "43.12", "summary" => {"adjustments_fee_amount" => "0.12", "adjustments_gross_amount" => "2.13", "charges_fee_amount" => "1.32", "charges_gross_amount" => "45.52", "refunds_fee_amount" => "-0.23", "refunds_gross_amount" => "-3.54", "reserved_funds_fee_amount" => "0.00", "reserved_funds_gross_amount" => "0.00", "retried_payouts_fee_amount" => "0.00", "retried_payouts_gross_amount" => "0.00"}}, {"id" => 710174591, "status" => "paid", "date" => "2012-12-12", "currency" => "USD", "amount" => "41.90", "summary" => {"adjustments_fee_amount" => "0.12", "adjustments_gross_amount" => "2.13", "charges_fee_amount" => "1.32", "charges_gross_amount" => "44.52", "refunds_fee_amount" => "-0.23", "refunds_gross_amount" => "-3.54", "reserved_funds_fee_amount" => "0.00", "reserved_funds_gross_amount" => "0.00", "retried_payouts_fee_amount" => "0.00", "retried_payouts_gross_amount" => "0.00"}}, {"id" => 974708905, "status" => "paid", "date" => "2012-11-13", "currency" => "CAD", "amount" => "51.69", "summary" => {"adjustments_fee_amount" => "0.12", "adjustments_gross_amount" => "2.13", "charges_fee_amount" => "6.46", "charges_gross_amount" => "58.15", "refunds_fee_amount" => "-0.23", "refunds_gross_amount" => "-3.54", "reserved_funds_fee_amount" => "0.00", "reserved_funds_gross_amount" => "0.00", "retried_payouts_fee_amount" => "0.00", "retried_payouts_gross_amount" => "0.00"}}, {"id" => 917000993, "status" => "failed", "date" => "2012-11-13", "currency" => "USD", "amount" => "41.90", "summary" => {"adjustments_fee_amount" => "0.12", "adjustments_gross_amount" => "2.13", "charges_fee_amount" => "1.32", "charges_gross_amount" => "44.52", "refunds_fee_amount" => "-0.23", "refunds_gross_amount" => "-3.54", "reserved_funds_fee_amount" => "0.00", "reserved_funds_gross_amount" => "0.00", "retried_payouts_fee_amount" => "0.00", "retried_payouts_gross_amount" => "0.00"}}, {"id" => 867808544, "status" => "paid", "date" => "2012-11-12", "currency" => "USD", "amount" => "41.90", "summary" => {"adjustments_fee_amount" => "0.12", "adjustments_gross_amount" => "2.13", "charges_fee_amount" => "1.32", "charges_gross_amount" => "44.52", "refunds_fee_amount" => "-0.23", "refunds_gross_amount" => "-3.54", "reserved_funds_fee_amount" => "0.00", "reserved_funds_gross_amount" => "0.00", "retried_payouts_fee_amount" => "0.00", "retried_payouts_gross_amount" => "0.00"}}, {"id" => 725076685, "status" => "paid", "date" => "2012-11-12", "currency" => "USD", "amount" => "41.90", "summary" => {"adjustments_fee_amount" => "0.12", "adjustments_gross_amount" => "2.13", "charges_fee_amount" => "1.32", "charges_gross_amount" => "44.52", "refunds_fee_amount" => "-0.23", "refunds_gross_amount" => "-3.54", "reserved_funds_fee_amount" => "0.00", "reserved_funds_gross_amount" => "0.00", "retried_payouts_fee_amount" => "0.00", "retried_payouts_gross_amount" => "0.00"}}, {"id" => 714327683, "status" => "failed", "date" => "2012-11-12", "currency" => "USD", "amount" => "41.90", "summary" => {"adjustments_fee_amount" => "0.12", "adjustments_gross_amount" => "2.13", "charges_fee_amount" => "1.32", "charges_gross_amount" => "44.52", "refunds_fee_amount" => "-0.23", "refunds_gross_amount" => "-3.54", "reserved_funds_fee_amount" => "0.00", "reserved_funds_gross_amount" => "0.00", "retried_payouts_fee_amount" => "0.00", "retried_payouts_gross_amount" => "0.00"}}, {"id" => 631321250, "status" => "scheduled", "date" => "2012-11-12", "currency" => "USD", "amount" => "41.90", "summary" => {"adjustments_fee_amount" => "0.12", "adjustments_gross_amount" => "2.13", "charges_fee_amount" => "1.32", "charges_gross_amount" => "44.52", "refunds_fee_amount" => "-0.23", "refunds_gross_amount" => "-3.54", "reserved_funds_fee_amount" => "0.00", "reserved_funds_gross_amount" => "0.00", "retried_payouts_fee_amount" => "0.00", "retried_payouts_gross_amount" => "0.00"}}, {"id" => 623721858, "status" => "paid", "date" => "2012-11-12", "currency" => "USD", "amount" => "41.90", "summary" => {"adjustments_fee_amount" => "0.12", "adjustments_gross_amount" => "2.13", "charges_fee_amount" => "1.32", "charges_gross_amount" => "44.52", "refunds_fee_amount" => "-0.23", "refunds_gross_amount" => "-3.54", "reserved_funds_fee_amount" => "0.00", "reserved_funds_gross_amount" => "0.00", "retried_payouts_fee_amount" => "0.00", "retried_payouts_gross_amount" => "0.00"}}]}), headers: {})

    response = ShopifyAPI::Payout.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/shopify_payments/payouts.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/shopify_payments/payouts.json?date_max=2012-11-12")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"payouts" => [{"id" => 867808544, "status" => "paid", "date" => "2012-11-12", "currency" => "USD", "amount" => "41.90", "summary" => {"adjustments_fee_amount" => "0.12", "adjustments_gross_amount" => "2.13", "charges_fee_amount" => "1.32", "charges_gross_amount" => "44.52", "refunds_fee_amount" => "-0.23", "refunds_gross_amount" => "-3.54", "reserved_funds_fee_amount" => "0.00", "reserved_funds_gross_amount" => "0.00", "retried_payouts_fee_amount" => "0.00", "retried_payouts_gross_amount" => "0.00"}}, {"id" => 725076685, "status" => "paid", "date" => "2012-11-12", "currency" => "USD", "amount" => "41.90", "summary" => {"adjustments_fee_amount" => "0.12", "adjustments_gross_amount" => "2.13", "charges_fee_amount" => "1.32", "charges_gross_amount" => "44.52", "refunds_fee_amount" => "-0.23", "refunds_gross_amount" => "-3.54", "reserved_funds_fee_amount" => "0.00", "reserved_funds_gross_amount" => "0.00", "retried_payouts_fee_amount" => "0.00", "retried_payouts_gross_amount" => "0.00"}}, {"id" => 714327683, "status" => "failed", "date" => "2012-11-12", "currency" => "USD", "amount" => "41.90", "summary" => {"adjustments_fee_amount" => "0.12", "adjustments_gross_amount" => "2.13", "charges_fee_amount" => "1.32", "charges_gross_amount" => "44.52", "refunds_fee_amount" => "-0.23", "refunds_gross_amount" => "-3.54", "reserved_funds_fee_amount" => "0.00", "reserved_funds_gross_amount" => "0.00", "retried_payouts_fee_amount" => "0.00", "retried_payouts_gross_amount" => "0.00"}}, {"id" => 631321250, "status" => "scheduled", "date" => "2012-11-12", "currency" => "USD", "amount" => "41.90", "summary" => {"adjustments_fee_amount" => "0.12", "adjustments_gross_amount" => "2.13", "charges_fee_amount" => "1.32", "charges_gross_amount" => "44.52", "refunds_fee_amount" => "-0.23", "refunds_gross_amount" => "-3.54", "reserved_funds_fee_amount" => "0.00", "reserved_funds_gross_amount" => "0.00", "retried_payouts_fee_amount" => "0.00", "retried_payouts_gross_amount" => "0.00"}}, {"id" => 623721858, "status" => "paid", "date" => "2012-11-12", "currency" => "USD", "amount" => "41.90", "summary" => {"adjustments_fee_amount" => "0.12", "adjustments_gross_amount" => "2.13", "charges_fee_amount" => "1.32", "charges_gross_amount" => "44.52", "refunds_fee_amount" => "-0.23", "refunds_gross_amount" => "-3.54", "reserved_funds_fee_amount" => "0.00", "reserved_funds_gross_amount" => "0.00", "retried_payouts_fee_amount" => "0.00", "retried_payouts_gross_amount" => "0.00"}}]}), headers: {})

    response = ShopifyAPI::Payout.all(
      date_max: "2012-11-12",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/shopify_payments/payouts.json?date_max=2012-11-12")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/shopify_payments/payouts/623721858.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"payout" => {"id" => 623721858, "status" => "paid", "date" => "2012-11-12", "currency" => "USD", "amount" => "41.90", "summary" => {"adjustments_fee_amount" => "0.12", "adjustments_gross_amount" => "2.13", "charges_fee_amount" => "1.32", "charges_gross_amount" => "44.52", "refunds_fee_amount" => "-0.23", "refunds_gross_amount" => "-3.54", "reserved_funds_fee_amount" => "0.00", "reserved_funds_gross_amount" => "0.00", "retried_payouts_fee_amount" => "0.00", "retried_payouts_gross_amount" => "0.00"}}}), headers: {})

    response = ShopifyAPI::Payout.find(
      id: 623721858,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/shopify_payments/payouts/623721858.json")

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
