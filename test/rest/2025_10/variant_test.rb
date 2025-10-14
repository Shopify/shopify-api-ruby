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

class Variant202510Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2025-10/products/632910392/variants.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"variants" => [{"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2025-10-02T11:38:15-05:00", "updated_at" => "2025-10-02T11:38:15-05:00", "taxable" => true, "barcode" => "1234_green", "fulfillment_service" => "manual", "grams" => 567, "inventory_management" => "shopify", "requires_shipping" => true, "sku" => "IPOD2008GREEN", "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856", "image_id" => nil}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2025-10-02T11:38:15-05:00", "updated_at" => "2025-10-02T11:38:15-05:00", "taxable" => true, "barcode" => "1234_red", "fulfillment_service" => "manual", "grams" => 567, "inventory_management" => "shopify", "requires_shipping" => true, "sku" => "IPOD2008RED", "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385", "image_id" => nil}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2025-10-02T11:38:15-05:00", "updated_at" => "2025-10-02T11:38:15-05:00", "taxable" => true, "barcode" => "1234_black", "fulfillment_service" => "manual", "grams" => 567, "inventory_management" => "shopify", "requires_shipping" => true, "sku" => "IPOD2008BLACK", "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702", "image_id" => nil}, {"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2025-10-02T11:38:15-05:00", "updated_at" => "2025-10-02T11:38:15-05:00", "taxable" => true, "barcode" => "1234_pink", "fulfillment_service" => "manual", "grams" => 567, "inventory_management" => "shopify", "requires_shipping" => true, "sku" => "IPOD2008PINK", "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810", "image_id" => 562641783}]}), headers: {})

    response = ShopifyAPI::Variant.all(
      product_id: 632910392,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2025-10/products/632910392/variants.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2025-10/products/632910392/variants.json?since_id=49148385")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"variants" => [{"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2025-10-02T11:38:15-05:00", "updated_at" => "2025-10-02T11:38:15-05:00", "taxable" => true, "barcode" => "1234_black", "fulfillment_service" => "manual", "grams" => 567, "inventory_management" => "shopify", "requires_shipping" => true, "sku" => "IPOD2008BLACK", "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702", "image_id" => nil}, {"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2025-10-02T11:38:15-05:00", "updated_at" => "2025-10-02T11:38:15-05:00", "taxable" => true, "barcode" => "1234_pink", "fulfillment_service" => "manual", "grams" => 567, "inventory_management" => "shopify", "requires_shipping" => true, "sku" => "IPOD2008PINK", "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810", "image_id" => 562641783}]}), headers: {})

    response = ShopifyAPI::Variant.all(
      product_id: 632910392,
      since_id: "49148385",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2025-10/products/632910392/variants.json?since_id=49148385")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2025-10/products/632910392/variants.json?presentment_currencies=USD%2CCAD")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"variants" => [{"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => "249.00", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2025-10-02T11:38:15-05:00", "updated_at" => "2025-10-02T11:38:15-05:00", "taxable" => true, "barcode" => "1234_green", "fulfillment_service" => "manual", "grams" => 567, "inventory_management" => "shopify", "requires_shipping" => true, "sku" => "IPOD2008GREEN", "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => {"amount" => "249.00", "currency_code" => "USD"}}, {"price" => {"amount" => "249.00", "currency_code" => "CAD"}, "compare_at_price" => {"amount" => "312.00", "currency_code" => "CAD"}}], "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856", "image_id" => nil}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => "249.00", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2025-10-02T11:38:15-05:00", "updated_at" => "2025-10-02T11:38:15-05:00", "taxable" => true, "barcode" => "1234_red", "fulfillment_service" => "manual", "grams" => 567, "inventory_management" => "shopify", "requires_shipping" => true, "sku" => "IPOD2008RED", "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => {"amount" => "249.00", "currency_code" => "USD"}}, {"price" => {"amount" => "249.00", "currency_code" => "CAD"}, "compare_at_price" => {"amount" => "312.00", "currency_code" => "CAD"}}], "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385", "image_id" => nil}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => "249.00", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2025-10-02T11:38:15-05:00", "updated_at" => "2025-10-02T11:38:15-05:00", "taxable" => true, "barcode" => "1234_black", "fulfillment_service" => "manual", "grams" => 567, "inventory_management" => "shopify", "requires_shipping" => true, "sku" => "IPOD2008BLACK", "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => {"amount" => "249.00", "currency_code" => "USD"}}, {"price" => {"amount" => "249.00", "currency_code" => "CAD"}, "compare_at_price" => {"amount" => "312.00", "currency_code" => "CAD"}}], "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702", "image_id" => nil}, {"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => "249.00", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2025-10-02T11:38:15-05:00", "updated_at" => "2025-10-02T11:38:15-05:00", "taxable" => true, "barcode" => "1234_pink", "fulfillment_service" => "manual", "grams" => 567, "inventory_management" => "shopify", "requires_shipping" => true, "sku" => "IPOD2008PINK", "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => {"amount" => "249.00", "currency_code" => "USD"}}, {"price" => {"amount" => "249.00", "currency_code" => "CAD"}, "compare_at_price" => {"amount" => "312.00", "currency_code" => "CAD"}}], "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810", "image_id" => 562641783}]}), headers: {})

    response = ShopifyAPI::Variant.all(
      product_id: 632910392,
      presentment_currencies: "USD,CAD",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2025-10/products/632910392/variants.json?presentment_currencies=USD%2CCAD")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2025-10/products/632910392/variants.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "variant" => hash_including({"option1" => "Yellow", "price" => "1.00"}) }
      )
      .to_return(status: 200, body: JSON.generate({"variant" => {"id" => 1070325042, "product_id" => 632910392, "title" => "Yellow", "price" => "1.00", "position" => 5, "inventory_policy" => "deny", "compare_at_price" => nil, "option1" => "Yellow", "option2" => nil, "option3" => nil, "created_at" => "2025-10-02T11:39:09-05:00", "updated_at" => "2025-10-02T11:39:10-05:00", "taxable" => true, "barcode" => nil, "fulfillment_service" => "manual", "grams" => 0, "inventory_management" => "shopify", "requires_shipping" => true, "sku" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325042, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "1.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325042", "image_id" => nil}}), headers: {})

    response = variant = ShopifyAPI::Variant.new
    variant.product_id = 632910392
    variant.option1 = "Yellow"
    variant.price = "1.00"
    variant.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2025-10/products/632910392/variants.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2025-10/products/632910392/variants.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "variant" => hash_including({"option1" => "Blue", "metafields" => [{"key" => "new", "value" => "newvalue", "type" => "single_line_text_field", "namespace" => "global"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"variant" => {"id" => 1070325039, "product_id" => 632910392, "title" => "Blue", "price" => "0.00", "position" => 5, "inventory_policy" => "deny", "compare_at_price" => nil, "option1" => "Blue", "option2" => nil, "option3" => nil, "created_at" => "2025-10-02T11:39:01-05:00", "updated_at" => "2025-10-02T11:39:01-05:00", "taxable" => true, "barcode" => nil, "fulfillment_service" => "manual", "grams" => 0, "inventory_management" => "shopify", "requires_shipping" => true, "sku" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325039, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "0.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325039", "image_id" => nil}}), headers: {})

    response = variant = ShopifyAPI::Variant.new
    variant.product_id = 632910392
    variant.option1 = "Blue"
    variant.metafields = [
      {
        "key" => "new",
        "value" => "newvalue",
        "type" => "single_line_text_field",
        "namespace" => "global"
      }
    ]
    variant.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2025-10/products/632910392/variants.json")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2025-10/products/632910392/variants.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "variant" => hash_including({"image_id" => 850703190, "option1" => "Purple"}) }
      )
      .to_return(status: 200, body: JSON.generate({"variant" => {"id" => 1070325040, "product_id" => 632910392, "title" => "Purple", "price" => "0.00", "position" => 5, "inventory_policy" => "deny", "compare_at_price" => nil, "option1" => "Purple", "option2" => nil, "option3" => nil, "created_at" => "2025-10-02T11:39:02-05:00", "updated_at" => "2025-10-02T11:39:02-05:00", "taxable" => true, "barcode" => nil, "fulfillment_service" => "manual", "grams" => 0, "inventory_management" => "shopify", "requires_shipping" => true, "sku" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325040, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "0.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325040", "image_id" => 850703190}}), headers: {})

    response = variant = ShopifyAPI::Variant.new
    variant.product_id = 632910392
    variant.image_id = 850703190
    variant.option1 = "Purple"
    variant.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2025-10/products/632910392/variants.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2025-10/products/632910392/variants/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 4}), headers: {})

    response = ShopifyAPI::Variant.count(
      product_id: 632910392,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2025-10/products/632910392/variants/count.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2025-10/variants/808950810.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"variant" => {"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2025-10-02T11:38:15-05:00", "updated_at" => "2025-10-02T11:38:15-05:00", "taxable" => true, "barcode" => "1234_pink", "fulfillment_service" => "manual", "grams" => 567, "inventory_management" => "shopify", "requires_shipping" => true, "sku" => "IPOD2008PINK", "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810", "image_id" => 562641783}}), headers: {})

    response = ShopifyAPI::Variant.find(
      id: 808950810,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2025-10/variants/808950810.json")

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
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2025-10/variants/808950810.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "variant" => hash_including({"metafields" => [{"key" => "new", "value" => "newvalue", "type" => "single_line_text_field", "namespace" => "global"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"variant" => {"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2025-10-02T11:38:15-05:00", "updated_at" => "2025-10-02T11:38:15-05:00", "taxable" => true, "barcode" => "1234_pink", "fulfillment_service" => "manual", "grams" => 567, "inventory_management" => "shopify", "requires_shipping" => true, "sku" => "IPOD2008PINK", "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810", "image_id" => 562641783}}), headers: {})

    response = variant = ShopifyAPI::Variant.new
    variant.id = 808950810
    variant.metafields = [
      {
        "key" => "new",
        "value" => "newvalue",
        "type" => "single_line_text_field",
        "namespace" => "global"
      }
    ]
    variant.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2025-10/variants/808950810.json")

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
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2025-10/variants/808950810.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "variant" => hash_including({"image_id" => 562641783}) }
      )
      .to_return(status: 200, body: JSON.generate({"variant" => {"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2025-10-02T11:38:15-05:00", "updated_at" => "2025-10-02T11:39:08-05:00", "taxable" => true, "barcode" => "1234_pink", "fulfillment_service" => "manual", "grams" => 567, "inventory_management" => "shopify", "requires_shipping" => true, "sku" => "IPOD2008PINK", "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810", "image_id" => 562641783}}), headers: {})

    response = variant = ShopifyAPI::Variant.new
    variant.id = 808950810
    variant.image_id = 562641783
    variant.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2025-10/variants/808950810.json")

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
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2025-10/variants/808950810.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "variant" => hash_including({"option1" => "Not Pink", "price" => "99.00"}) }
      )
      .to_return(status: 200, body: JSON.generate({"variant" => {"id" => 808950810, "product_id" => 632910392, "title" => "Not Pink", "price" => "99.00", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "option1" => "Not Pink", "option2" => nil, "option3" => nil, "created_at" => "2025-10-02T11:38:15-05:00", "updated_at" => "2025-10-02T11:39:07-05:00", "taxable" => true, "barcode" => "1234_pink", "fulfillment_service" => "manual", "grams" => 567, "inventory_management" => "shopify", "requires_shipping" => true, "sku" => "IPOD2008PINK", "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "99.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810", "image_id" => 562641783}}), headers: {})

    response = variant = ShopifyAPI::Variant.new
    variant.id = 808950810
    variant.option1 = "Not Pink"
    variant.price = "99.00"
    variant.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2025-10/variants/808950810.json")

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
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2025-10/products/632910392/variants/808950810.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    response = ShopifyAPI::Variant.delete(
      product_id: 632910392,
      id: 808950810,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2025-10/products/632910392/variants/808950810.json")

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
