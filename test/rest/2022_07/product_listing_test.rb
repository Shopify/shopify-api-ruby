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

class ProductListing202207Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/product_listings.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"product_listings" => [{"product_id" => 632910392, "created_at" => "2023-07-05T18:38:03-04:00", "updated_at" => "2023-07-05T18:38:03-04:00", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "handle" => "ipod-nano", "product_type" => "Cult Products", "title" => "IPod Nano - 8GB", "vendor" => "Apple", "available" => true, "tags" => "Emotive, Flash Memory, MP3, Music", "published_at" => "2017-08-31T20:00:00-04:00", "variants" => [{"id" => 808950810, "title" => "Pink", "option_values" => [{"option_id" => 594680422, "name" => "Color", "value" => "Pink"}], "price" => "199.00", "formatted_price" => "$199.00", "compare_at_price" => nil, "grams" => 567, "requires_shipping" => true, "sku" => "IPOD2008PINK", "barcode" => "1234_pink", "taxable" => true, "position" => 1, "available" => true, "inventory_policy" => "continue", "inventory_quantity" => 10, "inventory_management" => "shopify", "fulfillment_service" => "manual", "weight" => 1.25, "weight_unit" => "lb", "image_id" => 562641783, "created_at" => "2023-07-05T18:38:03-04:00", "updated_at" => "2023-07-05T18:38:03-04:00"}, {"id" => 49148385, "title" => "Red", "option_values" => [{"option_id" => 594680422, "name" => "Color", "value" => "Red"}], "price" => "199.00", "formatted_price" => "$199.00", "compare_at_price" => nil, "grams" => 567, "requires_shipping" => true, "sku" => "IPOD2008RED", "barcode" => "1234_red", "taxable" => true, "position" => 2, "available" => true, "inventory_policy" => "continue", "inventory_quantity" => 20, "inventory_management" => "shopify", "fulfillment_service" => "manual", "weight" => 1.25, "weight_unit" => "lb", "image_id" => nil, "created_at" => "2023-07-05T18:38:03-04:00", "updated_at" => "2023-07-05T18:38:03-04:00"}, {"id" => 39072856, "title" => "Green", "option_values" => [{"option_id" => 594680422, "name" => "Color", "value" => "Green"}], "price" => "199.00", "formatted_price" => "$199.00", "compare_at_price" => nil, "grams" => 567, "requires_shipping" => true, "sku" => "IPOD2008GREEN", "barcode" => "1234_green", "taxable" => true, "position" => 3, "available" => true, "inventory_policy" => "continue", "inventory_quantity" => 30, "inventory_management" => "shopify", "fulfillment_service" => "manual", "weight" => 1.25, "weight_unit" => "lb", "image_id" => nil, "created_at" => "2023-07-05T18:38:03-04:00", "updated_at" => "2023-07-05T18:38:03-04:00"}, {"id" => 457924702, "title" => "Black", "option_values" => [{"option_id" => 594680422, "name" => "Color", "value" => "Black"}], "price" => "199.00", "formatted_price" => "$199.00", "compare_at_price" => nil, "grams" => 567, "requires_shipping" => true, "sku" => "IPOD2008BLACK", "barcode" => "1234_black", "taxable" => true, "position" => 4, "available" => true, "inventory_policy" => "continue", "inventory_quantity" => 40, "inventory_management" => "shopify", "fulfillment_service" => "manual", "weight" => 1.25, "weight_unit" => "lb", "image_id" => nil, "created_at" => "2023-07-05T18:38:03-04:00", "updated_at" => "2023-07-05T18:38:03-04:00"}], "images" => [{"id" => 850703190, "created_at" => "2023-07-05T18:38:03-04:00", "position" => 1, "updated_at" => "2023-07-05T18:38:03-04:00", "product_id" => 632910392, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1688596683", "variant_ids" => [], "width" => 123, "height" => 456}, {"id" => 562641783, "created_at" => "2023-07-05T18:38:03-04:00", "position" => 2, "updated_at" => "2023-07-05T18:38:03-04:00", "product_id" => 632910392, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1688596683", "variant_ids" => [808950810], "width" => 123, "height" => 456}, {"id" => 378407906, "created_at" => "2023-07-05T18:38:03-04:00", "position" => 3, "updated_at" => "2023-07-05T18:38:03-04:00", "product_id" => 632910392, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1688596683", "variant_ids" => [], "width" => 123, "height" => 456}], "options" => [{"id" => 594680422, "name" => "Color", "product_id" => 632910392, "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}]}, {"product_id" => 921728736, "created_at" => "2023-07-05T18:38:03-04:00", "updated_at" => "2023-07-05T18:38:03-04:00", "body_html" => "<p>The iPod Touch has the iPhone's multi-touch interface, with a physical home button off the touch screen. The home screen has a list of buttons for the available applications.</p>", "handle" => "ipod-touch", "product_type" => "Cult Products", "title" => "IPod Touch 8GB", "vendor" => "Apple", "available" => true, "tags" => "", "published_at" => "2017-08-31T20:00:00-04:00", "variants" => [{"id" => 447654529, "title" => "Black", "option_values" => [{"option_id" => 891236591, "name" => "Title", "value" => "Black"}], "price" => "199.00", "formatted_price" => "$199.00", "compare_at_price" => nil, "grams" => 567, "requires_shipping" => true, "sku" => "IPOD2009BLACK", "barcode" => "1234_black", "taxable" => true, "position" => 1, "available" => true, "inventory_policy" => "continue", "inventory_quantity" => 13, "inventory_management" => "shipwire-app", "fulfillment_service" => "shipwire-app", "weight" => 1.25, "weight_unit" => "lb", "image_id" => nil, "created_at" => "2023-07-05T18:38:03-04:00", "updated_at" => "2023-07-05T18:38:03-04:00"}], "images" => [], "options" => [{"id" => 891236591, "name" => "Title", "product_id" => 921728736, "position" => 1, "values" => ["Black"]}]}]}), headers: {})

    response = ShopifyAPI::ProductListing.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/product_listings.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/product_listings/product_ids.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"product_ids" => [921728736, 632910392]}), headers: {})

    response = ShopifyAPI::ProductListing.product_ids

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/product_listings/product_ids.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/product_listings/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 2}), headers: {})

    response = ShopifyAPI::ProductListing.count

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/product_listings/count.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/product_listings/921728736.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"product_listing" => {"product_id" => 921728736, "created_at" => "2023-07-05T18:38:03-04:00", "updated_at" => "2023-07-05T18:38:03-04:00", "body_html" => "<p>The iPod Touch has the iPhone's multi-touch interface, with a physical home button off the touch screen. The home screen has a list of buttons for the available applications.</p>", "handle" => "ipod-touch", "product_type" => "Cult Products", "title" => "IPod Touch 8GB", "vendor" => "Apple", "available" => true, "tags" => "", "published_at" => "2017-08-31T20:00:00-04:00", "variants" => [{"id" => 447654529, "title" => "Black", "option_values" => [{"option_id" => 891236591, "name" => "Title", "value" => "Black"}], "price" => "199.00", "formatted_price" => "$199.00", "compare_at_price" => nil, "grams" => 567, "requires_shipping" => true, "sku" => "IPOD2009BLACK", "barcode" => "1234_black", "taxable" => true, "position" => 1, "available" => true, "inventory_policy" => "continue", "inventory_quantity" => 13, "inventory_management" => "shipwire-app", "fulfillment_service" => "shipwire-app", "weight" => 1.25, "weight_unit" => "lb", "image_id" => nil, "created_at" => "2023-07-05T18:38:03-04:00", "updated_at" => "2023-07-05T18:38:03-04:00"}], "images" => [], "options" => [{"id" => 891236591, "name" => "Title", "product_id" => 921728736, "position" => 1, "values" => ["Black"]}]}}), headers: {})

    response = ShopifyAPI::ProductListing.find(
      product_id: 921728736,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/product_listings/921728736.json")

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
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-07/product_listings/921728736.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product_listing" => hash_including({}) }
      )
      .to_return(status: 200, body: JSON.generate({"product_listing" => {"product_id" => 921728736, "created_at" => "2023-07-05T18:38:03-04:00", "updated_at" => "2023-07-05T18:38:03-04:00", "body_html" => "<p>The iPod Touch has the iPhone's multi-touch interface, with a physical home button off the touch screen. The home screen has a list of buttons for the available applications.</p>", "handle" => "ipod-touch", "product_type" => "Cult Products", "title" => "IPod Touch 8GB", "vendor" => "Apple", "available" => true, "tags" => "", "published_at" => "2017-08-31T20:00:00-04:00", "variants" => [{"id" => 447654529, "title" => "Black", "option_values" => [{"option_id" => 891236591, "name" => "Title", "value" => "Black"}], "price" => "199.00", "formatted_price" => "$199.00", "compare_at_price" => nil, "grams" => 567, "requires_shipping" => true, "sku" => "IPOD2009BLACK", "barcode" => "1234_black", "taxable" => true, "position" => 1, "available" => true, "inventory_policy" => "continue", "inventory_quantity" => 13, "inventory_management" => "shipwire-app", "fulfillment_service" => "shipwire-app", "weight" => 1.25, "weight_unit" => "lb", "image_id" => nil, "created_at" => "2023-07-05T18:38:03-04:00", "updated_at" => "2023-07-05T18:38:03-04:00"}], "images" => [], "options" => [{"id" => 891236591, "name" => "Title", "product_id" => 921728736, "position" => 1, "values" => ["Black"]}]}}), headers: {})

    response = product_listing = ShopifyAPI::ProductListing.new
    product_listing.product_id = 921728736
    product_listing.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-07/product_listings/921728736.json")

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
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-07/product_listings/921728736.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    response = ShopifyAPI::ProductListing.delete(
      product_id: 921728736,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-07/product_listings/921728736.json")

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
