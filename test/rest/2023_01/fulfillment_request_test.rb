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

class FulfillmentRequest202301Test < Test::Unit::TestCase
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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-01/fulfillment_orders/1046000782/fulfillment_request.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_request" => hash_including({"message" => "Fulfill this ASAP please."}) }
      )
      .to_return(status: 200, body: JSON.generate({"original_fulfillment_order" => {"id" => 1046000782, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "open", "supported_actions" => ["cancel_fulfillment_order"], "destination" => {"id" => 1046000782, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1058737493, "shop_id" => 548380009, "fulfillment_order_id" => 1046000782, "quantity" => 1, "line_item_id" => 466157049, "inventory_item_id" => 39072856, "fulfillable_quantity" => 1, "variant_id" => 39072856}, {"id" => 1058737494, "shop_id" => 548380009, "fulfillment_order_id" => 1046000782, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}, {"id" => 1058737495, "shop_id" => 548380009, "fulfillment_order_id" => 1046000782, "quantity" => 1, "line_item_id" => 703073504, "inventory_item_id" => 457924702, "fulfillable_quantity" => 1, "variant_id" => 457924702}], "outgoing_requests" => [{"message" => "Fulfill this ASAP please.", "request_options" => {"notify_customer" => false}, "sent_at" => "2023-07-05T18:48:36-04:00", "kind" => "fulfillment_request"}], "fulfillment_service_handle" => "shipwire-app"}, "submitted_fulfillment_order" => {"id" => 1046000782, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "open", "supported_actions" => ["cancel_fulfillment_order"], "destination" => {"id" => 1046000782, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1058737493, "shop_id" => 548380009, "fulfillment_order_id" => 1046000782, "quantity" => 1, "line_item_id" => 466157049, "inventory_item_id" => 39072856, "fulfillable_quantity" => 1, "variant_id" => 39072856}, {"id" => 1058737494, "shop_id" => 548380009, "fulfillment_order_id" => 1046000782, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}, {"id" => 1058737495, "shop_id" => 548380009, "fulfillment_order_id" => 1046000782, "quantity" => 1, "line_item_id" => 703073504, "inventory_item_id" => 457924702, "fulfillable_quantity" => 1, "variant_id" => 457924702}], "outgoing_requests" => [{"message" => "Fulfill this ASAP please.", "request_options" => {"notify_customer" => false}, "sent_at" => "2023-07-05T18:48:36-04:00", "kind" => "fulfillment_request"}], "fulfillment_service_handle" => "shipwire-app"}, "unsubmitted_fulfillment_order" => nil}), headers: {})

    response = fulfillment_request = ShopifyAPI::FulfillmentRequest.new
    fulfillment_request.fulfillment_order_id = 1046000782
    fulfillment_request.message = "Fulfill this ASAP please."
    fulfillment_request.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-01/fulfillment_orders/1046000782/fulfillment_request.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-01/fulfillment_orders/1046000777/fulfillment_request.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_request" => hash_including({"message" => "Fulfill this ASAP please.", "fulfillment_order_line_items" => [{"id" => 1058737481, "quantity" => 1}, {"id" => 1058737482, "quantity" => 1}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"original_fulfillment_order" => {"id" => 1046000777, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "unsubmitted", "status" => "closed", "supported_actions" => [], "destination" => {"id" => 1046000777, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1058737481, "shop_id" => 548380009, "fulfillment_order_id" => 1046000777, "quantity" => 1, "line_item_id" => 466157049, "inventory_item_id" => 39072856, "fulfillable_quantity" => 1, "variant_id" => 39072856}, {"id" => 1058737482, "shop_id" => 548380009, "fulfillment_order_id" => 1046000777, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}, {"id" => 1058737483, "shop_id" => 548380009, "fulfillment_order_id" => 1046000777, "quantity" => 1, "line_item_id" => 703073504, "inventory_item_id" => 457924702, "fulfillable_quantity" => 1, "variant_id" => 457924702}], "outgoing_requests" => [], "fulfillment_service_handle" => "shipwire-app"}, "submitted_fulfillment_order" => {"id" => 1046000778, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "open", "supported_actions" => ["cancel_fulfillment_order"], "destination" => {"id" => 1046000778, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1058737484, "shop_id" => 548380009, "fulfillment_order_id" => 1046000778, "quantity" => 1, "line_item_id" => 466157049, "inventory_item_id" => 39072856, "fulfillable_quantity" => 1, "variant_id" => 39072856}, {"id" => 1058737485, "shop_id" => 548380009, "fulfillment_order_id" => 1046000778, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "outgoing_requests" => [{"message" => "Fulfill this ASAP please.", "request_options" => {"notify_customer" => false}, "sent_at" => "2023-07-05T18:48:31-04:00", "kind" => "fulfillment_request"}], "fulfillment_service_handle" => "shipwire-app"}, "unsubmitted_fulfillment_order" => {"id" => 1046000779, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "unsubmitted", "status" => "open", "supported_actions" => ["request_fulfillment", "create_fulfillment"], "destination" => {"id" => 1046000779, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1058737486, "shop_id" => 548380009, "fulfillment_order_id" => 1046000779, "quantity" => 1, "line_item_id" => 703073504, "inventory_item_id" => 457924702, "fulfillable_quantity" => 1, "variant_id" => 457924702}], "outgoing_requests" => [], "fulfillment_service_handle" => "shipwire-app"}}), headers: {})

    response = fulfillment_request = ShopifyAPI::FulfillmentRequest.new
    fulfillment_request.fulfillment_order_id = 1046000777
    fulfillment_request.message = "Fulfill this ASAP please."
    fulfillment_request.fulfillment_order_line_items = [
      {
        "id" => 1058737481,
        "quantity" => 1
      },
      {
        "id" => 1058737482,
        "quantity" => 1
      }
    ]
    fulfillment_request.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-01/fulfillment_orders/1046000777/fulfillment_request.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-01/fulfillment_orders/1046000780/fulfillment_request/accept.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_request" => hash_including({"message" => "We will start processing your fulfillment on the next business day."}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000780, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "accepted", "status" => "in_progress", "supported_actions" => ["request_cancellation", "create_fulfillment"], "destination" => {"id" => 1046000780, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1058737487, "shop_id" => 548380009, "fulfillment_order_id" => 1046000780, "quantity" => 1, "line_item_id" => 466157049, "inventory_item_id" => 39072856, "fulfillable_quantity" => 1, "variant_id" => 39072856}, {"id" => 1058737488, "shop_id" => 548380009, "fulfillment_order_id" => 1046000780, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}, {"id" => 1058737489, "shop_id" => 548380009, "fulfillment_order_id" => 1046000780, "quantity" => 1, "line_item_id" => 703073504, "inventory_item_id" => 457924702, "fulfillable_quantity" => 1, "variant_id" => 457924702}], "outgoing_requests" => [], "fulfillment_service_handle" => "shipwire-app"}}), headers: {})

    response = fulfillment_request = ShopifyAPI::FulfillmentRequest.new
    fulfillment_request.fulfillment_order_id = 1046000780
    fulfillment_request.accept(
      body: {"fulfillment_request" => {"message" => "We will start processing your fulfillment on the next business day."}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-01/fulfillment_orders/1046000780/fulfillment_request/accept.json")

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
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-01/fulfillment_orders/1046000781/fulfillment_request/reject.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_request" => hash_including({"message" => "Not enough inventory on hand to complete the work.", "reason" => "inventory_out_of_stock", "line_items" => [{"fulfillment_order_line_item_id" => 1058737490, "message" => "Not enough inventory."}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000781, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "rejected", "status" => "open", "supported_actions" => ["request_fulfillment", "create_fulfillment"], "destination" => {"id" => 1046000781, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1058737490, "shop_id" => 548380009, "fulfillment_order_id" => 1046000781, "quantity" => 1, "line_item_id" => 466157049, "inventory_item_id" => 39072856, "fulfillable_quantity" => 1, "variant_id" => 39072856}, {"id" => 1058737491, "shop_id" => 548380009, "fulfillment_order_id" => 1046000781, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}, {"id" => 1058737492, "shop_id" => 548380009, "fulfillment_order_id" => 1046000781, "quantity" => 1, "line_item_id" => 703073504, "inventory_item_id" => 457924702, "fulfillable_quantity" => 1, "variant_id" => 457924702}], "outgoing_requests" => [], "fulfillment_service_handle" => "shipwire-app"}}), headers: {})

    response = fulfillment_request = ShopifyAPI::FulfillmentRequest.new
    fulfillment_request.fulfillment_order_id = 1046000781
    fulfillment_request.reject(
      body: {"fulfillment_request" => {"message" => "Not enough inventory on hand to complete the work.", "reason" => "inventory_out_of_stock", "line_items" => [{"fulfillment_order_line_item_id" => 1058737490, "message" => "Not enough inventory."}]}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-01/fulfillment_orders/1046000781/fulfillment_request/reject.json")

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
