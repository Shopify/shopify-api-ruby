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

class FulfillmentOrder202404Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2024-07")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2024-07/orders/450789469/fulfillment_orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_orders" => [{"id" => 1046000823, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "open", "supported_actions" => ["cancel_fulfillment_order"], "destination" => {"id" => 1046000807, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737564, "shop_id" => 548380009, "fulfillment_order_id" => 1046000823, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "international_duties" => nil, "fulfill_at" => nil, "fulfill_by" => nil, "fulfillment_holds" => [], "created_at" => "2024-07-02T09:11:25-05:00", "updated_at" => "2024-07-02T09:11:25-05:00", "delivery_method" => nil, "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}]}), headers: {})

    response = ShopifyAPI::FulfillmentOrder.all(
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2024-07/orders/450789469/fulfillment_orders.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2024-07/orders/450789469/fulfillment_orders.json?include_financial_summaries=true")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_orders" => [{"id" => 1046000836, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "open", "supported_actions" => ["cancel_fulfillment_order"], "destination" => {"id" => 1046000820, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737576, "shop_id" => 548380009, "fulfillment_order_id" => 1046000836, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385, "financial_summaries" => [{"quantity" => 1, "original_unit_price_set" => "199.00", "approximate_discounted_unit_price_set" => "199.00", "discount_allocations" => [{"amount" => "3.33", "discount_application" => {"allocation_method" => "across", "target_selection" => "all", "target_type" => "line_item"}}]}]}], "international_duties" => nil, "fulfill_at" => nil, "fulfill_by" => nil, "fulfillment_holds" => [], "created_at" => "2024-07-02T09:11:42-05:00", "updated_at" => "2024-07-02T09:11:42-05:00", "delivery_method" => nil, "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}]}), headers: {})

    response = ShopifyAPI::FulfillmentOrder.all(
      order_id: 450789469,
      include_financial_summaries: "true",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2024-07/orders/450789469/fulfillment_orders.json?include_financial_summaries=true")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2024-07/orders/450789469/fulfillment_orders.json?include_order_reference_fields=true")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_orders" => [{"id" => 1046000826, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "open", "supported_actions" => ["cancel_fulfillment_order"], "destination" => {"id" => 1046000810, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737566, "shop_id" => 548380009, "fulfillment_order_id" => 1046000826, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "international_duties" => nil, "fulfill_at" => nil, "fulfill_by" => nil, "fulfillment_holds" => [], "created_at" => "2024-07-02T09:11:28-05:00", "updated_at" => "2024-07-02T09:11:28-05:00", "order_name" => "#1001", "order_processed_at" => "2008-01-10T11:00:00-05:00", "channel_id" => nil, "delivery_method" => nil, "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}]}), headers: {})

    response = ShopifyAPI::FulfillmentOrder.all(
      order_id: 450789469,
      include_order_reference_fields: "true",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2024-07/orders/450789469/fulfillment_orders.json?include_order_reference_fields=true")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/1046000819.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000819, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "open", "supported_actions" => ["cancel_fulfillment_order"], "destination" => {"id" => 1046000803, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737560, "shop_id" => 548380009, "fulfillment_order_id" => 1046000819, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "international_duties" => nil, "fulfill_at" => nil, "fulfill_by" => nil, "fulfillment_holds" => [], "created_at" => "2024-07-02T09:11:20-05:00", "updated_at" => "2024-07-02T09:11:20-05:00", "delivery_method" => nil, "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}}), headers: {})

    response = ShopifyAPI::FulfillmentOrder.find(
      id: 1046000819,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/1046000819.json")

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
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/1046000837.json?include_financial_summaries=true")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000837, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "open", "supported_actions" => ["cancel_fulfillment_order"], "destination" => {"id" => 1046000821, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737577, "shop_id" => 548380009, "fulfillment_order_id" => 1046000837, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385, "financial_summaries" => [{"quantity" => 1, "original_unit_price_set" => "199.00", "approximate_discounted_unit_price_set" => "199.00", "discount_allocations" => [{"amount" => "3.33", "discount_application" => {"allocation_method" => "across", "target_selection" => "all", "target_type" => "line_item"}}]}]}], "international_duties" => nil, "fulfill_at" => nil, "fulfill_by" => nil, "fulfillment_holds" => [], "created_at" => "2024-07-02T09:11:43-05:00", "updated_at" => "2024-07-02T09:11:43-05:00", "delivery_method" => nil, "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}}), headers: {})

    response = ShopifyAPI::FulfillmentOrder.find(
      id: 1046000837,
      include_financial_summaries: "true",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/1046000837.json?include_financial_summaries=true")

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
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/1046000828.json?include_order_reference_fields=true")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000828, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "open", "supported_actions" => ["cancel_fulfillment_order"], "destination" => {"id" => 1046000812, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737568, "shop_id" => 548380009, "fulfillment_order_id" => 1046000828, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "international_duties" => nil, "fulfill_at" => nil, "fulfill_by" => nil, "fulfillment_holds" => [], "created_at" => "2024-07-02T09:11:32-05:00", "updated_at" => "2024-07-02T09:11:32-05:00", "order_name" => "#1001", "order_processed_at" => "2008-01-10T11:00:00-05:00", "channel_id" => nil, "delivery_method" => nil, "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}}), headers: {})

    response = ShopifyAPI::FulfillmentOrder.find(
      id: 1046000828,
      include_order_reference_fields: "true",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/1046000828.json?include_order_reference_fields=true")

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
  def test_7()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/1046000824/cancel.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000824, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "closed", "supported_actions" => [], "destination" => {"id" => 1046000808, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [], "international_duties" => nil, "fulfillment_service_handle" => "mars-fulfillment", "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}, "replacement_fulfillment_order" => {"id" => 1046000825, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "unsubmitted", "status" => "open", "supported_actions" => ["request_fulfillment"], "destination" => {"id" => 1046000809, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737565, "shop_id" => 548380009, "fulfillment_order_id" => 1046000825, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "international_duties" => nil, "fulfillment_service_handle" => "mars-fulfillment", "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}}), headers: {})

    response = fulfillment_order = ShopifyAPI::FulfillmentOrder.new
    fulfillment_order.id = 1046000824
    fulfillment_order.cancel

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/1046000824/cancel.json")

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
  def test_8()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/1046000818/close.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_order" => hash_including({"message" => "Not enough inventory to complete this work."}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000818, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "closed", "status" => "incomplete", "supported_actions" => ["request_fulfillment"], "destination" => {"id" => 1046000802, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737559, "shop_id" => 548380009, "fulfillment_order_id" => 1046000818, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "international_duties" => nil, "fulfillment_service_handle" => "mars-fulfillment", "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}}), headers: {})

    response = fulfillment_order = ShopifyAPI::FulfillmentOrder.new
    fulfillment_order.id = 1046000818
    fulfillment_order.close(
      body: {"fulfillment_order" => {"message" => "Not enough inventory to complete this work."}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/1046000818/close.json")

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
  def test_9()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/1046000834/move.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_order" => hash_including({"new_location_id" => 655441491, "fulfillment_order_line_items" => [{"id" => 1058737574, "quantity" => 1}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"original_fulfillment_order" => {"id" => 1046000834, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 487838322, "request_status" => "submitted", "status" => "closed", "supported_actions" => [], "destination" => {"id" => 1046000818, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [], "international_duties" => nil, "fulfillment_service_handle" => "manual", "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}, "moved_fulfillment_order" => {"id" => 1046000835, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 655441491, "request_status" => "unsubmitted", "status" => "open", "supported_actions" => ["create_fulfillment", "move"], "destination" => {"id" => 1046000819, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737575, "shop_id" => 548380009, "fulfillment_order_id" => 1046000835, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "international_duties" => nil, "fulfillment_service_handle" => "manual", "assigned_location" => {"address1" => "50 Rideau Street", "address2" => nil, "city" => "Ottawa", "country_code" => "CA", "location_id" => 655441491, "name" => "50 Rideau Street", "phone" => nil, "province" => "Ontario", "zip" => "K1N 9J7"}, "merchant_requests" => []}, "remaining_fulfillment_order" => nil}), headers: {})

    response = fulfillment_order = ShopifyAPI::FulfillmentOrder.new
    fulfillment_order.id = 1046000834
    fulfillment_order.move(
      body: {"fulfillment_order" => {"new_location_id" => 655441491, "fulfillment_order_line_items" => [{"id" => 1058737574, "quantity" => 1}]}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/1046000834/move.json")

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
  def test_10()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/1046000821/open.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000821, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "unsubmitted", "status" => "open", "supported_actions" => ["request_fulfillment"], "destination" => {"id" => 1046000805, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737562, "shop_id" => 548380009, "fulfillment_order_id" => 1046000821, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "international_duties" => nil, "fulfillment_service_handle" => "mars-fulfillment", "fulfill_at" => nil, "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}}), headers: {})

    response = fulfillment_order = ShopifyAPI::FulfillmentOrder.new
    fulfillment_order.id = 1046000821
    fulfillment_order.open

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/1046000821/open.json")

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
  def test_11()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/1046000830/reschedule.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_order" => hash_including({"new_fulfill_at" => "2025-02-02 14:11 UTC"}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000830, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "unsubmitted", "status" => "scheduled", "supported_actions" => ["mark_as_open"], "destination" => {"id" => 1046000814, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737570, "shop_id" => 548380009, "fulfillment_order_id" => 1046000830, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "international_duties" => nil, "fulfillment_service_handle" => "mars-fulfillment", "fulfill_at" => "2025-02-02T09:11:00-05:00", "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}}), headers: {})

    response = fulfillment_order = ShopifyAPI::FulfillmentOrder.new
    fulfillment_order.id = 1046000830
    fulfillment_order.reschedule(
      body: {"fulfillment_order" => {"new_fulfill_at" => "2025-02-02 14:11 UTC"}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/1046000830/reschedule.json")

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
  def test_12()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/1046000827/hold.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({"fulfillment_hold" => {"reason" => "inventory_out_of_stock", "reason_notes" => "Not enough inventory to complete this work.", "fulfillment_order_line_items" => [{"id" => 1058737567, "quantity" => 1}]}})
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000827, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "unsubmitted", "status" => "on_hold", "supported_actions" => ["release_hold"], "destination" => {"id" => 1046000811, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737567, "shop_id" => 548380009, "fulfillment_order_id" => 1046000827, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "international_duties" => nil, "fulfill_at" => nil, "fulfillment_holds" => [{"reason" => "inventory_out_of_stock", "reason_notes" => "Not enough inventory to complete this work."}], "delivery_method" => nil, "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}}), headers: {})

    response = fulfillment_order = ShopifyAPI::FulfillmentOrder.new
    fulfillment_order.id = 1046000827
    fulfillment_order.hold(
      body: {"fulfillment_hold" => {"reason" => "inventory_out_of_stock", "reason_notes" => "Not enough inventory to complete this work.", "fulfillment_order_line_items" => [{"id" => 1058737567, "quantity" => 1}]}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/1046000827/hold.json")

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
  def test_13()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/set_fulfillment_orders_deadline.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({"fulfillment_order_ids" => [1046000820], "fulfillment_deadline" => "2021-05-26T10:00:00-04:00"})
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    response = fulfillment_order = ShopifyAPI::FulfillmentOrder.new

    fulfillment_order.set_fulfillment_orders_deadline(
      body: {"fulfillment_order_ids" => [1046000820], "fulfillment_deadline" => "2021-05-26T10:00:00-04:00"},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/set_fulfillment_orders_deadline.json")

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
  def test_14()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/1046000829/release_hold.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000829, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "open", "supported_actions" => ["cancel_fulfillment_order"], "destination" => {"id" => 1046000813, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "origin" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "line_items" => [{"id" => 1058737569, "shop_id" => 548380009, "fulfillment_order_id" => 1046000829, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "outgoing_requests" => [], "international_duties" => nil, "fulfill_at" => nil, "fulfillment_holds" => [], "delivery_method" => nil}}), headers: {})

    response = fulfillment_order = ShopifyAPI::FulfillmentOrder.new
    fulfillment_order.id = 1046000829
    fulfillment_order.release_hold

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2024-07/fulfillment_orders/1046000829/release_hold.json")

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
