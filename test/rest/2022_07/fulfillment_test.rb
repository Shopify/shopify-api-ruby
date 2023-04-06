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

class Fulfillment202207Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/orders/450789469/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillments" => [{"id" => 255858046, "order_id" => 450789469, "status" => "failure", "created_at" => "2023-03-13T05:43:46-04:00", "service" => "manual", "updated_at" => "2023-03-13T05:43:46-04:00", "tracking_company" => "USPS", "shipment_status" => nil, "location_id" => 655441491, "line_items" => [{"id" => 466157049, "variant_id" => 39072856, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008GREEN", "variant_title" => "green", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - green", "variant_inventory_management" => "shopify", "properties" => [{"name" => "Custom Engraving Front", "value" => "Happy Birthday"}, {"name" => "Custom Engraving Back", "value" => "Merry Christmas"}], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => nil, "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.34", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.34", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.34", "currency_code" => "USD"}}}], "admin_graphql_api_id" => "gid://shopify/LineItem/466157049", "duties" => [], "tax_lines" => [{"price" => "3.98", "rate" => 0.06, "title" => "State Tax", "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => "1Z2345", "tracking_numbers" => ["1Z2345"], "tracking_url" => "https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z2345", "tracking_urls" => ["https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z2345"], "receipt" => {"testcase" => true, "authorization" => "123456"}, "name" => "#1001.0", "admin_graphql_api_id" => "gid://shopify/Fulfillment/255858046"}]}), headers: {})

    ShopifyAPI::Fulfillment.all(
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/orders/450789469/fulfillments.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/orders/450789469/fulfillments.json?since_id=255858046")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillments" => [{"id" => 1069019862, "order_id" => 450789469, "status" => "success", "created_at" => "2023-03-13T05:44:30-04:00", "service" => "shipwire-app", "updated_at" => "2023-03-13T05:44:30-04:00", "tracking_company" => "TNT", "shipment_status" => nil, "location_id" => 24826418, "line_items" => [{"id" => 518995019, "variant_id" => 49148385, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008RED", "variant_title" => "red", "vendor" => nil, "fulfillment_service" => "shipwire-app", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - red", "variant_inventory_management" => "shipwire-app", "properties" => [], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => nil, "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.33", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}}], "admin_graphql_api_id" => "gid://shopify/LineItem/518995019", "duties" => [], "tax_lines" => [{"price" => "3.98", "rate" => 0.06, "title" => "State Tax", "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => "123456789", "tracking_numbers" => ["123456789"], "tracking_url" => "https://www.tnt.com/express/en_us/site/tracking.html?searchType=con&cons=123456789", "tracking_urls" => ["https://www.tnt.com/express/en_us/site/tracking.html?searchType=con&cons=123456789"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069019862"}]}), headers: {})

    ShopifyAPI::Fulfillment.all(
      order_id: 450789469,
      since_id: "255858046",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/orders/450789469/fulfillments.json?since_id=255858046")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/fulfillment_orders/1046000793/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillments" => [{"id" => 1069019874, "order_id" => 450789469, "status" => "success", "created_at" => "2023-03-13T05:43:46-04:00", "service" => "manual", "updated_at" => "2023-03-13T05:43:46-04:00", "tracking_company" => "UPS", "shipment_status" => nil, "location_id" => 24826418, "line_items" => [{"id" => 1071823180, "variant_id" => 43729076, "title" => "Draft", "quantity" => 1, "sku" => "draft-151", "variant_title" => "151cm", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 108828309, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Draft - 151cm", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823180", "tax_lines" => []}], "tracking_number" => "#\u26201\u2622\n---\n4321\n", "tracking_numbers" => ["#\u26201\u2622\n---\n4321\n"], "tracking_url" => "https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=#\u26201\u2622---4321", "tracking_urls" => ["https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=#\u26201\u2622---4321"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069019874"}]}), headers: {})

    ShopifyAPI::Fulfillment.all(
      fulfillment_order_id: 1046000793,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/fulfillment_orders/1046000793/fulfillments.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/orders/450789469/fulfillments/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    ShopifyAPI::Fulfillment.count(
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/orders/450789469/fulfillments/count.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/orders/450789469/fulfillments/255858046.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 255858046, "order_id" => 450789469, "status" => "failure", "created_at" => "2023-03-13T05:43:46-04:00", "service" => "manual", "updated_at" => "2023-03-13T05:43:46-04:00", "tracking_company" => "USPS", "shipment_status" => nil, "location_id" => 655441491, "origin_address" => nil, "line_items" => [{"id" => 466157049, "variant_id" => 39072856, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008GREEN", "variant_title" => "green", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - green", "variant_inventory_management" => "shopify", "properties" => [{"name" => "Custom Engraving Front", "value" => "Happy Birthday"}, {"name" => "Custom Engraving Back", "value" => "Merry Christmas"}], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => nil, "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.34", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.34", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.34", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/466157049", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => "1Z2345", "tracking_numbers" => ["1Z2345"], "tracking_url" => "https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z2345", "tracking_urls" => ["https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z2345"], "receipt" => {"testcase" => true, "authorization" => "123456"}, "name" => "#1001.0", "admin_graphql_api_id" => "gid://shopify/Fulfillment/255858046"}}), headers: {})

    ShopifyAPI::Fulfillment.find(
      order_id: 450789469,
      id: 255858046,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/orders/450789469/fulfillments/255858046.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"message" => "The package was shipped this morning.", "notify_customer" => false, "tracking_info" => {"number" => 1562678, "url" => "https://www.my-shipping-company.com", "company" => "my-shipping-company"}, "line_items_by_fulfillment_order" => [{"fulfillment_order_id" => 1046000784, "fulfillment_order_line_items" => [{"id" => 1058737493, "quantity" => 1}]}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069019868, "order_id" => 450789469, "status" => "success", "created_at" => "2023-03-13T05:45:17-04:00", "service" => "manual", "updated_at" => "2023-03-13T05:45:17-04:00", "tracking_company" => "my-shipping-company", "shipment_status" => nil, "location_id" => 24826418, "line_items" => [{"id" => 1071823177, "variant_id" => 389013007, "title" => "Crafty Shoes - Red", "quantity" => 1, "sku" => "crappy_shoes_red", "variant_title" => "Small", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 910489600, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Crafty Shoes - Red - Small", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823177", "tax_lines" => []}], "tracking_number" => "1562678", "tracking_numbers" => ["1562678"], "tracking_url" => "https://www.my-shipping-company.com", "tracking_urls" => ["https://www.my-shipping-company.com"], "receipt" => {}, "name" => "#1001.2", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069019868"}}), headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.message = "The package was shipped this morning."
    fulfillment.notify_customer = false
    fulfillment.tracking_info = {
      "number" => 1562678,
      "url" => "https://www.my-shipping-company.com",
      "company" => "my-shipping-company"
    }
    fulfillment.line_items_by_fulfillment_order = [
      {
        "fulfillment_order_id" => 1046000784,
        "fulfillment_order_line_items" => [
          {
            "id" => 1058737493,
            "quantity" => 1
          }
        ]
      }
    ]
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/fulfillments.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"message" => "The package was shipped this morning.", "notify_customer" => false, "tracking_info" => {"number" => 1562678, "url" => "https://www.my-shipping-company.com", "company" => "my-shipping-company"}, "line_items_by_fulfillment_order" => [{"fulfillment_order_id" => 1046000778}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069019864, "order_id" => 450789469, "status" => "success", "created_at" => "2023-03-13T05:45:00-04:00", "service" => "manual", "updated_at" => "2023-03-13T05:45:00-04:00", "tracking_company" => "my-shipping-company", "shipment_status" => nil, "location_id" => 24826418, "line_items" => [{"id" => 1071823173, "variant_id" => 389013007, "title" => "Crafty Shoes - Red", "quantity" => 1, "sku" => "crappy_shoes_red", "variant_title" => "Small", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 910489600, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Crafty Shoes - Red - Small", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823173", "tax_lines" => []}], "tracking_number" => "1562678", "tracking_numbers" => ["1562678"], "tracking_url" => "https://www.my-shipping-company.com", "tracking_urls" => ["https://www.my-shipping-company.com"], "receipt" => {}, "name" => "#1001.2", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069019864"}}), headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.message = "The package was shipped this morning."
    fulfillment.notify_customer = false
    fulfillment.tracking_info = {
      "number" => 1562678,
      "url" => "https://www.my-shipping-company.com",
      "company" => "my-shipping-company"
    }
    fulfillment.line_items_by_fulfillment_order = [
      {
        "fulfillment_order_id" => 1046000778
      }
    ]
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/fulfillments.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/fulfillments/1069019865/update_tracking.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"notify_customer" => true, "tracking_info" => {"number" => "1111", "url" => "http://www.my-url.com", "company" => "my-company"}}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"tracking_company" => "my-company", "location_id" => 24826418, "id" => 1069019865, "order_id" => 450789469, "status" => "success", "created_at" => "2023-03-13T05:43:46-04:00", "service" => "manual", "updated_at" => "2023-03-13T05:45:08-04:00", "shipment_status" => nil, "line_items" => [{"id" => 1071823174, "variant_id" => 43729076, "title" => "Draft", "quantity" => 1, "sku" => "draft-151", "variant_title" => "151cm", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 108828309, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Draft - 151cm", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823174", "tax_lines" => []}], "tracking_number" => "1111", "tracking_numbers" => ["1111"], "tracking_url" => "http://www.my-url.com", "tracking_urls" => ["http://www.my-url.com"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069019865"}}), headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.id = 1069019865
    fulfillment.update_tracking(
      body: {"fulfillment" => {"notify_customer" => true, "tracking_info" => {"number" => "1111", "url" => "http://www.my-url.com", "company" => "my-company"}}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/fulfillments/1069019865/update_tracking.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-07/fulfillments/1069019873/cancel.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"order_id" => 450789469, "status" => "cancelled", "location_id" => 24826418, "id" => 1069019873, "created_at" => "2023-03-13T05:43:46-04:00", "service" => "manual", "updated_at" => "2023-03-13T05:45:34-04:00", "tracking_company" => "UPS", "shipment_status" => nil, "line_items" => [{"id" => 1071823178, "variant_id" => 43729076, "title" => "Draft", "quantity" => 1, "sku" => "draft-151", "variant_title" => "151cm", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 108828309, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Draft - 151cm", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823178", "tax_lines" => []}], "tracking_number" => "#\u26201\u2622\n---\n4321\n", "tracking_numbers" => ["#\u26201\u2622\n---\n4321\n"], "tracking_url" => "https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=#\u26201\u2622---4321", "tracking_urls" => ["https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=#\u26201\u2622---4321"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069019873"}}), headers: {})

    fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.id = 1069019873
    fulfillment.cancel

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-07/fulfillments/1069019873/cancel.json")
  end

end
