# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class AssignedFulfillmentOrderUnstableTest < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/unstable/assigned_fulfillment_orders.json?assignment_status=cancellation_requested&location_ids%5B%5D=24826418")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::AssignedFulfillmentOrder.all(
      assignment_status: "cancellation_requested",
      location_ids: [24826418],
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/unstable/assigned_fulfillment_orders.json?assignment_status=cancellation_requested&location_ids%5B%5D=24826418")
  end

end
