# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Dispute202110Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2021-10")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/shopify_payments/disputes.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"disputes" => [{"id" => 1052608616, "order_id" => nil, "type" => "chargeback", "amount" => "100.00", "currency" => "USD", "reason" => "fraudulent", "network_reason_code" => "4827", "status" => "won", "evidence_due_by" => "2013-07-03T19:00:00-04:00", "evidence_sent_on" => "2013-07-04T07:00:00-04:00", "finalized_on" => nil, "initiated_at" => "2013-05-03T20:00:00-04:00"}, {"id" => 815713555, "order_id" => 625362839, "type" => "chargeback", "amount" => "11.50", "currency" => "USD", "reason" => "credit_not_processed", "network_reason_code" => "4827", "status" => "needs_response", "evidence_due_by" => "2022-04-17T20:00:00-04:00", "evidence_sent_on" => nil, "finalized_on" => nil, "initiated_at" => "2013-05-03T20:00:00-04:00"}, {"id" => 782360659, "order_id" => 625362839, "type" => "chargeback", "amount" => "11.50", "currency" => "USD", "reason" => "fraudulent", "network_reason_code" => "4827", "status" => "won", "evidence_due_by" => "2013-07-03T19:00:00-04:00", "evidence_sent_on" => "2013-07-04T07:00:00-04:00", "finalized_on" => nil, "initiated_at" => "2013-05-03T20:00:00-04:00"}, {"id" => 670893524, "order_id" => 625362839, "type" => "inquiry", "amount" => "11.50", "currency" => "USD", "reason" => "fraudulent", "network_reason_code" => "4827", "status" => "needs_response", "evidence_due_by" => "2022-04-17T20:00:00-04:00", "evidence_sent_on" => nil, "finalized_on" => nil, "initiated_at" => "2013-05-03T20:00:00-04:00"}, {"id" => 598735659, "order_id" => 625362839, "type" => "chargeback", "amount" => "11.50", "currency" => "USD", "reason" => "fraudulent", "network_reason_code" => "4827", "status" => "needs_response", "evidence_due_by" => "2022-04-17T20:00:00-04:00", "evidence_sent_on" => nil, "finalized_on" => nil, "initiated_at" => "2013-05-03T20:00:00-04:00"}, {"id" => 85190714, "order_id" => 625362839, "type" => "chargeback", "amount" => "11.50", "currency" => "USD", "reason" => "fraudulent", "network_reason_code" => "4827", "status" => "under_review", "evidence_due_by" => "2022-04-17T20:00:00-04:00", "evidence_sent_on" => "2022-04-04T20:00:00-04:00", "finalized_on" => nil, "initiated_at" => "2013-05-03T20:00:00-04:00"}, {"id" => 35982383, "order_id" => 625362839, "type" => "chargeback", "amount" => "11.50", "currency" => "USD", "reason" => "subscription_canceled", "network_reason_code" => "4827", "status" => "needs_response", "evidence_due_by" => "2022-04-17T20:00:00-04:00", "evidence_sent_on" => nil, "finalized_on" => nil, "initiated_at" => "2013-05-03T20:00:00-04:00"}]}), headers: {})

    ShopifyAPI::Dispute.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/shopify_payments/disputes.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/shopify_payments/disputes.json?status=won")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"disputes" => [{"id" => 1052608616, "order_id" => nil, "type" => "chargeback", "amount" => "100.00", "currency" => "USD", "reason" => "fraudulent", "network_reason_code" => "4827", "status" => "won", "evidence_due_by" => "2013-07-03T19:00:00-04:00", "evidence_sent_on" => "2013-07-04T07:00:00-04:00", "finalized_on" => nil, "initiated_at" => "2013-05-03T20:00:00-04:00"}, {"id" => 782360659, "order_id" => 625362839, "type" => "chargeback", "amount" => "11.50", "currency" => "USD", "reason" => "fraudulent", "network_reason_code" => "4827", "status" => "won", "evidence_due_by" => "2013-07-03T19:00:00-04:00", "evidence_sent_on" => "2013-07-04T07:00:00-04:00", "finalized_on" => nil, "initiated_at" => "2013-05-03T20:00:00-04:00"}]}), headers: {})

    ShopifyAPI::Dispute.all(
      status: "won",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/shopify_payments/disputes.json?status=won")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/shopify_payments/disputes.json?initiated_at=2013-05-03")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"disputes" => []}), headers: {})

    ShopifyAPI::Dispute.all(
      initiated_at: "2013-05-03",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/shopify_payments/disputes.json?initiated_at=2013-05-03")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/shopify_payments/disputes/598735659.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"dispute" => {"id" => 598735659, "order_id" => 625362839, "type" => "chargeback", "amount" => "11.50", "currency" => "USD", "reason" => "fraudulent", "network_reason_code" => "4827", "status" => "needs_response", "evidence_due_by" => "2022-04-17T20:00:00-04:00", "evidence_sent_on" => nil, "finalized_on" => nil, "initiated_at" => "2013-05-03T20:00:00-04:00"}}), headers: {})

    ShopifyAPI::Dispute.find(
      id: 598735659,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/shopify_payments/disputes/598735659.json")
  end

end
