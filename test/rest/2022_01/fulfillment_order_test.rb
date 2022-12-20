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

class FulfillmentOrder202201Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-01")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/fulfillment_orders.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_orders" => [{"id" => 1046000840, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "open", "supported_actions" => ["cancel_fulfillment_order"], "destination" => {"id" => 1046000840, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737539, "shop_id" => 548380009, "fulfillment_order_id" => 1046000840, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "fulfillment_service_handle" => "mars-fulfillment", "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}]}), headers: {})

    ShopifyAPI::FulfillmentOrder.all(
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/orders/450789469/fulfillment_orders.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000843.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000843, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "open", "supported_actions" => ["cancel_fulfillment_order"], "destination" => {"id" => 1046000843, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737542, "shop_id" => 548380009, "fulfillment_order_id" => 1046000843, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "fulfillment_service_handle" => "mars-fulfillment", "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}}), headers: {})

    ShopifyAPI::FulfillmentOrder.find(
      id: 1046000843,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000843.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000836/cancel.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000836, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "closed", "supported_actions" => [], "destination" => {"id" => 1046000836, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [], "fulfillment_service_handle" => "mars-fulfillment", "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}, "replacement_fulfillment_order" => {"id" => 1046000837, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "unsubmitted", "status" => "open", "supported_actions" => ["request_fulfillment", "create_fulfillment"], "destination" => {"id" => 1046000837, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737536, "shop_id" => 548380009, "fulfillment_order_id" => 1046000837, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "fulfillment_service_handle" => "mars-fulfillment", "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}}), headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new
    fulfillment_order.id = 1046000836
    fulfillment_order.cancel

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000836/cancel.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000849/close.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_order" => hash_including({"message" => "Not enough inventory to complete this work."}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000849, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "closed", "status" => "incomplete", "supported_actions" => ["request_fulfillment", "create_fulfillment"], "destination" => {"id" => 1046000849, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737548, "shop_id" => 548380009, "fulfillment_order_id" => 1046000849, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "fulfillment_service_handle" => "mars-fulfillment", "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}}), headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new
    fulfillment_order.id = 1046000849
    fulfillment_order.close(
      body: {"fulfillment_order" => {"message" => "Not enough inventory to complete this work."}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000849/close.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000846/move.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_order" => hash_including({"new_location_id" => 655441491}) }
      )
      .to_return(status: 200, body: JSON.generate({"original_fulfillment_order" => {"id" => 1046000846, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 487838322, "request_status" => "submitted", "status" => "closed", "supported_actions" => [], "destination" => {"id" => 1046000846, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737545, "shop_id" => 548380009, "fulfillment_order_id" => 1046000846, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "fulfillment_service_handle" => "manual", "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}, "moved_fulfillment_order" => {"id" => 1046000847, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 655441491, "request_status" => "unsubmitted", "status" => "open", "supported_actions" => ["create_fulfillment", "move"], "destination" => {"id" => 1046000847, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737546, "shop_id" => 548380009, "fulfillment_order_id" => 1046000847, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "fulfillment_service_handle" => "manual", "assigned_location" => {"address1" => "50 Rideau Street", "address2" => nil, "city" => "Ottawa", "country_code" => "CA", "location_id" => 655441491, "name" => "50 Rideau Street", "phone" => nil, "province" => "Ontario", "zip" => "K1N 9J7"}, "merchant_requests" => []}, "remaining_fulfillment_order" => nil}), headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new
    fulfillment_order.id = 1046000846
    fulfillment_order.move(
      body: {"fulfillment_order" => {"new_location_id" => 655441491}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000846/move.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000845/open.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000845, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "unsubmitted", "status" => "open", "supported_actions" => ["request_fulfillment", "create_fulfillment"], "destination" => {"id" => 1046000845, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737544, "shop_id" => 548380009, "fulfillment_order_id" => 1046000845, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "fulfillment_service_handle" => "mars-fulfillment", "fulfill_at" => nil, "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}}), headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new
    fulfillment_order.id = 1046000845
    fulfillment_order.open

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000845/open.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000841/reschedule.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment_order" => hash_including({"new_fulfill_at" => "2023-11-19 08:43 UTC"}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000841, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "unsubmitted", "status" => "scheduled", "supported_actions" => ["mark_as_open"], "destination" => {"id" => 1046000841, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737540, "shop_id" => 548380009, "fulfillment_order_id" => 1046000841, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "fulfillment_service_handle" => "mars-fulfillment", "fulfill_at" => "2023-11-19T03:43:00-05:00", "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}}), headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new
    fulfillment_order.id = 1046000841
    fulfillment_order.reschedule(
      body: {"fulfillment_order" => {"new_fulfill_at" => "2023-11-19 08:43 UTC"}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000841/reschedule.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000848/hold.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({"fulfillment_hold" => {"reason" => "inventory_out_of_stock", "reason_notes" => "Not enough inventory to complete this work."}})
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000848, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "unsubmitted", "status" => "on_hold", "supported_actions" => ["release_hold"], "destination" => {"id" => 1046000848, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737547, "shop_id" => 548380009, "fulfillment_order_id" => 1046000848, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "fulfill_at" => nil, "international_duties" => {"incoterm" => "DAP"}, "fulfillment_holds" => [{"reason" => "inventory_out_of_stock", "reason_notes" => "Not enough inventory to complete this work."}], "delivery_method" => nil, "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}}), headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new
    fulfillment_order.id = 1046000848
    fulfillment_order.hold(
      body: {"fulfillment_hold" => {"reason" => "inventory_out_of_stock", "reason_notes" => "Not enough inventory to complete this work."}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000848/hold.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000839/release_hold.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment_order" => {"id" => 1046000839, "shop_id" => 548380009, "order_id" => 450789469, "assigned_location_id" => 24826418, "request_status" => "submitted", "status" => "open", "supported_actions" => ["cancel_fulfillment_order"], "destination" => {"id" => 1046000839, "address1" => "Chestnut Street 92", "address2" => "", "city" => "Louisville", "company" => nil, "country" => "United States", "email" => "bob.norman@mail.example.com", "first_name" => "Bob", "last_name" => "Norman", "phone" => "+1(502)-459-2181", "province" => "Kentucky", "zip" => "40202"}, "line_items" => [{"id" => 1058737538, "shop_id" => 548380009, "fulfillment_order_id" => 1046000839, "quantity" => 1, "line_item_id" => 518995019, "inventory_item_id" => 49148385, "fulfillable_quantity" => 1, "variant_id" => 49148385}], "fulfill_at" => nil, "international_duties" => {"incoterm" => "DAP"}, "fulfillment_holds" => [], "delivery_method" => nil, "assigned_location" => {"address1" => nil, "address2" => nil, "city" => nil, "country_code" => "DE", "location_id" => 24826418, "name" => "Apple Api Shipwire", "phone" => nil, "province" => nil, "zip" => nil}, "merchant_requests" => []}}), headers: {})

    fulfillment_order = ShopifyAPI::FulfillmentOrder.new
    fulfillment_order.id = 1046000839
    fulfillment_order.release_hold

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-01/fulfillment_orders/1046000839/release_hold.json")
  end

end
