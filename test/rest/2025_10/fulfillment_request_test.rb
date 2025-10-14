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

class FulfillmentRequest202510Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2025-10")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillment_orders/1046000806/fulfillment_request.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_request" => hash_including({"message" => "Fulfill this ASAP please."}) }
      )
      .to_return(status: 200, body: JSON.generate({"original_fulfillment_order" => {"id" => 1046000806, "created_at" => "2025-10-02T11:35:26-05:00", "updated_at" => "2025-10-02T11:35:27-05:00", "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "open", "fulfill_at" => nil, "fulfill_by" => nil, "supported_actions" => ["cancel_fulfillment_order"], "destination" => {"id" => 1042572138, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1072503304, "shop_id" => 548380009, "fulfillment_order_id" => 1046000806, "quantity" => 1, "line_item_id" => 466157049, "inventory_item_id" => 39072856, "fulfillable_quantity" => 1, "variant_id" => 39072856}, {"id" => 1072503305, "shop_id" => 548380009, "fulfillment_order_id" => 1046000806, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}, {"id" => 1072503306, "shop_id" => 548380009, "fulfillment_order_id" => 1046000806, "quantity" => 1, "line_item_id" => 703073504, "inventory_item_id" => 457924702, "fulfillable_quantity" => 1, "variant_id" => 457924702}], "outgoing_requests" => [{"message" => "Fulfill this ASAP please.", "request_options" => {"notify_customer" => false}, "sent_at" => "2025-10-02T11:35:27-05:00", "kind" => "fulfillment_request"}], "international_duties" => nil, "fulfillment_holds" => [], "delivery_method" => {"id" => 989232621, "method_type" => "shipping", "min_delivery_date_time" => nil, "max_delivery_date_time" => nil, "additional_information" => {"phone" => nil, "instructions" => nil, "failed_carriers" => nil, "pickup_point_id" => nil}, "service_code" => nil, "detailed_branded_promise" => nil, "source_reference" => nil, "presented_name" => "Expedited Shipping"}}, "submitted_fulfillment_order" => {"id" => 1046000806, "created_at" => "2025-10-02T11:35:26-05:00", "updated_at" => "2025-10-02T11:35:27-05:00", "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "open", "fulfill_at" => nil, "fulfill_by" => nil, "supported_actions" => ["cancel_fulfillment_order"], "destination" => {"id" => 1042572138, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1072503304, "shop_id" => 548380009, "fulfillment_order_id" => 1046000806, "quantity" => 1, "line_item_id" => 466157049, "inventory_item_id" => 39072856, "fulfillable_quantity" => 1, "variant_id" => 39072856}, {"id" => 1072503305, "shop_id" => 548380009, "fulfillment_order_id" => 1046000806, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}, {"id" => 1072503306, "shop_id" => 548380009, "fulfillment_order_id" => 1046000806, "quantity" => 1, "line_item_id" => 703073504, "inventory_item_id" => 457924702, "fulfillable_quantity" => 1, "variant_id" => 457924702}], "outgoing_requests" => [{"message" => "Fulfill this ASAP please.", "request_options" => {"notify_customer" => false}, "sent_at" => "2025-10-02T11:35:27-05:00", "kind" => "fulfillment_request"}], "international_duties" => nil, "fulfillment_holds" => [], "delivery_method" => {"id" => 989232621, "method_type" => "shipping", "min_delivery_date_time" => nil, "max_delivery_date_time" => nil, "additional_information" => {"phone" => nil, "instructions" => nil, "failed_carriers" => nil, "pickup_point_id" => nil}, "service_code" => nil, "detailed_branded_promise" => nil, "source_reference" => nil, "presented_name" => "Expedited Shipping"}}, "unsubmitted_fulfillment_order" => nil}), headers: {})

    response = fulfillment_request = ShopifyAPI::FulfillmentRequest.new
    fulfillment_request.fulfillment_order_id = 1046000806
    fulfillment_request.message = "Fulfill this ASAP please."
    fulfillment_request.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillment_orders/1046000806/fulfillment_request.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillment_orders/1046000807/fulfillment_request.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_request" => hash_including({"message" => "Fulfill this ASAP please.", "fulfillment_order_line_items" => [{"id" => 1072503307, "quantity" => 1}, {"id" => 1072503308, "quantity" => 1}], "notify_customer" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"original_fulfillment_order" => {"id" => 1046000807, "created_at" => "2025-10-02T11:35:27-05:00", "updated_at" => "2025-10-02T11:35:27-05:00", "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "open", "fulfill_at" => nil, "fulfill_by" => nil, "supported_actions" => ["cancel_fulfillment_order"], "destination" => {"id" => 1042572139, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1072503307, "shop_id" => 548380009, "fulfillment_order_id" => 1046000807, "quantity" => 1, "line_item_id" => 466157049, "inventory_item_id" => 39072856, "fulfillable_quantity" => 1, "variant_id" => 39072856}, {"id" => 1072503308, "shop_id" => 548380009, "fulfillment_order_id" => 1046000807, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "outgoing_requests" => [{"message" => "Fulfill this ASAP please.", "request_options" => {"notify_customer" => true}, "sent_at" => "2025-10-02T11:35:27-05:00", "kind" => "fulfillment_request"}], "international_duties" => nil, "fulfillment_holds" => [], "delivery_method" => {"id" => 989232622, "method_type" => "shipping", "min_delivery_date_time" => nil, "max_delivery_date_time" => nil, "additional_information" => {"phone" => nil, "instructions" => nil, "failed_carriers" => nil, "pickup_point_id" => nil}, "service_code" => nil, "detailed_branded_promise" => nil, "source_reference" => nil, "presented_name" => "Expedited Shipping"}}, "submitted_fulfillment_order" => {"id" => 1046000807, "created_at" => "2025-10-02T11:35:27-05:00", "updated_at" => "2025-10-02T11:35:27-05:00", "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "open", "fulfill_at" => nil, "fulfill_by" => nil, "supported_actions" => ["cancel_fulfillment_order"], "destination" => {"id" => 1042572139, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1072503307, "shop_id" => 548380009, "fulfillment_order_id" => 1046000807, "quantity" => 1, "line_item_id" => 466157049, "inventory_item_id" => 39072856, "fulfillable_quantity" => 1, "variant_id" => 39072856}, {"id" => 1072503308, "shop_id" => 548380009, "fulfillment_order_id" => 1046000807, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "outgoing_requests" => [{"message" => "Fulfill this ASAP please.", "request_options" => {"notify_customer" => true}, "sent_at" => "2025-10-02T11:35:27-05:00", "kind" => "fulfillment_request"}], "international_duties" => nil, "fulfillment_holds" => [], "delivery_method" => {"id" => 989232622, "method_type" => "shipping", "min_delivery_date_time" => nil, "max_delivery_date_time" => nil, "additional_information" => {"phone" => nil, "instructions" => nil, "failed_carriers" => nil, "pickup_point_id" => nil}, "service_code" => nil, "detailed_branded_promise" => nil, "source_reference" => nil, "presented_name" => "Expedited Shipping"}}, "unsubmitted_fulfillment_order" => {"id" => 1046000808, "created_at" => "2025-10-02T11:35:27-05:00", "updated_at" => "2025-10-02T11:35:27-05:00", "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "unsubmitted", "status" => "open", "fulfill_at" => nil, "fulfill_by" => nil, "supported_actions" => ["request_fulfillment", "create_fulfillment", "hold", "merge"], "destination" => {"id" => 1042572140, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1072503309, "shop_id" => 548380009, "fulfillment_order_id" => 1046000808, "quantity" => 1, "line_item_id" => 703073504, "inventory_item_id" => 457924702, "fulfillable_quantity" => 1, "variant_id" => 457924702}], "outgoing_requests" => [], "international_duties" => nil, "fulfillment_holds" => [], "delivery_method" => {"id" => 989232623, "method_type" => "shipping", "min_delivery_date_time" => nil, "max_delivery_date_time" => nil, "additional_information" => {"phone" => nil, "instructions" => nil, "failed_carriers" => nil, "pickup_point_id" => nil}, "service_code" => nil, "detailed_branded_promise" => nil, "source_reference" => nil, "presented_name" => "Expedited Shipping"}}}), headers: {})

    response = fulfillment_request = ShopifyAPI::FulfillmentRequest.new
    fulfillment_request.fulfillment_order_id = 1046000807
    fulfillment_request.message = "Fulfill this ASAP please."
    fulfillment_request.fulfillment_order_line_items = [
      {
        "id" => 1072503307,
        "quantity" => 1
      },
      {
        "id" => 1072503308,
        "quantity" => 1
      }
    ]
    fulfillment_request.notify_customer = true
    fulfillment_request.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillment_orders/1046000807/fulfillment_request.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillment_orders/1046000809/fulfillment_request/accept.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_request" => hash_including({"message" => "We will start processing your fulfillment on the next business day."}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000809, "created_at" => "2025-10-02T11:35:28-05:00", "updated_at" => "2025-10-02T11:35:28-05:00", "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "accepted", "status" => "in_progress", "fulfill_at" => nil, "fulfill_by" => nil, "supported_actions" => ["create_fulfillment", "request_cancellation"], "destination" => {"id" => 1042572141, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1072503310, "shop_id" => 548380009, "fulfillment_order_id" => 1046000809, "quantity" => 1, "line_item_id" => 466157049, "inventory_item_id" => 39072856, "fulfillable_quantity" => 1, "variant_id" => 39072856}, {"id" => 1072503311, "shop_id" => 548380009, "fulfillment_order_id" => 1046000809, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}, {"id" => 1072503312, "shop_id" => 548380009, "fulfillment_order_id" => 1046000809, "quantity" => 1, "line_item_id" => 703073504, "inventory_item_id" => 457924702, "fulfillable_quantity" => 1, "variant_id" => 457924702}], "outgoing_requests" => [], "international_duties" => nil, "fulfillment_holds" => [], "delivery_method" => {"id" => 989232624, "method_type" => "shipping", "min_delivery_date_time" => nil, "max_delivery_date_time" => nil, "additional_information" => {"phone" => nil, "instructions" => nil, "failed_carriers" => nil, "pickup_point_id" => nil}, "service_code" => nil, "detailed_branded_promise" => nil, "source_reference" => nil, "presented_name" => "Expedited Shipping"}}}), headers: {})

    response = fulfillment_request = ShopifyAPI::FulfillmentRequest.new
    fulfillment_request.fulfillment_order_id = 1046000809
    fulfillment_request.accept(
      body: {"fulfillment_request" => {"message" => "We will start processing your fulfillment on the next business day."}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillment_orders/1046000809/fulfillment_request/accept.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillment_orders/1046000805/fulfillment_request/reject.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_request" => hash_including({"message" => "Not enough inventory on hand to complete the work.", "reason" => "inventory_out_of_stock", "line_items" => [{"fulfillment_order_line_item_id" => 1072503301, "message" => "Not enough inventory."}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000805, "created_at" => "2025-10-02T11:35:25-05:00", "updated_at" => "2025-10-02T11:35:26-05:00", "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "rejected", "status" => "open", "fulfill_at" => nil, "fulfill_by" => nil, "supported_actions" => ["request_fulfillment", "create_fulfillment", "hold", "split"], "destination" => {"id" => 1042572137, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1072503301, "shop_id" => 548380009, "fulfillment_order_id" => 1046000805, "quantity" => 1, "line_item_id" => 466157049, "inventory_item_id" => 39072856, "fulfillable_quantity" => 1, "variant_id" => 39072856}, {"id" => 1072503302, "shop_id" => 548380009, "fulfillment_order_id" => 1046000805, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}, {"id" => 1072503303, "shop_id" => 548380009, "fulfillment_order_id" => 1046000805, "quantity" => 1, "line_item_id" => 703073504, "inventory_item_id" => 457924702, "fulfillable_quantity" => 1, "variant_id" => 457924702}], "outgoing_requests" => [], "international_duties" => nil, "fulfillment_holds" => [], "delivery_method" => {"id" => 989232620, "method_type" => "shipping", "min_delivery_date_time" => nil, "max_delivery_date_time" => nil, "additional_information" => {"phone" => nil, "instructions" => nil, "failed_carriers" => nil, "pickup_point_id" => nil}, "service_code" => nil, "detailed_branded_promise" => nil, "source_reference" => nil, "presented_name" => "Expedited Shipping"}}}), headers: {})

    response = fulfillment_request = ShopifyAPI::FulfillmentRequest.new
    fulfillment_request.fulfillment_order_id = 1046000805
    fulfillment_request.reject(
      body: {"fulfillment_request" => {"message" => "Not enough inventory on hand to complete the work.", "reason" => "inventory_out_of_stock", "line_items" => [{"fulfillment_order_line_item_id" => 1072503301, "message" => "Not enough inventory."}]}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillment_orders/1046000805/fulfillment_request/reject.json")

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
