# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class BalanceUnstableTest < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "unstable")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/shopify_payments/balance.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Balance.all(
      session: @test_session,
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/unstable/shopify_payments/balance.json")
  end

end
