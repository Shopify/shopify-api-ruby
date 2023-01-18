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

class Product202210Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-10")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products.json?ids=632910392%2C921728736")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"products" => [{"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-01-03T12:56:35-05:00", "handle" => "ipod-nano", "updated_at" => "2023-01-03T12:56:35-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1672768595", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}, {"id" => 921728736, "title" => "IPod Touch 8GB", "body_html" => "<p>The iPod Touch has the iPhone's multi-touch interface, with a physical home button off the touch screen. The home screen has a list of buttons for the available applications.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-01-03T12:56:35-05:00", "handle" => "ipod-touch", "updated_at" => "2023-01-03T12:56:35-05:00", "published_at" => "2008-09-25T20:00:00-04:00", "template_suffix" => nil, "published_scope" => "web", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/921728736", "variants" => [{"id" => 447654529, "product_id" => 921728736, "title" => "Black", "price" => "199.00", "sku" => "IPOD2009BLACK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "shipwire-app", "inventory_management" => "shipwire-app", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 447654529, "inventory_quantity" => 13, "old_inventory_quantity" => 13, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/447654529"}], "options" => [{"id" => 891236591, "product_id" => 921728736, "name" => "Title", "position" => 1, "values" => ["Black"]}], "images" => [], "image" => nil}]}), headers: {})

    ShopifyAPI::Product.all(
      ids: "632910392,921728736",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products.json?ids=632910392%2C921728736")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"products" => [{"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-01-03T12:56:35-05:00", "handle" => "ipod-nano", "updated_at" => "2023-01-03T12:56:35-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1672768595", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}, {"id" => 921728736, "title" => "IPod Touch 8GB", "body_html" => "<p>The iPod Touch has the iPhone's multi-touch interface, with a physical home button off the touch screen. The home screen has a list of buttons for the available applications.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-01-03T12:56:35-05:00", "handle" => "ipod-touch", "updated_at" => "2023-01-03T12:56:35-05:00", "published_at" => "2008-09-25T20:00:00-04:00", "template_suffix" => nil, "published_scope" => "web", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/921728736", "variants" => [{"id" => 447654529, "product_id" => 921728736, "title" => "Black", "price" => "199.00", "sku" => "IPOD2009BLACK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "shipwire-app", "inventory_management" => "shipwire-app", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 447654529, "inventory_quantity" => 13, "old_inventory_quantity" => 13, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/447654529"}], "options" => [{"id" => 891236591, "product_id" => 921728736, "name" => "Title", "position" => 1, "values" => ["Black"]}], "images" => [], "image" => nil}]}), headers: {})

    ShopifyAPI::Product.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products.json?since_id=632910392")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"products" => [{"id" => 921728736, "title" => "IPod Touch 8GB", "body_html" => "<p>The iPod Touch has the iPhone's multi-touch interface, with a physical home button off the touch screen. The home screen has a list of buttons for the available applications.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-01-03T12:56:35-05:00", "handle" => "ipod-touch", "updated_at" => "2023-01-03T12:56:35-05:00", "published_at" => "2008-09-25T20:00:00-04:00", "template_suffix" => nil, "published_scope" => "web", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/921728736", "variants" => [{"id" => 447654529, "product_id" => 921728736, "title" => "Black", "price" => "199.00", "sku" => "IPOD2009BLACK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "shipwire-app", "inventory_management" => "shipwire-app", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 447654529, "inventory_quantity" => 13, "old_inventory_quantity" => 13, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/447654529"}], "options" => [{"id" => 891236591, "product_id" => 921728736, "name" => "Title", "position" => 1, "values" => ["Black"]}], "images" => [], "image" => nil}]}), headers: {})

    ShopifyAPI::Product.all(
      since_id: "632910392",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products.json?since_id=632910392")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products.json?collection_id=841564295")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"products" => [{"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-01-03T12:56:35-05:00", "handle" => "ipod-nano", "updated_at" => "2023-01-03T12:56:35-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1672768595", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}]}), headers: {})

    ShopifyAPI::Product.all(
      collection_id: "841564295",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products.json?collection_id=841564295")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products.json?presentment_currencies=USD")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"products" => [{"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-01-03T12:56:35-05:00", "handle" => "ipod-nano", "updated_at" => "2023-01-03T12:56:35-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1672768595", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}, {"id" => 921728736, "title" => "IPod Touch 8GB", "body_html" => "<p>The iPod Touch has the iPhone's multi-touch interface, with a physical home button off the touch screen. The home screen has a list of buttons for the available applications.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-01-03T12:56:35-05:00", "handle" => "ipod-touch", "updated_at" => "2023-01-03T12:56:35-05:00", "published_at" => "2008-09-25T20:00:00-04:00", "template_suffix" => nil, "published_scope" => "web", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/921728736", "variants" => [{"id" => 447654529, "product_id" => 921728736, "title" => "Black", "price" => "199.00", "sku" => "IPOD2009BLACK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "shipwire-app", "inventory_management" => "shipwire-app", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 447654529, "inventory_quantity" => 13, "old_inventory_quantity" => 13, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/447654529"}], "options" => [{"id" => 891236591, "product_id" => 921728736, "name" => "Title", "position" => 1, "values" => ["Black"]}], "images" => [], "image" => nil}]}), headers: {})

    ShopifyAPI::Product.all(
      presentment_currencies: "USD",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products.json?presentment_currencies=USD")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products.json?fields=id%2Cimages%2Ctitle")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"products" => [{"id" => 632910392, "title" => "IPod Nano - 8GB", "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1672768595", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}]}, {"id" => 921728736, "title" => "IPod Touch 8GB", "images" => []}]}), headers: {})

    ShopifyAPI::Product.all(
      fields: "id,images,title",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products.json?fields=id%2Cimages%2Ctitle")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 2}), headers: {})

    ShopifyAPI::Product.count

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products/count.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products/count.json?collection_id=841564295")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    ShopifyAPI::Product.count(
      collection_id: "841564295",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products/count.json?collection_id=841564295")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-01-03T12:56:35-05:00", "handle" => "ipod-nano", "updated_at" => "2023-01-03T12:56:35-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1672768595", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

    ShopifyAPI::Product.find(
      id: 632910392,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json?fields=id%2Cimages%2Ctitle")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1672768595", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}]}}), headers: {})

    ShopifyAPI::Product.find(
      id: 632910392,
      fields: "id,images,title",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json?fields=id%2Cimages%2Ctitle")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"metafields" => [{"key" => "new", "value" => "newvalue", "type" => "single_line_text_field", "namespace" => "global"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-01-03T12:56:35-05:00", "handle" => "ipod-nano", "updated_at" => "2023-01-03T12:59:19-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1672768595", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

    product = ShopifyAPI::Product.new
    product.id = 632910392
    product.metafields = [
      {
        "key" => "new",
        "value" => "newvalue",
        "type" => "single_line_text_field",
        "namespace" => "global"
      }
    ]
    product.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
  end

  sig do
    void
  end
  def test_12()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"published" => false}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-01-03T12:56:35-05:00", "handle" => "ipod-nano", "updated_at" => "2023-01-03T13:00:07-05:00", "published_at" => nil, "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1672768595", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

    product = ShopifyAPI::Product.new
    product.id = 632910392
    product.published = false
    product.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
  end

  sig do
    void
  end
  def test_13()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"published" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-01-03T12:56:35-05:00", "handle" => "ipod-nano", "updated_at" => "2023-01-03T12:59:25-05:00", "published_at" => "2023-01-03T12:59:24-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1672768595", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

    product = ShopifyAPI::Product.new
    product.id = 632910392
    product.published = true
    product.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
  end

  sig do
    void
  end
  def test_14()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"title" => "Updated Product Title", "variants" => [{"id" => 808950810, "price" => "2000.00", "sku" => "Updating the Product SKU"}, {"id" => 49148385}, {"id" => 39072856}, {"id" => 457924702}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "Updated Product Title", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-01-03T12:56:35-05:00", "handle" => "ipod-nano", "updated_at" => "2023-01-03T13:00:21-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "2000.00", "sku" => "Updating the Product SKU", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T13:00:20-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1672768595", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

    product = ShopifyAPI::Product.new
    product.id = 632910392
    product.title = "Updated Product Title"
    product.variants = [
      {
        "id" => 808950810,
        "price" => "2000.00",
        "sku" => "Updating the Product SKU"
      },
      {
        "id" => 49148385
      },
      {
        "id" => 39072856
      },
      {
        "id" => 457924702
      }
    ]
    product.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
  end

  sig do
    void
  end
  def test_15()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"images" => [{"id" => 850703190}, {"id" => 562641783}, {"id" => 378407906}, {"src" => "http://example.com/rails_logo.gif"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-01-03T12:56:35-05:00", "handle" => "ipod-nano", "updated_at" => "2023-01-03T13:02:22-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1672768595", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}, {"id" => 1001473910, "product_id" => 632910392, "position" => 4, "created_at" => "2023-01-03T13:02:22-05:00", "updated_at" => "2023-01-03T13:02:22-05:00", "alt" => nil, "width" => 110, "height" => 140, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/rails_logo20230103-54493-3uie15.gif?v=1672768942", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/1001473910"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

    product = ShopifyAPI::Product.new
    product.id = 632910392
    product.images = [
      {
        "id" => 850703190
      },
      {
        "id" => 562641783
      },
      {
        "id" => 378407906
      },
      {
        "src" => "http://example.com/rails_logo.gif"
      }
    ]
    product.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
  end

  sig do
    void
  end
  def test_16()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"images" => []}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-01-03T12:56:35-05:00", "handle" => "ipod-nano", "updated_at" => "2023-01-03T12:59:57-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:59:57-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [], "image" => nil}}), headers: {})

    product = ShopifyAPI::Product.new
    product.id = 632910392
    product.images = []
    product.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
  end

  sig do
    void
  end
  def test_17()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"images" => [{"id" => 850703190, "position" => 3}, {"id" => 562641783, "position" => 2}, {"id" => 378407906, "position" => 1}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-01-03T12:56:35-05:00", "handle" => "ipod-nano", "updated_at" => "2023-01-03T13:01:34-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 378407906, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T13:01:34-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768894", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1672768595", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 850703190, "product_id" => 632910392, "position" => 3, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T13:01:34-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768894", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}], "image" => {"id" => 378407906, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T13:01:34-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768894", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}}}), headers: {})

    product = ShopifyAPI::Product.new
    product.id = 632910392
    product.images = [
      {
        "id" => 850703190,
        "position" => 3
      },
      {
        "id" => 562641783,
        "position" => 2
      },
      {
        "id" => 378407906,
        "position" => 1
      }
    ]
    product.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
  end

  sig do
    void
  end
  def test_18()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"variants" => [{"id" => 457924702}, {"id" => 39072856}, {"id" => 49148385}, {"id" => 808950810}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-01-03T12:56:35-05:00", "handle" => "ipod-nano", "updated_at" => "2023-01-03T13:02:16-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T13:02:16-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T13:02:16-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T13:02:16-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T13:02:16-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Black", "Green", "Red", "Pink"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1672768595", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

    product = ShopifyAPI::Product.new
    product.id = 632910392
    product.variants = [
      {
        "id" => 457924702
      },
      {
        "id" => 39072856
      },
      {
        "id" => 49148385
      },
      {
        "id" => 808950810
      }
    ]
    product.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
  end

  sig do
    void
  end
  def test_19()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"metafields_global_title_tag" => "Brand new title", "metafields_global_description_tag" => "Brand new description"}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-01-03T12:56:35-05:00", "handle" => "ipod-nano", "updated_at" => "2023-01-03T12:56:35-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1672768595", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

    product = ShopifyAPI::Product.new
    product.id = 632910392
    product.metafields_global_title_tag = "Brand new title"
    product.metafields_global_description_tag = "Brand new description"
    product.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
  end

  sig do
    void
  end
  def test_20()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"status" => "draft"}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-01-03T12:56:35-05:00", "handle" => "ipod-nano", "updated_at" => "2023-01-03T13:00:11-05:00", "published_at" => nil, "template_suffix" => nil, "status" => "draft", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1672768595", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

    product = ShopifyAPI::Product.new
    product.id = 632910392
    product.status = "draft"
    product.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
  end

  sig do
    void
  end
  def test_21()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"tags" => "Barnes & Noble, John's Fav"}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-01-03T12:56:35-05:00", "handle" => "ipod-nano", "updated_at" => "2023-01-03T13:00:46-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Barnes & Noble, John's Fav", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1672768595", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

    product = ShopifyAPI::Product.new
    product.id = 632910392
    product.tags = "Barnes & Noble, John's Fav"
    product.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
  end

  sig do
    void
  end
  def test_22()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"title" => "New product title"}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "New product title", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-01-03T12:56:35-05:00", "handle" => "ipod-nano", "updated_at" => "2023-01-03T13:01:10-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1672768595", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-01-03T12:56:35-05:00", "updated_at" => "2023-01-03T12:56:35-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1672768595", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

    product = ShopifyAPI::Product.new
    product.id = 632910392
    product.title = "New product title"
    product.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
  end

  sig do
    void
  end
  def test_23()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Product.delete(
      id: 632910392,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392.json")
  end

  sig do
    void
  end
  def test_24()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/products.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "status" => "draft"}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 1071559595, "title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "created_at" => "2023-01-03T13:02:18-05:00", "handle" => "burton-custom-freestyle-151", "updated_at" => "2023-01-03T13:02:18-05:00", "published_at" => nil, "template_suffix" => nil, "status" => "draft", "published_scope" => "web", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/1071559595", "variants" => [{"id" => 1070325052, "product_id" => 1071559595, "title" => "Default Title", "price" => "0.00", "sku" => "", "position" => 1, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "Default Title", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T13:02:18-05:00", "updated_at" => "2023-01-03T13:02:18-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325052, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "0.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325052"}], "options" => [{"id" => 1055547207, "product_id" => 1071559595, "name" => "Title", "position" => 1, "values" => ["Default Title"]}], "images" => [], "image" => nil}}), headers: {})

    product = ShopifyAPI::Product.new
    product.title = "Burton Custom Freestyle 151"
    product.body_html = "<strong>Good snowboard!</strong>"
    product.vendor = "Burton"
    product.product_type = "Snowboard"
    product.status = "draft"
    product.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/products.json")
  end

  sig do
    void
  end
  def test_25()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/products.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "variants" => [{"option1" => "First", "price" => "10.00", "sku" => "123"}, {"option1" => "Second", "price" => "20.00", "sku" => "123"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 1071559585, "title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "created_at" => "2023-01-03T13:00:56-05:00", "handle" => "burton-custom-freestyle-151", "updated_at" => "2023-01-03T13:00:56-05:00", "published_at" => "2023-01-03T13:00:56-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "global", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/1071559585", "variants" => [{"id" => 1070325040, "product_id" => 1071559585, "title" => "First", "price" => "10.00", "sku" => "123", "position" => 1, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "First", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T13:00:56-05:00", "updated_at" => "2023-01-03T13:00:56-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325040, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "10.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325040"}, {"id" => 1070325041, "product_id" => 1071559585, "title" => "Second", "price" => "20.00", "sku" => "123", "position" => 2, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "Second", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T13:00:56-05:00", "updated_at" => "2023-01-03T13:00:56-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325041, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "20.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325041"}], "options" => [{"id" => 1055547196, "product_id" => 1071559585, "name" => "Title", "position" => 1, "values" => ["First", "Second"]}], "images" => [], "image" => nil}}), headers: {})

    product = ShopifyAPI::Product.new
    product.title = "Burton Custom Freestyle 151"
    product.body_html = "<strong>Good snowboard!</strong>"
    product.vendor = "Burton"
    product.product_type = "Snowboard"
    product.variants = [
      {
        "option1" => "First",
        "price" => "10.00",
        "sku" => "123"
      },
      {
        "option1" => "Second",
        "price" => "20.00",
        "sku" => "123"
      }
    ]
    product.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/products.json")
  end

  sig do
    void
  end
  def test_26()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/products.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "variants" => [{"option1" => "Blue", "option2" => "155"}, {"option1" => "Black", "option2" => "159"}], "options" => [{"name" => "Color", "values" => ["Blue", "Black"]}, {"name" => "Size", "values" => ["155", "159"]}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 1071559582, "title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "created_at" => "2023-01-03T13:00:15-05:00", "handle" => "burton-custom-freestyle-151", "updated_at" => "2023-01-03T13:00:15-05:00", "published_at" => "2023-01-03T13:00:15-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "global", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/1071559582", "variants" => [{"id" => 1070325035, "product_id" => 1071559582, "title" => "Blue / 155", "price" => "0.00", "sku" => "", "position" => 1, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "Blue", "option2" => "155", "option3" => nil, "created_at" => "2023-01-03T13:00:15-05:00", "updated_at" => "2023-01-03T13:00:15-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325035, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "0.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325035"}, {"id" => 1070325036, "product_id" => 1071559582, "title" => "Black / 159", "price" => "0.00", "sku" => "", "position" => 2, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "Black", "option2" => "159", "option3" => nil, "created_at" => "2023-01-03T13:00:15-05:00", "updated_at" => "2023-01-03T13:00:15-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325036, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "0.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325036"}], "options" => [{"id" => 1055547192, "product_id" => 1071559582, "name" => "Color", "position" => 1, "values" => ["Blue", "Black"]}, {"id" => 1055547193, "product_id" => 1071559582, "name" => "Size", "position" => 2, "values" => ["155", "159"]}], "images" => [], "image" => nil}}), headers: {})

    product = ShopifyAPI::Product.new
    product.title = "Burton Custom Freestyle 151"
    product.body_html = "<strong>Good snowboard!</strong>"
    product.vendor = "Burton"
    product.product_type = "Snowboard"
    product.variants = [
      {
        "option1" => "Blue",
        "option2" => "155"
      },
      {
        "option1" => "Black",
        "option2" => "159"
      }
    ]
    product.options = [
      {
        "name" => "Color",
        "values" => [
          "Blue",
          "Black"
        ]
      },
      {
        "name" => "Size",
        "values" => [
          "155",
          "159"
        ]
      }
    ]
    product.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/products.json")
  end

  sig do
    void
  end
  def test_27()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/products.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "tags" => ["Barnes & Noble", "Big Air", "John's Fav"]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 1071559586, "title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "created_at" => "2023-01-03T13:01:04-05:00", "handle" => "burton-custom-freestyle-151", "updated_at" => "2023-01-03T13:01:04-05:00", "published_at" => "2023-01-03T13:01:04-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "global", "tags" => "Barnes & Noble, Big Air, John's Fav", "admin_graphql_api_id" => "gid://shopify/Product/1071559586", "variants" => [{"id" => 1070325042, "product_id" => 1071559586, "title" => "Default Title", "price" => "0.00", "sku" => "", "position" => 1, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "Default Title", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T13:01:04-05:00", "updated_at" => "2023-01-03T13:01:04-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325042, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "0.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325042"}], "options" => [{"id" => 1055547197, "product_id" => 1071559586, "name" => "Title", "position" => 1, "values" => ["Default Title"]}], "images" => [], "image" => nil}}), headers: {})

    product = ShopifyAPI::Product.new
    product.title = "Burton Custom Freestyle 151"
    product.body_html = "<strong>Good snowboard!</strong>"
    product.vendor = "Burton"
    product.product_type = "Snowboard"
    product.tags = [
      "Barnes & Noble",
      "Big Air",
      "John's Fav"
    ]
    product.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/products.json")
  end

  sig do
    void
  end
  def test_28()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/products.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "images" => [{"src" => "http://example.com/rails_logo.gif"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 1071559578, "title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "created_at" => "2023-01-03T12:59:53-05:00", "handle" => "burton-custom-freestyle-151", "updated_at" => "2023-01-03T12:59:53-05:00", "published_at" => "2023-01-03T12:59:53-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "global", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/1071559578", "variants" => [{"id" => 1070325031, "product_id" => 1071559578, "title" => "Default Title", "price" => "0.00", "sku" => "", "position" => 1, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "Default Title", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:59:53-05:00", "updated_at" => "2023-01-03T12:59:53-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325031, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "0.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325031"}], "options" => [{"id" => 1055547186, "product_id" => 1071559578, "name" => "Title", "position" => 1, "values" => ["Default Title"]}], "images" => [{"id" => 1001473906, "product_id" => 1071559578, "position" => 1, "created_at" => "2023-01-03T12:59:53-05:00", "updated_at" => "2023-01-03T12:59:53-05:00", "alt" => nil, "width" => 110, "height" => 140, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/rails_logo20230103-54493-j94qo6.gif?v=1672768793", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/1001473906"}], "image" => {"id" => 1001473906, "product_id" => 1071559578, "position" => 1, "created_at" => "2023-01-03T12:59:53-05:00", "updated_at" => "2023-01-03T12:59:53-05:00", "alt" => nil, "width" => 110, "height" => 140, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/rails_logo20230103-54493-j94qo6.gif?v=1672768793", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/1001473906"}}}), headers: {})

    product = ShopifyAPI::Product.new
    product.title = "Burton Custom Freestyle 151"
    product.body_html = "<strong>Good snowboard!</strong>"
    product.vendor = "Burton"
    product.product_type = "Snowboard"
    product.images = [
      {
        "src" => "http://example.com/rails_logo.gif"
      }
    ]
    product.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/products.json")
  end

  sig do
    void
  end
  def test_29()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/products.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "images" => [{"attachment" => "R0lGODlhAQABAIAAAAAAAAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==\n"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 1071559583, "title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "created_at" => "2023-01-03T13:00:23-05:00", "handle" => "burton-custom-freestyle-151", "updated_at" => "2023-01-03T13:00:23-05:00", "published_at" => "2023-01-03T13:00:23-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "global", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/1071559583", "variants" => [{"id" => 1070325037, "product_id" => 1071559583, "title" => "Default Title", "price" => "0.00", "sku" => "", "position" => 1, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "Default Title", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T13:00:23-05:00", "updated_at" => "2023-01-03T13:00:23-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325037, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "0.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325037"}], "options" => [{"id" => 1055547194, "product_id" => 1071559583, "name" => "Title", "position" => 1, "values" => ["Default Title"]}], "images" => [{"id" => 1001473907, "product_id" => 1071559583, "position" => 1, "created_at" => "2023-01-03T13:00:23-05:00", "updated_at" => "2023-01-03T13:00:23-05:00", "alt" => nil, "width" => 1, "height" => 1, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/df3e567d6f16d040326c7a0ea29a4f41.gif?v=1672768823", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/1001473907"}], "image" => {"id" => 1001473907, "product_id" => 1071559583, "position" => 1, "created_at" => "2023-01-03T13:00:23-05:00", "updated_at" => "2023-01-03T13:00:23-05:00", "alt" => nil, "width" => 1, "height" => 1, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/df3e567d6f16d040326c7a0ea29a4f41.gif?v=1672768823", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/1001473907"}}}), headers: {})

    product = ShopifyAPI::Product.new
    product.title = "Burton Custom Freestyle 151"
    product.body_html = "<strong>Good snowboard!</strong>"
    product.vendor = "Burton"
    product.product_type = "Snowboard"
    product.images = [
      {
        "attachment" => "R0lGODlhAQABAIAAAAAAAAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==\n"
      }
    ]
    product.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/products.json")
  end

  sig do
    void
  end
  def test_30()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/products.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "published" => false}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 1071559581, "title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "created_at" => "2023-01-03T13:00:09-05:00", "handle" => "burton-custom-freestyle-151", "updated_at" => "2023-01-03T13:00:09-05:00", "published_at" => nil, "template_suffix" => nil, "status" => "active", "published_scope" => "global", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/1071559581", "variants" => [{"id" => 1070325034, "product_id" => 1071559581, "title" => "Default Title", "price" => "0.00", "sku" => "", "position" => 1, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "Default Title", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T13:00:09-05:00", "updated_at" => "2023-01-03T13:00:09-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325034, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "0.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325034"}], "options" => [{"id" => 1055547191, "product_id" => 1071559581, "name" => "Title", "position" => 1, "values" => ["Default Title"]}], "images" => [], "image" => nil}}), headers: {})

    product = ShopifyAPI::Product.new
    product.title = "Burton Custom Freestyle 151"
    product.body_html = "<strong>Good snowboard!</strong>"
    product.vendor = "Burton"
    product.product_type = "Snowboard"
    product.published = false
    product.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/products.json")
  end

  sig do
    void
  end
  def test_31()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/products.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "metafields" => [{"key" => "new", "value" => "newvalue", "type" => "single_line_text_field", "namespace" => "global"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 1071559576, "title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "created_at" => "2023-01-03T12:59:44-05:00", "handle" => "burton-custom-freestyle-151", "updated_at" => "2023-01-03T12:59:44-05:00", "published_at" => "2023-01-03T12:59:44-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "global", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/1071559576", "variants" => [{"id" => 1070325030, "product_id" => 1071559576, "title" => "Default Title", "price" => "0.00", "sku" => "", "position" => 1, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "Default Title", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T12:59:44-05:00", "updated_at" => "2023-01-03T12:59:44-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325030, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "0.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325030"}], "options" => [{"id" => 1055547183, "product_id" => 1071559576, "name" => "Title", "position" => 1, "values" => ["Default Title"]}], "images" => [], "image" => nil}}), headers: {})

    product = ShopifyAPI::Product.new
    product.title = "Burton Custom Freestyle 151"
    product.body_html = "<strong>Good snowboard!</strong>"
    product.vendor = "Burton"
    product.product_type = "Snowboard"
    product.metafields = [
      {
        "key" => "new",
        "value" => "newvalue",
        "type" => "single_line_text_field",
        "namespace" => "global"
      }
    ]
    product.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/products.json")
  end

  sig do
    void
  end
  def test_32()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-10/products.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "metafields_global_title_tag" => "Product SEO Title", "metafields_global_description_tag" => "Product SEO Description"}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 1071559584, "title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "created_at" => "2023-01-03T13:00:52-05:00", "handle" => "burton-custom-freestyle-151", "updated_at" => "2023-01-03T13:00:52-05:00", "published_at" => "2023-01-03T13:00:52-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "global", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/1071559584", "variants" => [{"id" => 1070325039, "product_id" => 1071559584, "title" => "Default Title", "price" => "0.00", "sku" => "", "position" => 1, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "Default Title", "option2" => nil, "option3" => nil, "created_at" => "2023-01-03T13:00:52-05:00", "updated_at" => "2023-01-03T13:00:52-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325039, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "0.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325039"}], "options" => [{"id" => 1055547195, "product_id" => 1071559584, "name" => "Title", "position" => 1, "values" => ["Default Title"]}], "images" => [], "image" => nil}}), headers: {})

    product = ShopifyAPI::Product.new
    product.title = "Burton Custom Freestyle 151"
    product.body_html = "<strong>Good snowboard!</strong>"
    product.vendor = "Burton"
    product.product_type = "Snowboard"
    product.metafields_global_title_tag = "Product SEO Title"
    product.metafields_global_description_tag = "Product SEO Description"
    product.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-10/products.json")
  end

end
