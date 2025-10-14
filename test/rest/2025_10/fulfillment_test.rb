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

class Fulfillment202510Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2025-10/orders/450789469/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillments" => [{"id" => 255858046, "order_id" => 450789469, "status" => "failure", "created_at" => "2025-07-02T11:38:15-05:00", "service" => "manual", "updated_at" => "2025-07-02T11:38:15-05:00", "tracking_company" => "USPS", "shipment_status" => nil, "location_id" => 655441491, "origin_address" => nil, "line_items" => [{"id" => 466157049, "variant_id" => 39072856, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008GREEN", "variant_title" => "green", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - green", "variant_inventory_management" => "shopify", "properties" => [{"name" => "Custom Engraving Front", "value" => "Happy Birthday"}, {"name" => "Custom Engraving Back", "value" => "Merry Christmas"}], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => nil, "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.34", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.34", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.34", "currency_code" => "USD"}}}], "admin_graphql_api_id" => "gid://shopify/LineItem/466157049", "duties" => [], "tax_lines" => [{"price" => "3.98", "rate" => 0.06, "title" => "State Tax", "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "channel_liable" => nil}], "fulfillment_line_item_id" => 225088298}], "tracking_number" => "1Z1234512345123456", "tracking_numbers" => ["1Z1234512345123456"], "tracking_url" => "https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z1234512345123456", "tracking_urls" => ["https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z1234512345123456"], "receipt" => {"testcase" => true, "authorization" => "123456"}, "name" => "#1001.0", "admin_graphql_api_id" => "gid://shopify/Fulfillment/255858046"}]}), headers: {})

    response = ShopifyAPI::Fulfillment.all(
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2025-10/orders/450789469/fulfillments.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2025-10/orders/450789469/fulfillments.json?since_id=255858046")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillments" => [{"id" => 1069019878, "order_id" => 450789469, "status" => "success", "created_at" => "2025-07-02T11:38:43-05:00", "service" => "shipwire-app", "updated_at" => "2025-07-02T11:38:43-05:00", "tracking_company" => "my-custom-shipping-company", "shipment_status" => nil, "location_id" => 24826418, "origin_address" => nil, "line_items" => [{"id" => 518995019, "variant_id" => 49148385, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008RED", "variant_title" => "red", "vendor" => nil, "fulfillment_service" => "shipwire-app", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - red", "variant_inventory_management" => "shopify", "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.33", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}}], "admin_graphql_api_id" => "gid://shopify/LineItem/518995019", "duties" => [], "tax_lines" => [{"price" => "3.98", "rate" => 0.06, "title" => "State Tax", "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}, "channel_liable" => nil}], "fulfillment_line_item_id" => 1024374829}], "tracking_number" => "123456789", "tracking_numbers" => ["123456789"], "tracking_url" => "http://my-custom-shipping-company.shopifyapps.com/track/123456", "tracking_urls" => ["http://my-custom-shipping-company.shopifyapps.com/track/123456", "http://my-custom-shipping-company.shopifyapps.com/track/789012"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069019878"}]}), headers: {})

    response = ShopifyAPI::Fulfillment.all(
      order_id: 450789469,
      since_id: "255858046",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2025-10/orders/450789469/fulfillments.json?since_id=255858046")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillment_orders/1046000819/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillments" => [{"id" => 1069019880, "order_id" => 450789469, "status" => "success", "created_at" => "2025-07-02T11:38:15-05:00", "service" => "manual", "updated_at" => "2025-07-02T11:38:15-05:00", "tracking_company" => "UPS", "shipment_status" => nil, "location_id" => 24826418, "origin_address" => {"address1" => "150 Elgin St", "city" => "Ottawa", "zip" => "K2P 1L4", "province_code" => "ON", "country_code" => "CA"}, "line_items" => [{"id" => 1071823219, "variant_id" => 43729076, "title" => "Draft", "quantity" => 1, "sku" => "draft-151", "variant_title" => "151cm", "vendor" => "Birthday Present Factory", "fulfillment_service" => "manual", "product_id" => 108828309, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Draft - 151cm", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823219", "tax_lines" => []}], "tracking_number" => "#\u26201\u2622\n---\n4321\n", "tracking_numbers" => ["#\u26201\u2622\n---\n4321\n"], "tracking_url" => "https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=#\u26201\u2622---4321", "tracking_urls" => ["https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=#\u26201\u2622---4321"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069019880"}]}), headers: {})

    response = ShopifyAPI::Fulfillment.all(
      fulfillment_order_id: 1046000819,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillment_orders/1046000819/fulfillments.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2025-10/orders/450789469/fulfillments/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    response = ShopifyAPI::Fulfillment.count(
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2025-10/orders/450789469/fulfillments/count.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2025-10/orders/450789469/fulfillments/255858046.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 255858046, "order_id" => 450789469, "status" => "failure", "created_at" => "2025-07-02T11:38:15-05:00", "service" => "manual", "updated_at" => "2025-07-02T11:38:15-05:00", "tracking_company" => "USPS", "shipment_status" => nil, "location_id" => 655441491, "origin_address" => nil, "line_items" => [{"id" => 466157049, "variant_id" => 39072856, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008GREEN", "variant_title" => "green", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - green", "variant_inventory_management" => "shopify", "properties" => [{"name" => "Custom Engraving Front", "value" => "Happy Birthday"}, {"name" => "Custom Engraving Back", "value" => "Merry Christmas"}], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => nil, "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.34", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.34", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.34", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/466157049", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => "1Z1234512345123456", "tracking_numbers" => ["1Z1234512345123456"], "tracking_url" => "https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z1234512345123456", "tracking_urls" => ["https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z1234512345123456"], "receipt" => {"testcase" => true, "authorization" => "123456"}, "name" => "#1001.0", "admin_graphql_api_id" => "gid://shopify/Fulfillment/255858046"}}), headers: {})

    response = ShopifyAPI::Fulfillment.find(
      order_id: 450789469,
      id: 255858046,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2025-10/orders/450789469/fulfillments/255858046.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"line_items_by_fulfillment_order" => [{"fulfillment_order_id" => 1046000816}], "tracking_info" => {"number" => "MS1562678", "url" => "https://www.my-shipping-company.com?tracking_number=MS1562678"}}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069019877, "order_id" => 450789469, "status" => "success", "created_at" => "2025-07-02T11:38:43-05:00", "service" => "manual", "updated_at" => "2025-07-02T11:38:43-05:00", "tracking_company" => nil, "shipment_status" => nil, "location_id" => 24826418, "origin_address" => nil, "line_items" => [{"id" => 1071823216, "variant_id" => 389013007, "title" => "Crafty Shoes - Red", "quantity" => 1, "sku" => "crafty_shoes_red", "variant_title" => "Small", "vendor" => "Birthday Present Factory", "fulfillment_service" => "manual", "product_id" => 910489600, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Crafty Shoes - Red - Small", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823216", "tax_lines" => []}], "tracking_number" => "MS1562678", "tracking_numbers" => ["MS1562678"], "tracking_url" => "https://www.my-shipping-company.com?tracking_number=MS1562678", "tracking_urls" => ["https://www.my-shipping-company.com?tracking_number=MS1562678"], "receipt" => {}, "name" => "#1001.2", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069019877"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.line_items_by_fulfillment_order = [
      {
        "fulfillment_order_id" => 1046000816
      }
    ]
    fulfillment.tracking_info = {
      "number" => "MS1562678",
      "url" => "https://www.my-shipping-company.com?tracking_number=MS1562678"
    }
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillments.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"line_items_by_fulfillment_order" => [{"fulfillment_order_id" => 1046000813}], "tracking_info" => {"number" => "1Z001985YW99744790"}}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069019871, "order_id" => 450789469, "status" => "success", "created_at" => "2025-07-02T11:38:40-05:00", "service" => "manual", "updated_at" => "2025-07-02T11:38:40-05:00", "tracking_company" => "UPS", "shipment_status" => nil, "location_id" => 24826418, "origin_address" => nil, "line_items" => [{"id" => 1071823210, "variant_id" => 389013007, "title" => "Crafty Shoes - Red", "quantity" => 1, "sku" => "crafty_shoes_red", "variant_title" => "Small", "vendor" => "Birthday Present Factory", "fulfillment_service" => "manual", "product_id" => 910489600, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Crafty Shoes - Red - Small", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823210", "tax_lines" => []}], "tracking_number" => "1Z001985YW99744790", "tracking_numbers" => ["1Z001985YW99744790"], "tracking_url" => "https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=1Z001985YW99744790", "tracking_urls" => ["https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=1Z001985YW99744790"], "receipt" => {}, "name" => "#1001.2", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069019871"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.line_items_by_fulfillment_order = [
      {
        "fulfillment_order_id" => 1046000813
      }
    ]
    fulfillment.tracking_info = {
      "number" => "1Z001985YW99744790"
    }
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillments.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"message" => "The package was shipped this morning.", "notify_customer" => false, "tracking_info" => {"number" => "MS1562678", "url" => "https://www.my-shipping-company.com?tracking=MS1562678"}, "line_items_by_fulfillment_order" => [{"fulfillment_order_id" => 1046000814}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069019873, "order_id" => 450789469, "status" => "success", "created_at" => "2025-07-02T11:38:41-05:00", "service" => "manual", "updated_at" => "2025-07-02T11:38:41-05:00", "tracking_company" => nil, "shipment_status" => nil, "location_id" => 24826418, "origin_address" => nil, "line_items" => [{"id" => 1071823212, "variant_id" => 389013007, "title" => "Crafty Shoes - Red", "quantity" => 1, "sku" => "crafty_shoes_red", "variant_title" => "Small", "vendor" => "Birthday Present Factory", "fulfillment_service" => "manual", "product_id" => 910489600, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Crafty Shoes - Red - Small", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823212", "tax_lines" => []}], "tracking_number" => "MS1562678", "tracking_numbers" => ["MS1562678"], "tracking_url" => "https://www.my-shipping-company.com?tracking=MS1562678", "tracking_urls" => ["https://www.my-shipping-company.com?tracking=MS1562678"], "receipt" => {}, "name" => "#1001.2", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069019873"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.message = "The package was shipped this morning."
    fulfillment.notify_customer = false
    fulfillment.tracking_info = {
      "number" => "MS1562678",
      "url" => "https://www.my-shipping-company.com?tracking=MS1562678"
    }
    fulfillment.line_items_by_fulfillment_order = [
      {
        "fulfillment_order_id" => 1046000814
      }
    ]
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillments.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"message" => "The package was shipped this morning.", "notify_customer" => false, "tracking_info" => {"number" => "1Z001985YW99744790", "company" => "UPS"}, "line_items_by_fulfillment_order" => [{"fulfillment_order_id" => 1046000811, "fulfillment_order_line_items" => [{"id" => 1072503316, "quantity" => 1}]}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069019868, "order_id" => 450789469, "status" => "success", "created_at" => "2025-07-02T11:38:38-05:00", "service" => "manual", "updated_at" => "2025-07-02T11:38:38-05:00", "tracking_company" => "UPS", "shipment_status" => nil, "location_id" => 24826418, "origin_address" => nil, "line_items" => [{"id" => 1071823206, "variant_id" => 389013007, "title" => "Crafty Shoes - Red", "quantity" => 1, "sku" => "crafty_shoes_red", "variant_title" => "Small", "vendor" => "Birthday Present Factory", "fulfillment_service" => "manual", "product_id" => 910489600, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Crafty Shoes - Red - Small", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823206", "tax_lines" => []}], "tracking_number" => "1Z001985YW99744790", "tracking_numbers" => ["1Z001985YW99744790"], "tracking_url" => "https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=1Z001985YW99744790", "tracking_urls" => ["https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=1Z001985YW99744790"], "receipt" => {}, "name" => "#1001.2", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069019868"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.message = "The package was shipped this morning."
    fulfillment.notify_customer = false
    fulfillment.tracking_info = {
      "number" => "1Z001985YW99744790",
      "company" => "UPS"
    }
    fulfillment.line_items_by_fulfillment_order = [
      {
        "fulfillment_order_id" => 1046000811,
        "fulfillment_order_line_items" => [
          {
            "id" => 1072503316,
            "quantity" => 1
          }
        ]
      }
    ]
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillments.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"line_items_by_fulfillment_order" => [{"fulfillment_order_id" => 1046000815}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069019875, "order_id" => 450789469, "status" => "success", "created_at" => "2025-07-02T11:38:42-05:00", "service" => "manual", "updated_at" => "2025-07-02T11:38:42-05:00", "tracking_company" => nil, "shipment_status" => nil, "location_id" => 24826418, "origin_address" => nil, "line_items" => [{"id" => 1071823214, "variant_id" => 389013007, "title" => "Crafty Shoes - Red", "quantity" => 1, "sku" => "crafty_shoes_red", "variant_title" => "Small", "vendor" => "Birthday Present Factory", "fulfillment_service" => "manual", "product_id" => 910489600, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Crafty Shoes - Red - Small", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823214", "tax_lines" => []}], "tracking_number" => nil, "tracking_numbers" => [], "tracking_url" => nil, "tracking_urls" => [], "receipt" => {}, "name" => "#1001.2", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069019875"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.line_items_by_fulfillment_order = [
      {
        "fulfillment_order_id" => 1046000815
      }
    ]
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillments.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillments/1069019869/update_tracking.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"notify_customer" => true, "tracking_info" => {"company" => "UPS", "number" => "1Z001985YW99744790"}}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"tracking_company" => "UPS", "location_id" => 24826418, "id" => 1069019869, "order_id" => 450789469, "status" => "success", "created_at" => "2025-07-02T11:38:15-05:00", "service" => "manual", "updated_at" => "2025-07-02T11:38:39-05:00", "shipment_status" => nil, "origin_address" => {"address1" => "150 Elgin St", "city" => "Ottawa", "zip" => "K2P 1L4", "province_code" => "ON", "country_code" => "CA"}, "line_items" => [{"id" => 1071823207, "variant_id" => 43729076, "title" => "Draft", "quantity" => 1, "sku" => "draft-151", "variant_title" => "151cm", "vendor" => "Birthday Present Factory", "fulfillment_service" => "manual", "product_id" => 108828309, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Draft - 151cm", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823207", "tax_lines" => []}], "tracking_number" => "1Z001985YW99744790", "tracking_numbers" => ["1Z001985YW99744790"], "tracking_url" => "https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=1Z001985YW99744790", "tracking_urls" => ["https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=1Z001985YW99744790"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069019869"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.id = 1069019869
    fulfillment.update_tracking(
      body: {"fulfillment" => {"notify_customer" => true, "tracking_info" => {"company" => "UPS", "number" => "1Z001985YW99744790"}}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillments/1069019869/update_tracking.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillments/1069019866/update_tracking.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"notify_customer" => true, "tracking_info" => {"number" => "1111", "url" => "http://www.my-url.com"}}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"tracking_company" => nil, "location_id" => 24826418, "id" => 1069019866, "order_id" => 450789469, "status" => "success", "created_at" => "2025-07-02T11:38:15-05:00", "service" => "manual", "updated_at" => "2025-07-02T11:38:37-05:00", "shipment_status" => nil, "origin_address" => {"address1" => "150 Elgin St", "city" => "Ottawa", "zip" => "K2P 1L4", "province_code" => "ON", "country_code" => "CA"}, "line_items" => [{"id" => 1071823203, "variant_id" => 43729076, "title" => "Draft", "quantity" => 1, "sku" => "draft-151", "variant_title" => "151cm", "vendor" => "Birthday Present Factory", "fulfillment_service" => "manual", "product_id" => 108828309, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Draft - 151cm", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823203", "tax_lines" => []}], "tracking_number" => "1111", "tracking_numbers" => ["1111"], "tracking_url" => "http://www.my-url.com", "tracking_urls" => ["http://www.my-url.com"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069019866"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.id = 1069019866
    fulfillment.update_tracking(
      body: {"fulfillment" => {"notify_customer" => true, "tracking_info" => {"number" => "1111", "url" => "http://www.my-url.com"}}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillments/1069019866/update_tracking.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillments/1069019879/cancel.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"order_id" => 450789469, "status" => "cancelled", "location_id" => 24826418, "id" => 1069019879, "created_at" => "2025-07-02T11:38:15-05:00", "service" => "manual", "updated_at" => "2025-07-02T11:38:45-05:00", "tracking_company" => "UPS", "shipment_status" => nil, "origin_address" => {"address1" => "150 Elgin St", "city" => "Ottawa", "zip" => "K2P 1L4", "province_code" => "ON", "country_code" => "CA"}, "line_items" => [{"id" => 1071823217, "variant_id" => 43729076, "title" => "Draft", "quantity" => 1, "sku" => "draft-151", "variant_title" => "151cm", "vendor" => "Birthday Present Factory", "fulfillment_service" => "manual", "product_id" => 108828309, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Draft - 151cm", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823217", "tax_lines" => []}], "tracking_number" => "#\u26201\u2622\n---\n4321\n", "tracking_numbers" => ["#\u26201\u2622\n---\n4321\n"], "tracking_url" => "https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=#\u26201\u2622---4321", "tracking_urls" => ["https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=#\u26201\u2622---4321"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069019879"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.id = 1069019879
    fulfillment.cancel

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2025-10/fulfillments/1069019879/cancel.json")

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
