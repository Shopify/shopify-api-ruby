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

class LocationsForMove202204Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-04")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/fulfillment_orders/1046000783/locations_for_move.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"locations_for_move" => [{"location" => {"id" => 1072404544, "name" => "Alpha Location"}, "message" => "Current location.", "movable" => false}, {"location" => {"id" => 1072404545, "name" => "Bravo Location"}, "message" => "No items are stocked at this location.", "movable" => false}]}), headers: {})

    ShopifyAPI::LocationsForMove.all(
      fulfillment_order_id: 1046000783,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/fulfillment_orders/1046000783/locations_for_move.json")
  end

end
