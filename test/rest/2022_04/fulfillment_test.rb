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

class Fulfillment202204Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillments" => [{"id" => 255858046, "order_id" => 450789469, "status" => "failure", "created_at" => "2023-05-04T05:33:48-04:00", "service" => "manual", "updated_at" => "2023-05-04T05:33:48-04:00", "tracking_company" => "USPS", "shipment_status" => nil, "location_id" => 655441491, "line_items" => [{"id" => 466157049, "variant_id" => 39072856, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008GREEN", "variant_title" => "green", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - green", "variant_inventory_management" => "shopify", "properties" => [{"name" => "Custom Engraving Front", "value" => "Happy Birthday"}, {"name" => "Custom Engraving Back", "value" => "Merry Christmas"}], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => nil, "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.34", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.34", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.34", "currency_code" => "USD"}}}], "admin_graphql_api_id" => "gid://shopify/LineItem/466157049", "duties" => [], "tax_lines" => [{"price" => "3.98", "rate" => 0.06, "title" => "State Tax", "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => "1Z2345", "tracking_numbers" => ["1Z2345"], "tracking_url" => "https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z2345", "tracking_urls" => ["https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z2345"], "receipt" => {"testcase" => true, "authorization" => "123456"}, "name" => "#1001.0", "admin_graphql_api_id" => "gid://shopify/Fulfillment/255858046"}]}), headers: {})

    response = ShopifyAPI::Fulfillment.all(
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json?since_id=255858046")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillments" => [{"id" => 1069020391, "order_id" => 450789469, "status" => "success", "created_at" => "2023-05-04T09:30:06-04:00", "service" => "shipwire-app", "updated_at" => "2023-05-04T09:30:06-04:00", "tracking_company" => "TNT", "shipment_status" => nil, "location_id" => 24826418, "line_items" => [{"id" => 518995019, "variant_id" => 49148385, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008RED", "variant_title" => "red", "vendor" => nil, "fulfillment_service" => "shipwire-app", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - red", "variant_inventory_management" => "shipwire-app", "properties" => [], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => nil, "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.33", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}}], "admin_graphql_api_id" => "gid://shopify/LineItem/518995019", "duties" => [], "tax_lines" => [{"price" => "3.98", "rate" => 0.06, "title" => "State Tax", "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => "123456789", "tracking_numbers" => ["123456789"], "tracking_url" => "https://www.tnt.com/express/en_us/site/tracking.html?searchType=con&cons=123456789", "tracking_urls" => ["https://www.tnt.com/express/en_us/site/tracking.html?searchType=con&cons=123456789"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020391"}]}), headers: {})

    response = ShopifyAPI::Fulfillment.all(
      order_id: 450789469,
      since_id: "255858046",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json?since_id=255858046")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"location_id" => 655441491, "tracking_number" => nil, "line_items" => [{"id" => 518995019}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069020387, "order_id" => 450789469, "status" => "success", "created_at" => "2023-05-04T09:29:55-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:29:55-04:00", "tracking_company" => nil, "shipment_status" => nil, "location_id" => 655441491, "origin_address" => nil, "line_items" => [{"id" => 518995019, "variant_id" => 49148385, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008RED", "variant_title" => "red", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - red", "variant_inventory_management" => "shopify", "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.33", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/518995019", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => nil, "tracking_numbers" => [], "tracking_url" => nil, "tracking_urls" => [], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020387"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_number = nil
    fulfillment.line_items = [
      {
        "id" => 518995019
      }
    ]
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"location_id" => 487838322, "tracking_number" => "123456789", "tracking_urls" => ["https://shipping.xyz/track.php?num=123456789", "https://anothershipper.corp/track.php?code=abc"], "notify_customer" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069020392, "order_id" => 450789469, "status" => "success", "created_at" => "2023-05-04T09:30:12-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:30:12-04:00", "tracking_company" => "TNT", "shipment_status" => nil, "location_id" => 487838322, "origin_address" => nil, "line_items" => [{"id" => 466157049, "variant_id" => 39072856, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008GREEN", "variant_title" => "green", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - green", "variant_inventory_management" => "shopify", "properties" => [{"name" => "Custom Engraving Front", "value" => "Happy Birthday"}, {"name" => "Custom Engraving Back", "value" => "Merry Christmas"}], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.34", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.34", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.34", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/466157049", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}, {"id" => 518995019, "variant_id" => 49148385, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008RED", "variant_title" => "red", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - red", "variant_inventory_management" => "shopify", "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.33", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/518995019", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}, {"id" => 703073504, "variant_id" => 457924702, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008BLACK", "variant_title" => "black", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - black", "variant_inventory_management" => "shopify", "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.33", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/703073504", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => "123456789", "tracking_numbers" => ["123456789"], "tracking_url" => "https://shipping.xyz/track.php?num=123456789", "tracking_urls" => ["https://shipping.xyz/track.php?num=123456789", "https://anothershipper.corp/track.php?code=abc"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020392"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.order_id = 450789469
    fulfillment.location_id = 487838322
    fulfillment.tracking_number = "123456789"
    fulfillment.tracking_urls = [
      "https://shipping.xyz/track.php?num=123456789",
      "https://anothershipper.corp/track.php?code=abc"
    ]
    fulfillment.notify_customer = true
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"location_id" => 655441491, "tracking_url" => "http://www.packagetrackr.com/track/somecarrier/1234567", "tracking_company" => "Jack Black Pack, Stack and Track", "line_items" => [{"id" => 518995019}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069020395, "order_id" => 450789469, "status" => "success", "created_at" => "2023-05-04T09:30:18-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:30:18-04:00", "tracking_company" => "Jack Black Pack, Stack and Track", "shipment_status" => nil, "location_id" => 655441491, "origin_address" => nil, "line_items" => [{"id" => 518995019, "variant_id" => 49148385, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008RED", "variant_title" => "red", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - red", "variant_inventory_management" => "shopify", "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.33", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/518995019", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => nil, "tracking_numbers" => [], "tracking_url" => "http://www.packagetrackr.com/track/somecarrier/1234567", "tracking_urls" => ["http://www.packagetrackr.com/track/somecarrier/1234567"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020395"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_url = "http://www.packagetrackr.com/track/somecarrier/1234567"
    fulfillment.tracking_company = "Jack Black Pack, Stack and Track"
    fulfillment.line_items = [
      {
        "id" => 518995019
      }
    ]
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"location_id" => 655441491, "tracking_numbers" => ["479d29ec6c762384b8c810c8206cd9fe", "a67b0a4d44d8e4dd00d12a4d93b64bdb", "168cfbdea5d8821e26bfe9168f098bd0"], "line_items" => [{"id" => 518995019}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069020381, "order_id" => 450789469, "status" => "success", "created_at" => "2023-05-04T09:29:39-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:29:39-04:00", "tracking_company" => "Deutsche Post", "shipment_status" => nil, "location_id" => 655441491, "origin_address" => nil, "line_items" => [{"id" => 518995019, "variant_id" => 49148385, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008RED", "variant_title" => "red", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - red", "variant_inventory_management" => "shopify", "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.33", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/518995019", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => "479d29ec6c762384b8c810c8206cd9fe", "tracking_numbers" => ["479d29ec6c762384b8c810c8206cd9fe", "a67b0a4d44d8e4dd00d12a4d93b64bdb", "168cfbdea5d8821e26bfe9168f098bd0"], "tracking_url" => "https://www.deutschepost.de/de/s/sendungsverfolgung/verfolgen.html?piececode=479d29ec6c762384b8c810c8206cd9fe", "tracking_urls" => ["https://www.deutschepost.de/de/s/sendungsverfolgung/verfolgen.html?piececode=479d29ec6c762384b8c810c8206cd9fe", "https://www.deutschepost.de/de/s/sendungsverfolgung/verfolgen.html?piececode=a67b0a4d44d8e4dd00d12a4d93b64bdb", "https://www.deutschepost.de/de/s/sendungsverfolgung/verfolgen.html?piececode=168cfbdea5d8821e26bfe9168f098bd0"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020381"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_numbers = [
      "479d29ec6c762384b8c810c8206cd9fe",
      "a67b0a4d44d8e4dd00d12a4d93b64bdb",
      "168cfbdea5d8821e26bfe9168f098bd0"
    ]
    fulfillment.line_items = [
      {
        "id" => 518995019
      }
    ]
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"location_id" => 655441491, "tracking_number" => "RR123456789CN", "tracking_company" => "Chinese Post", "line_items" => [{"id" => 518995019}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069020382, "order_id" => 450789469, "status" => "success", "created_at" => "2023-05-04T09:29:42-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:29:42-04:00", "tracking_company" => "Chinese Post", "shipment_status" => nil, "location_id" => 655441491, "origin_address" => nil, "line_items" => [{"id" => 518995019, "variant_id" => 49148385, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008RED", "variant_title" => "red", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - red", "variant_inventory_management" => "shopify", "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.33", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/518995019", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => "RR123456789CN", "tracking_numbers" => ["RR123456789CN"], "tracking_url" => "http://www.track-chinapost.com/result_china.php?order_no=RR123456789CN", "tracking_urls" => ["http://www.track-chinapost.com/result_china.php?order_no=RR123456789CN"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020382"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_number = "RR123456789CN"
    fulfillment.tracking_company = "Chinese Post"
    fulfillment.line_items = [
      {
        "id" => 518995019
      }
    ]
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"location_id" => 655441491, "tracking_number" => "1234567", "tracking_company" => "Custom Tracking Company", "line_items" => [{"id" => 518995019}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069020389, "order_id" => 450789469, "status" => "success", "created_at" => "2023-05-04T09:30:00-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:30:00-04:00", "tracking_company" => "Custom Tracking Company", "shipment_status" => nil, "location_id" => 655441491, "origin_address" => nil, "line_items" => [{"id" => 518995019, "variant_id" => 49148385, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008RED", "variant_title" => "red", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - red", "variant_inventory_management" => "shopify", "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.33", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/518995019", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => "1234567", "tracking_numbers" => ["1234567"], "tracking_url" => nil, "tracking_urls" => [], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020389"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_number = "1234567"
    fulfillment.tracking_company = "Custom Tracking Company"
    fulfillment.line_items = [
      {
        "id" => 518995019
      }
    ]
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"location_id" => 655441491, "tracking_number" => "123456789", "tracking_company" => "4PX", "line_items" => [{"id" => 518995019}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069020384, "order_id" => 450789469, "status" => "success", "created_at" => "2023-05-04T09:29:48-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:29:48-04:00", "tracking_company" => "4PX", "shipment_status" => nil, "location_id" => 655441491, "origin_address" => nil, "line_items" => [{"id" => 518995019, "variant_id" => 49148385, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008RED", "variant_title" => "red", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - red", "variant_inventory_management" => "shopify", "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.33", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/518995019", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => "123456789", "tracking_numbers" => ["123456789"], "tracking_url" => "http://track.4px.com", "tracking_urls" => ["http://track.4px.com"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020384"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_number = "123456789"
    fulfillment.tracking_company = "4PX"
    fulfillment.line_items = [
      {
        "id" => 518995019
      }
    ]
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"location_id" => 655441491, "tracking_number" => "123456789010", "tracking_company" => "fed ex", "line_items" => [{"id" => 518995019}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069020380, "order_id" => 450789469, "status" => "success", "created_at" => "2023-05-04T09:29:37-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:29:37-04:00", "tracking_company" => "fed ex", "shipment_status" => nil, "location_id" => 655441491, "origin_address" => nil, "line_items" => [{"id" => 518995019, "variant_id" => 49148385, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008RED", "variant_title" => "red", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - red", "variant_inventory_management" => "shopify", "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.33", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/518995019", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => "123456789010", "tracking_numbers" => ["123456789010"], "tracking_url" => "https://www.fedex.com/fedextrack/?trknbr=123456789010", "tracking_urls" => ["https://www.fedex.com/fedextrack/?trknbr=123456789010"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020380"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_number = "123456789010"
    fulfillment.tracking_company = "fed ex"
    fulfillment.line_items = [
      {
        "id" => 518995019
      }
    ]
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"location_id" => 655441491, "tracking_number" => "123456789010", "tracking_company" => "fed ex", "tracking_url" => "https://www.new-fedex-tracking.com/?number=123456789010", "line_items" => [{"id" => 518995019}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069020386, "order_id" => 450789469, "status" => "success", "created_at" => "2023-05-04T09:29:52-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:29:52-04:00", "tracking_company" => "fed ex", "shipment_status" => nil, "location_id" => 655441491, "origin_address" => nil, "line_items" => [{"id" => 518995019, "variant_id" => 49148385, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008RED", "variant_title" => "red", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - red", "variant_inventory_management" => "shopify", "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.33", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/518995019", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => "123456789010", "tracking_numbers" => ["123456789010"], "tracking_url" => "https://www.new-fedex-tracking.com/?number=123456789010", "tracking_urls" => ["https://www.new-fedex-tracking.com/?number=123456789010"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020386"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_number = "123456789010"
    fulfillment.tracking_company = "fed ex"
    fulfillment.tracking_url = "https://www.new-fedex-tracking.com/?number=123456789010"
    fulfillment.line_items = [
      {
        "id" => 518995019
      }
    ]
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"location_id" => 655441491, "tracking_number" => "CJ274101086US", "tracking_url" => "http://www.custom-tracking.com/?tracking_number=CJ274101086US", "line_items" => [{"id" => 518995019}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069020368, "order_id" => 450789469, "status" => "success", "created_at" => "2023-05-04T09:28:52-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:28:52-04:00", "tracking_company" => "USPS", "shipment_status" => nil, "location_id" => 655441491, "origin_address" => nil, "line_items" => [{"id" => 518995019, "variant_id" => 49148385, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008RED", "variant_title" => "red", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - red", "variant_inventory_management" => "shopify", "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.33", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/518995019", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => "CJ274101086US", "tracking_numbers" => ["CJ274101086US"], "tracking_url" => "http://www.custom-tracking.com/?tracking_number=CJ274101086US", "tracking_urls" => ["http://www.custom-tracking.com/?tracking_number=CJ274101086US"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020368"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_number = "CJ274101086US"
    fulfillment.tracking_url = "http://www.custom-tracking.com/?tracking_number=CJ274101086US"
    fulfillment.line_items = [
      {
        "id" => 518995019
      }
    ]
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"location_id" => 655441491, "tracking_number" => nil, "line_items" => [{"id" => 518995019}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069020377, "order_id" => 450789469, "status" => "success", "created_at" => "2023-05-04T09:29:27-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:29:27-04:00", "tracking_company" => nil, "shipment_status" => nil, "location_id" => 655441491, "origin_address" => nil, "line_items" => [{"id" => 518995019, "variant_id" => 49148385, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008RED", "variant_title" => "red", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - red", "variant_inventory_management" => "shopify", "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.33", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/518995019", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => nil, "tracking_numbers" => [], "tracking_url" => nil, "tracking_urls" => [], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020377"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_number = nil
    fulfillment.line_items = [
      {
        "id" => 518995019
      }
    ]
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"location_id" => 655441491, "tracking_number" => nil, "line_items" => [{"id" => 518995019, "quantity" => 1}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069020369, "order_id" => 450789469, "status" => "success", "created_at" => "2023-05-04T09:29:05-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:29:05-04:00", "tracking_company" => nil, "shipment_status" => nil, "location_id" => 655441491, "origin_address" => nil, "line_items" => [{"id" => 518995019, "variant_id" => 49148385, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008RED", "variant_title" => "red", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - red", "variant_inventory_management" => "shopify", "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.33", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.33", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.33", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/518995019", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => nil, "tracking_numbers" => [], "tracking_url" => nil, "tracking_urls" => [], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020369"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.order_id = 450789469
    fulfillment.location_id = 655441491
    fulfillment.tracking_number = nil
    fulfillment.line_items = [
      {
        "id" => 518995019,
        "quantity" => 1
      }
    ]
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments.json")

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
  def test_15()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/fulfillment_orders/1046001271/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillments" => [{"id" => 1069020376, "order_id" => 450789469, "status" => "success", "created_at" => "2023-05-04T05:33:48-04:00", "service" => "manual", "updated_at" => "2023-05-04T05:33:48-04:00", "tracking_company" => "UPS", "shipment_status" => nil, "location_id" => 24826418, "line_items" => [{"id" => 1071823429, "variant_id" => 43729076, "title" => "Draft", "quantity" => 1, "sku" => "draft-151", "variant_title" => "151cm", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 108828309, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Draft - 151cm", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823429", "tax_lines" => []}], "tracking_number" => "#\u26201\u2622\n---\n4321\n", "tracking_numbers" => ["#\u26201\u2622\n---\n4321\n"], "tracking_url" => "https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=#\u26201\u2622---4321", "tracking_urls" => ["https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=#\u26201\u2622---4321"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020376"}]}), headers: {})

    response = ShopifyAPI::Fulfillment.all(
      fulfillment_order_id: 1046001271,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/fulfillment_orders/1046001271/fulfillments.json")

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
  def test_16()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    response = ShopifyAPI::Fulfillment.count(
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments/count.json")

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
  def test_17()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments/255858046.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 255858046, "order_id" => 450789469, "status" => "failure", "created_at" => "2023-05-04T05:33:48-04:00", "service" => "manual", "updated_at" => "2023-05-04T05:33:48-04:00", "tracking_company" => "USPS", "shipment_status" => nil, "location_id" => 655441491, "origin_address" => nil, "line_items" => [{"id" => 466157049, "variant_id" => 39072856, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008GREEN", "variant_title" => "green", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - green", "variant_inventory_management" => "shopify", "properties" => [{"name" => "Custom Engraving Front", "value" => "Happy Birthday"}, {"name" => "Custom Engraving Back", "value" => "Merry Christmas"}], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => nil, "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.34", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.34", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.34", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/466157049", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => "1Z2345", "tracking_numbers" => ["1Z2345"], "tracking_url" => "https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z2345", "tracking_urls" => ["https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z2345"], "receipt" => {"testcase" => true, "authorization" => "123456"}, "name" => "#1001.0", "admin_graphql_api_id" => "gid://shopify/Fulfillment/255858046"}}), headers: {})

    response = ShopifyAPI::Fulfillment.find(
      order_id: 450789469,
      id: 255858046,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments/255858046.json")

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
  def test_18()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments/255858046.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"tracking_number" => "987654321"}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"location_id" => 655441491, "id" => 255858046, "order_id" => 450789469, "status" => "failure", "created_at" => "2023-05-04T05:33:48-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:29:18-04:00", "tracking_company" => "USPS", "shipment_status" => nil, "origin_address" => nil, "line_items" => [{"id" => 466157049, "variant_id" => 39072856, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008GREEN", "variant_title" => "green", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - green", "variant_inventory_management" => "shopify", "properties" => [{"name" => "Custom Engraving Front", "value" => "Happy Birthday"}, {"name" => "Custom Engraving Back", "value" => "Merry Christmas"}], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => nil, "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.34", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.34", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.34", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/466157049", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => "987654321", "tracking_numbers" => ["987654321"], "tracking_url" => "https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=987654321", "tracking_urls" => ["https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=987654321"], "receipt" => {"testcase" => true, "authorization" => "123456"}, "name" => "#1001.0", "admin_graphql_api_id" => "gid://shopify/Fulfillment/255858046"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.order_id = 450789469
    fulfillment.id = 255858046
    fulfillment.tracking_number = "987654321"
    fulfillment.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments/255858046.json")

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
  def test_19()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"line_items_by_fulfillment_order" => [{"fulfillment_order_id" => 1046001273}], "tracking_info" => {"number" => "MS1562678", "url" => "https://www.my-shipping-company.com?tracking_number=MS1562678"}}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069020379, "order_id" => 450789469, "status" => "success", "created_at" => "2023-05-04T09:29:29-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:29:29-04:00", "tracking_company" => nil, "shipment_status" => nil, "location_id" => 24826418, "line_items" => [{"id" => 1071823432, "variant_id" => 389013007, "title" => "Crafty Shoes - Red", "quantity" => 1, "sku" => "crappy_shoes_red", "variant_title" => "Small", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 910489600, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Crafty Shoes - Red - Small", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823432", "tax_lines" => []}], "tracking_number" => "MS1562678", "tracking_numbers" => ["MS1562678"], "tracking_url" => "https://www.my-shipping-company.com?tracking_number=MS1562678", "tracking_urls" => ["https://www.my-shipping-company.com?tracking_number=MS1562678"], "receipt" => {}, "name" => "#1001.2", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020379"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.line_items_by_fulfillment_order = [
      {
        "fulfillment_order_id" => 1046001273
      }
    ]
    fulfillment.tracking_info = {
      "number" => "MS1562678",
      "url" => "https://www.my-shipping-company.com?tracking_number=MS1562678"
    }
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/fulfillments.json")

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
  def test_20()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"line_items_by_fulfillment_order" => [{"fulfillment_order_id" => 1046001289}], "tracking_info" => {"number" => "1Z001985YW99744790"}}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069020394, "order_id" => 450789469, "status" => "success", "created_at" => "2023-05-04T09:30:15-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:30:15-04:00", "tracking_company" => "UPS", "shipment_status" => nil, "location_id" => 24826418, "line_items" => [{"id" => 1071823440, "variant_id" => 389013007, "title" => "Crafty Shoes - Red", "quantity" => 1, "sku" => "crappy_shoes_red", "variant_title" => "Small", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 910489600, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Crafty Shoes - Red - Small", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823440", "tax_lines" => []}], "tracking_number" => "1Z001985YW99744790", "tracking_numbers" => ["1Z001985YW99744790"], "tracking_url" => "https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=1Z001985YW99744790", "tracking_urls" => ["https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=1Z001985YW99744790"], "receipt" => {}, "name" => "#1001.2", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020394"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.line_items_by_fulfillment_order = [
      {
        "fulfillment_order_id" => 1046001289
      }
    ]
    fulfillment.tracking_info = {
      "number" => "1Z001985YW99744790"
    }
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/fulfillments.json")

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
  def test_21()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"message" => "The package was shipped this morning.", "notify_customer" => false, "tracking_info" => {"number" => "MS1562678", "url" => "https://www.my-shipping-company.com?tracking=MS1562678"}, "line_items_by_fulfillment_order" => [{"fulfillment_order_id" => 1046001269}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069020373, "order_id" => 450789469, "status" => "success", "created_at" => "2023-05-04T09:29:20-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:29:20-04:00", "tracking_company" => nil, "shipment_status" => nil, "location_id" => 24826418, "line_items" => [{"id" => 1071823426, "variant_id" => 389013007, "title" => "Crafty Shoes - Red", "quantity" => 1, "sku" => "crappy_shoes_red", "variant_title" => "Small", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 910489600, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Crafty Shoes - Red - Small", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823426", "tax_lines" => []}], "tracking_number" => "MS1562678", "tracking_numbers" => ["MS1562678"], "tracking_url" => "https://www.my-shipping-company.com?tracking=MS1562678", "tracking_urls" => ["https://www.my-shipping-company.com?tracking=MS1562678"], "receipt" => {}, "name" => "#1001.2", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020373"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.message = "The package was shipped this morning."
    fulfillment.notify_customer = false
    fulfillment.tracking_info = {
      "number" => "MS1562678",
      "url" => "https://www.my-shipping-company.com?tracking=MS1562678"
    }
    fulfillment.line_items_by_fulfillment_order = [
      {
        "fulfillment_order_id" => 1046001269
      }
    ]
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/fulfillments.json")

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
  def test_22()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"message" => "The package was shipped this morning.", "notify_customer" => false, "tracking_info" => {"number" => "1Z001985YW99744790", "company" => "UPS"}, "line_items_by_fulfillment_order" => [{"fulfillment_order_id" => 1046001270, "fulfillment_order_line_items" => [{"id" => 1058738388, "quantity" => 1}]}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069020375, "order_id" => 450789469, "status" => "success", "created_at" => "2023-05-04T09:29:23-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:29:23-04:00", "tracking_company" => "UPS", "shipment_status" => nil, "location_id" => 24826418, "line_items" => [{"id" => 1071823428, "variant_id" => 389013007, "title" => "Crafty Shoes - Red", "quantity" => 1, "sku" => "crappy_shoes_red", "variant_title" => "Small", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 910489600, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Crafty Shoes - Red - Small", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823428", "tax_lines" => []}], "tracking_number" => "1Z001985YW99744790", "tracking_numbers" => ["1Z001985YW99744790"], "tracking_url" => "https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=1Z001985YW99744790", "tracking_urls" => ["https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=1Z001985YW99744790"], "receipt" => {}, "name" => "#1001.2", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020375"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.message = "The package was shipped this morning."
    fulfillment.notify_customer = false
    fulfillment.tracking_info = {
      "number" => "1Z001985YW99744790",
      "company" => "UPS"
    }
    fulfillment.line_items_by_fulfillment_order = [
      {
        "fulfillment_order_id" => 1046001270,
        "fulfillment_order_line_items" => [
          {
            "id" => 1058738388,
            "quantity" => 1
          }
        ]
      }
    ]
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/fulfillments.json")

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
  def test_23()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/fulfillments.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"line_items_by_fulfillment_order" => [{"fulfillment_order_id" => 1046001268}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"id" => 1069020371, "order_id" => 450789469, "status" => "success", "created_at" => "2023-05-04T09:29:16-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:29:16-04:00", "tracking_company" => nil, "shipment_status" => nil, "location_id" => 24826418, "line_items" => [{"id" => 1071823424, "variant_id" => 389013007, "title" => "Crafty Shoes - Red", "quantity" => 1, "sku" => "crappy_shoes_red", "variant_title" => "Small", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 910489600, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Crafty Shoes - Red - Small", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823424", "tax_lines" => []}], "tracking_number" => nil, "tracking_numbers" => [], "tracking_url" => nil, "tracking_urls" => [], "receipt" => {}, "name" => "#1001.2", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020371"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.line_items_by_fulfillment_order = [
      {
        "fulfillment_order_id" => 1046001268
      }
    ]
    fulfillment.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/fulfillments.json")

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
  def test_24()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/fulfillments/1069020390/update_tracking.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"notify_customer" => true, "tracking_info" => {"company" => "UPS", "number" => "1Z001985YW99744790"}}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"tracking_company" => "UPS", "location_id" => 24826418, "id" => 1069020390, "order_id" => 450789469, "status" => "success", "created_at" => "2023-05-04T05:33:48-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:30:02-04:00", "shipment_status" => nil, "line_items" => [{"id" => 1071823437, "variant_id" => 43729076, "title" => "Draft", "quantity" => 1, "sku" => "draft-151", "variant_title" => "151cm", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 108828309, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Draft - 151cm", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823437", "tax_lines" => []}], "tracking_number" => "1Z001985YW99744790", "tracking_numbers" => ["1Z001985YW99744790"], "tracking_url" => "https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=1Z001985YW99744790", "tracking_urls" => ["https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=1Z001985YW99744790"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020390"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.id = 1069020390
    fulfillment.update_tracking(
      body: {"fulfillment" => {"notify_customer" => true, "tracking_info" => {"company" => "UPS", "number" => "1Z001985YW99744790"}}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/fulfillments/1069020390/update_tracking.json")

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
  def test_25()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/fulfillments/1069020385/update_tracking.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "fulfillment" => hash_including({"notify_customer" => true, "tracking_info" => {"number" => "1111", "url" => "http://www.my-url.com"}}) }
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"tracking_company" => nil, "location_id" => 24826418, "id" => 1069020385, "order_id" => 450789469, "status" => "success", "created_at" => "2023-05-04T05:33:48-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:29:50-04:00", "shipment_status" => nil, "line_items" => [{"id" => 1071823433, "variant_id" => 43729076, "title" => "Draft", "quantity" => 1, "sku" => "draft-151", "variant_title" => "151cm", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 108828309, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Draft - 151cm", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823433", "tax_lines" => []}], "tracking_number" => "1111", "tracking_numbers" => ["1111"], "tracking_url" => "http://www.my-url.com", "tracking_urls" => ["http://www.my-url.com"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020385"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.id = 1069020385
    fulfillment.update_tracking(
      body: {"fulfillment" => {"notify_customer" => true, "tracking_info" => {"number" => "1111", "url" => "http://www.my-url.com"}}},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/fulfillments/1069020385/update_tracking.json")

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
  def test_26()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments/255858046/complete.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"status" => "success", "location_id" => 655441491, "id" => 255858046, "order_id" => 450789469, "created_at" => "2023-05-04T05:33:48-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:29:34-04:00", "tracking_company" => "USPS", "shipment_status" => nil, "origin_address" => nil, "line_items" => [{"id" => 466157049, "variant_id" => 39072856, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008GREEN", "variant_title" => "green", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - green", "variant_inventory_management" => "shopify", "properties" => [{"name" => "Custom Engraving Front", "value" => "Happy Birthday"}, {"name" => "Custom Engraving Back", "value" => "Merry Christmas"}], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => nil, "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.34", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.34", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.34", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/466157049", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => "1Z2345", "tracking_numbers" => ["1Z2345"], "tracking_url" => "https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z2345", "tracking_urls" => ["https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z2345"], "receipt" => {"testcase" => true, "authorization" => "123456"}, "name" => "#1001.0", "admin_graphql_api_id" => "gid://shopify/Fulfillment/255858046"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.order_id = 450789469
    fulfillment.id = 255858046
    fulfillment.complete

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments/255858046/complete.json")

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
  def test_27()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments/255858046/open.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"status" => "open", "location_id" => 655441491, "id" => 255858046, "order_id" => 450789469, "created_at" => "2023-05-04T05:33:48-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:29:11-04:00", "tracking_company" => "USPS", "shipment_status" => nil, "origin_address" => nil, "line_items" => [{"id" => 466157049, "variant_id" => 39072856, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008GREEN", "variant_title" => "green", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - green", "variant_inventory_management" => "shopify", "properties" => [{"name" => "Custom Engraving Front", "value" => "Happy Birthday"}, {"name" => "Custom Engraving Back", "value" => "Merry Christmas"}], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => nil, "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.34", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.34", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.34", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/466157049", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "channel_liable" => nil, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => "1Z2345", "tracking_numbers" => ["1Z2345"], "tracking_url" => "https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z2345", "tracking_urls" => ["https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z2345"], "receipt" => {"testcase" => true, "authorization" => "123456"}, "name" => "#1001.0", "admin_graphql_api_id" => "gid://shopify/Fulfillment/255858046"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.order_id = 450789469
    fulfillment.id = 255858046
    fulfillment.open

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments/255858046/open.json")

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
  def test_28()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments/255858046/cancel.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"order_id" => 450789469, "status" => "cancelled", "location_id" => 655441491, "id" => 255858046, "created_at" => "2023-05-04T05:33:48-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:29:14-04:00", "tracking_company" => "USPS", "shipment_status" => nil, "line_items" => [{"id" => 466157049, "variant_id" => 39072856, "title" => "IPod Nano - 8gb", "quantity" => 1, "sku" => "IPOD2008GREEN", "variant_title" => "green", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 632910392, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "IPod Nano - 8gb - green", "variant_inventory_management" => "shopify", "properties" => [{"name" => "Custom Engraving Front", "value" => "Happy Birthday"}, {"name" => "Custom Engraving Back", "value" => "Merry Christmas"}], "product_exists" => true, "fulfillable_quantity" => 0, "grams" => 200, "price" => "199.00", "total_discount" => "0.00", "fulfillment_status" => nil, "price_set" => {"shop_money" => {"amount" => "199.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "199.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [{"amount" => "3.34", "discount_application_index" => 0, "amount_set" => {"shop_money" => {"amount" => "3.34", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.34", "currency_code" => "USD"}}}], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/466157049", "tax_lines" => [{"title" => "State Tax", "price" => "3.98", "rate" => 0.06, "price_set" => {"shop_money" => {"amount" => "3.98", "currency_code" => "USD"}, "presentment_money" => {"amount" => "3.98", "currency_code" => "USD"}}}]}], "tracking_number" => "1Z2345", "tracking_numbers" => ["1Z2345"], "tracking_url" => "https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z2345", "tracking_urls" => ["https://tools.usps.com/go/TrackConfirmAction_input?qtc_tLabels1=1Z2345"], "receipt" => {"testcase" => true, "authorization" => "123456"}, "name" => "#1001.0", "admin_graphql_api_id" => "gid://shopify/Fulfillment/255858046"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.order_id = 450789469
    fulfillment.id = 255858046
    fulfillment.cancel

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/orders/450789469/fulfillments/255858046/cancel.json")

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
  def test_29()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/fulfillments/1069020388/cancel.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"fulfillment" => {"order_id" => 450789469, "status" => "cancelled", "location_id" => 24826418, "id" => 1069020388, "created_at" => "2023-05-04T05:33:48-04:00", "service" => "manual", "updated_at" => "2023-05-04T09:29:57-04:00", "tracking_company" => "UPS", "shipment_status" => nil, "line_items" => [{"id" => 1071823435, "variant_id" => 43729076, "title" => "Draft", "quantity" => 1, "sku" => "draft-151", "variant_title" => "151cm", "vendor" => nil, "fulfillment_service" => "manual", "product_id" => 108828309, "requires_shipping" => true, "taxable" => true, "gift_card" => false, "name" => "Draft - 151cm", "variant_inventory_management" => nil, "properties" => [], "product_exists" => true, "fulfillable_quantity" => 1, "grams" => 0, "price" => "10.00", "total_discount" => "0.00", "fulfillment_status" => "fulfilled", "price_set" => {"shop_money" => {"amount" => "10.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "10.00", "currency_code" => "USD"}}, "total_discount_set" => {"shop_money" => {"amount" => "0.00", "currency_code" => "USD"}, "presentment_money" => {"amount" => "0.00", "currency_code" => "USD"}}, "discount_allocations" => [], "duties" => [], "admin_graphql_api_id" => "gid://shopify/LineItem/1071823435", "tax_lines" => []}], "tracking_number" => "#\u26201\u2622\n---\n4321\n", "tracking_numbers" => ["#\u26201\u2622\n---\n4321\n"], "tracking_url" => "https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=#\u26201\u2622---4321", "tracking_urls" => ["https://www.ups.com/WebTracking?loc=en_US&requester=ST&trackNums=#\u26201\u2622---4321"], "receipt" => {}, "name" => "#1001.1", "admin_graphql_api_id" => "gid://shopify/Fulfillment/1069020388"}}), headers: {})

    response = fulfillment = ShopifyAPI::Fulfillment.new
    fulfillment.id = 1069020388
    fulfillment.cancel

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/fulfillments/1069020388/cancel.json")

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
