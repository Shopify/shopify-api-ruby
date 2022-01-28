# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class UsageCharge202110Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-10")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/recurring_application_charges/455696195/usage_charges.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "usage_charge" => hash_including({description: "Super Mega Plan 1000 emails", price: 1.0}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    usage_charge = ShopifyAPI::UsageCharge.new(session: @test_session)
    usage_charge.recurring_application_charge_id = 455696195
    usage_charge.description = "Super Mega Plan 1000 emails"
    usage_charge.price = 1.0
    usage_charge.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/recurring_application_charges/455696195/usage_charges.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/recurring_application_charges/455696195/usage_charges.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::UsageCharge.all(
      session: @test_session,
      recurring_application_charge_id: "455696195",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/recurring_application_charges/455696195/usage_charges.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/recurring_application_charges/455696195/usage_charges/1034618209.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::UsageCharge.find(
      session: @test_session,
      recurring_application_charge_id: "455696195",
      id: "1034618209",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/recurring_application_charges/455696195/usage_charges/1034618209.json")
  end

end
