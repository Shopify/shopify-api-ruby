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

class CancellationRequest202307Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2023-07")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-07/fulfillment_orders/1046000832/cancellation_request.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "cancellation_request" => hash_including({"message" => "The customer changed his mind."}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000832, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "cancellation_requested", "status" => "in_progress", "supported_actions" => ["cancel_fulfillment_order", "create_fulfillment"], "destination" => {"id" => 1046000819, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1058737574, "shop_id" => 548380009, "fulfillment_order_id" => 1046000832, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "outgoing_requests" => [], "fulfillment_service_handle" => "shipwire-app"}}), headers: {})

    response = cancellation_request = ShopifyAPI::CancellationRequest.new
    cancellation_request.fulfillment_order_id = 1046000832
    cancellation_request.message = "The customer changed his mind."
    cancellation_request.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-07/fulfillment_orders/1046000832/cancellation_request.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-07/fulfillment_orders/1046000833/cancellation_request/accept.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "cancellation_request" => hash_including({"message" => "We had not started any processing yet."}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000833, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "cancellation_accepted", "status" => "cancelled", "supported_actions" => ["request_fulfillment", "create_fulfillment"], "destination" => {"id" => 1046000820, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1058737575, "shop_id" => 548380009, "fulfillment_order_id" => 1046000833, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "outgoing_requests" => [], "fulfillment_service_handle" => "shipwire-app"}}), headers: {})

    response = cancellation_request = ShopifyAPI::CancellationRequest.new
    cancellation_request.fulfillment_order_id = 1046000833
    cancellation_request.accept(
      body: {"cancellation_request" => {"message" => "We had not started any processing yet."}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-07/fulfillment_orders/1046000833/cancellation_request/accept.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-07/fulfillment_orders/1046000834/cancellation_request/reject.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "cancellation_request" => hash_including({"message" => "We have already send the shipment out."}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000834, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "cancellation_rejected", "status" => "in_progress", "supported_actions" => [], "destination" => {"id" => 1046000821, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1058737576, "shop_id" => 548380009, "fulfillment_order_id" => 1046000834, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "outgoing_requests" => [], "fulfillment_service_handle" => "shipwire-app"}}), headers: {})

    response = cancellation_request = ShopifyAPI::CancellationRequest.new
    cancellation_request.fulfillment_order_id = 1046000834
    cancellation_request.reject(
      body: {"cancellation_request" => {"message" => "We have already send the shipment out."}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-07/fulfillment_orders/1046000834/cancellation_request/reject.json")

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
