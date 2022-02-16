# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class AssignedFulfillmentOrder202107Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-07")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/assigned_fulfillment_orders.json?assignment_status=cancellation_requested&location_ids%5B%5D=24826418")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::AssignedFulfillmentOrder.all(
      session: @test_session,
      assignment_status: "cancellation_requested",
      location_ids: [24826418],
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/assigned_fulfillment_orders.json?assignment_status=cancellation_requested&location_ids%5B%5D=24826418")
  end

end
