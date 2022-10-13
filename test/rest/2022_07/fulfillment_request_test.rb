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

class FulfillmentRequest202207Test < Test::Unit::TestCase
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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/fulfillment_orders/1046000798/fulfillment_request.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_request" => hash_including({"message" => "Fulfill this ASAP please.", "fulfillment_order_line_items" => [{"id" => 1058737501, "quantity" => 1}, {"id" => 1058737502, "quantity" => 1}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"original_fulfillment_order" => {"id" => 1046000798, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "unsubmitted", "status" => "closed", "supported_actions" => [], "destination" => {"id" => 1046000795, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1058737501, "shop_id" => 548380009, "fulfillment_order_id" => 1046000798, "quantity" => 1, "line_item_id" => 466157049, "inventory_item_id" => 39072856, "fulfillable_quantity" => 1, "variant_id" => 39072856}, {"id" => 1058737502, "shop_id" => 548380009, "fulfillment_order_id" => 1046000798, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}, {"id" => 1058737503, "shop_id" => 548380009, "fulfillment_order_id" => 1046000798, "quantity" => 1, "line_item_id" => 703073504, "inventory_item_id" => 457924702, "fulfillable_quantity" => 1, "variant_id" => 457924702}], "outgoing_requests" => [], "fulfillment_service_handle" => "shipwire-app"}, "submitted_fulfillment_order" => {"id" => 1046000799, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "open", "supported_actions" => ["cancel_fulfillment_order"], "destination" => {"id" => 1046000796, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1058737504, "shop_id" => 548380009, "fulfillment_order_id" => 1046000799, "quantity" => 1, "line_item_id" => 466157049, "inventory_item_id" => 39072856, "fulfillable_quantity" => 1, "variant_id" => 39072856}, {"id" => 1058737505, "shop_id" => 548380009, "fulfillment_order_id" => 1046000799, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "outgoing_requests" => [{"message" => "Fulfill this ASAP please.", "request_options" => {"notify_customer" => false}, "sent_at" => "2022-10-03T13:19:53-04:00", "kind" => "fulfillment_request"}], "fulfillment_service_handle" => "shipwire-app"}, "unsubmitted_fulfillment_order" => {"id" => 1046000800, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "unsubmitted", "status" => "open", "supported_actions" => ["request_fulfillment", "create_fulfillment"], "destination" => {"id" => 1046000797, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1058737506, "shop_id" => 548380009, "fulfillment_order_id" => 1046000800, "quantity" => 1, "line_item_id" => 703073504, "inventory_item_id" => 457924702, "fulfillable_quantity" => 1, "variant_id" => 457924702}], "outgoing_requests" => [], "fulfillment_service_handle" => "shipwire-app"}}), headers: {})

    fulfillment_request = ShopifyAPI::FulfillmentRequest.new
    fulfillment_request.fulfillment_order_id = 1046000798
    fulfillment_request.message = "Fulfill this ASAP please."
    fulfillment_request.fulfillment_order_line_items = [
      {
        "id" => 1058737501,
        "quantity" => 1
      },
      {
        "id" => 1058737502,
        "quantity" => 1
      }
    ]
    fulfillment_request.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/fulfillment_orders/1046000798/fulfillment_request.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/fulfillment_orders/1046000803/fulfillment_request.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_request" => hash_including({"message" => "Fulfill this ASAP please."}) }
      )
      .to_return(status: 200, body: JSON.generate({"original_fulfillment_order" => {"id" => 1046000803, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "open", "supported_actions" => ["cancel_fulfillment_order"], "destination" => {"id" => 1046000800, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1058737513, "shop_id" => 548380009, "fulfillment_order_id" => 1046000803, "quantity" => 1, "line_item_id" => 466157049, "inventory_item_id" => 39072856, "fulfillable_quantity" => 1, "variant_id" => 39072856}, {"id" => 1058737514, "shop_id" => 548380009, "fulfillment_order_id" => 1046000803, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}, {"id" => 1058737515, "shop_id" => 548380009, "fulfillment_order_id" => 1046000803, "quantity" => 1, "line_item_id" => 703073504, "inventory_item_id" => 457924702, "fulfillable_quantity" => 1, "variant_id" => 457924702}], "outgoing_requests" => [{"message" => "Fulfill this ASAP please.", "request_options" => {"notify_customer" => false}, "sent_at" => "2022-10-03T13:20:20-04:00", "kind" => "fulfillment_request"}], "fulfillment_service_handle" => "shipwire-app"}, "submitted_fulfillment_order" => {"id" => 1046000803, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "open", "supported_actions" => ["cancel_fulfillment_order"], "destination" => {"id" => 1046000800, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1058737513, "shop_id" => 548380009, "fulfillment_order_id" => 1046000803, "quantity" => 1, "line_item_id" => 466157049, "inventory_item_id" => 39072856, "fulfillable_quantity" => 1, "variant_id" => 39072856}, {"id" => 1058737514, "shop_id" => 548380009, "fulfillment_order_id" => 1046000803, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}, {"id" => 1058737515, "shop_id" => 548380009, "fulfillment_order_id" => 1046000803, "quantity" => 1, "line_item_id" => 703073504, "inventory_item_id" => 457924702, "fulfillable_quantity" => 1, "variant_id" => 457924702}], "outgoing_requests" => [{"message" => "Fulfill this ASAP please.", "request_options" => {"notify_customer" => false}, "sent_at" => "2022-10-03T13:20:20-04:00", "kind" => "fulfillment_request"}], "fulfillment_service_handle" => "shipwire-app"}, "unsubmitted_fulfillment_order" => nil}), headers: {})

    fulfillment_request = ShopifyAPI::FulfillmentRequest.new
    fulfillment_request.fulfillment_order_id = 1046000803
    fulfillment_request.message = "Fulfill this ASAP please."
    fulfillment_request.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/fulfillment_orders/1046000803/fulfillment_request.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/fulfillment_orders/1046000801/fulfillment_request/accept.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_request" => hash_including({"message" => "We will start processing your fulfillment on the next business day."}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000801, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "accepted", "status" => "in_progress", "supported_actions" => ["request_cancellation", "create_fulfillment"], "destination" => {"id" => 1046000798, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1058737507, "shop_id" => 548380009, "fulfillment_order_id" => 1046000801, "quantity" => 1, "line_item_id" => 466157049, "inventory_item_id" => 39072856, "fulfillable_quantity" => 1, "variant_id" => 39072856}, {"id" => 1058737508, "shop_id" => 548380009, "fulfillment_order_id" => 1046000801, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}, {"id" => 1058737509, "shop_id" => 548380009, "fulfillment_order_id" => 1046000801, "quantity" => 1, "line_item_id" => 703073504, "inventory_item_id" => 457924702, "fulfillable_quantity" => 1, "variant_id" => 457924702}], "outgoing_requests" => [], "fulfillment_service_handle" => "shipwire-app"}}), headers: {})

    fulfillment_request = ShopifyAPI::FulfillmentRequest.new
    fulfillment_request.fulfillment_order_id = 1046000801
    fulfillment_request.accept(
      body: {"fulfillment_request" => {"message" => "We will start processing your fulfillment on the next business day."}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/fulfillment_orders/1046000801/fulfillment_request/accept.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/fulfillment_orders/1046000802/fulfillment_request/reject.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_request" => hash_including({"message" => "Not enough inventory on hand to complete the work.", "reason" => "inventory_out_of_stock", "line_items" => [{"fulfillment_order_line_item_id" => 1058737510, "message" => "Not enough inventory."}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000802, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "rejected", "status" => "open", "supported_actions" => ["request_fulfillment", "create_fulfillment"], "destination" => {"id" => 1046000799, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1058737510, "shop_id" => 548380009, "fulfillment_order_id" => 1046000802, "quantity" => 1, "line_item_id" => 466157049, "inventory_item_id" => 39072856, "fulfillable_quantity" => 1, "variant_id" => 39072856}, {"id" => 1058737511, "shop_id" => 548380009, "fulfillment_order_id" => 1046000802, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}, {"id" => 1058737512, "shop_id" => 548380009, "fulfillment_order_id" => 1046000802, "quantity" => 1, "line_item_id" => 703073504, "inventory_item_id" => 457924702, "fulfillable_quantity" => 1, "variant_id" => 457924702}], "outgoing_requests" => [], "fulfillment_service_handle" => "shipwire-app"}}), headers: {})

    fulfillment_request = ShopifyAPI::FulfillmentRequest.new
    fulfillment_request.fulfillment_order_id = 1046000802
    fulfillment_request.reject(
      body: {"fulfillment_request" => {"message" => "Not enough inventory on hand to complete the work.", "reason" => "inventory_out_of_stock", "line_items" => [{"fulfillment_order_line_item_id" => 1058737510, "message" => "Not enough inventory."}]}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/fulfillment_orders/1046000802/fulfillment_request/reject.json")
  end

end
