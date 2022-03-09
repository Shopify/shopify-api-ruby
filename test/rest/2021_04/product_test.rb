# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Product202104Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2021-04")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"products" => [{"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2022-02-03T17:14:40-05:00", "handle" => "ipod-nano", "updated_at" => "2022-02-03T17:14:40-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1643926480", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}, {"id" => 921728736, "title" => "IPod Touch 8GB", "body_html" => "<p>The iPod Touch has the iPhone's multi-touch interface, with a physical home button off the touch screen. The home screen has a list of buttons for the available applications.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2022-02-03T17:14:40-05:00", "handle" => "ipod-touch", "updated_at" => "2022-02-03T17:14:40-05:00", "published_at" => "2008-09-25T20:00:00-04:00", "template_suffix" => nil, "published_scope" => "web", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/921728736", "variants" => [{"id" => 447654529, "product_id" => 921728736, "title" => "Black", "price" => "199.00", "sku" => "IPOD2009BLACK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "shipwire-app", "inventory_management" => "shipwire-app", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 447654529, "inventory_quantity" => 13, "old_inventory_quantity" => 13, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/447654529"}], "options" => [{"id" => 891236591, "product_id" => 921728736, "name" => "Title", "position" => 1, "values" => ["Black"]}], "images" => [], "image" => nil}]}), headers: {})

    ShopifyAPI::Product.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products.json?ids=632910392%2C921728736")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"products" => [{"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2022-02-03T17:14:40-05:00", "handle" => "ipod-nano", "updated_at" => "2022-02-03T17:14:40-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1643926480", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}, {"id" => 921728736, "title" => "IPod Touch 8GB", "body_html" => "<p>The iPod Touch has the iPhone's multi-touch interface, with a physical home button off the touch screen. The home screen has a list of buttons for the available applications.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2022-02-03T17:14:40-05:00", "handle" => "ipod-touch", "updated_at" => "2022-02-03T17:14:40-05:00", "published_at" => "2008-09-25T20:00:00-04:00", "template_suffix" => nil, "published_scope" => "web", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/921728736", "variants" => [{"id" => 447654529, "product_id" => 921728736, "title" => "Black", "price" => "199.00", "sku" => "IPOD2009BLACK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "shipwire-app", "inventory_management" => "shipwire-app", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 447654529, "inventory_quantity" => 13, "old_inventory_quantity" => 13, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/447654529"}], "options" => [{"id" => 891236591, "product_id" => 921728736, "name" => "Title", "position" => 1, "values" => ["Black"]}], "images" => [], "image" => nil}]}), headers: {})

    ShopifyAPI::Product.all(
      ids: "632910392,921728736",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products.json?ids=632910392%2C921728736")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products.json?fields=id%2Cimages%2Ctitle")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"products" => [{"id" => 632910392, "title" => "IPod Nano - 8GB", "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1643926480", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}]}, {"id" => 921728736, "title" => "IPod Touch 8GB", "images" => []}]}), headers: {})

    ShopifyAPI::Product.all(
      fields: "id,images,title",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products.json?fields=id%2Cimages%2Ctitle")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products.json?collection_id=841564295")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"products" => [{"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2022-02-03T17:14:40-05:00", "handle" => "ipod-nano", "updated_at" => "2022-02-03T17:14:40-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1643926480", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}]}), headers: {})

    ShopifyAPI::Product.all(
      collection_id: "841564295",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products.json?collection_id=841564295")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products.json?since_id=632910392")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"products" => [{"id" => 921728736, "title" => "IPod Touch 8GB", "body_html" => "<p>The iPod Touch has the iPhone's multi-touch interface, with a physical home button off the touch screen. The home screen has a list of buttons for the available applications.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2022-02-03T17:14:40-05:00", "handle" => "ipod-touch", "updated_at" => "2022-02-03T17:14:40-05:00", "published_at" => "2008-09-25T20:00:00-04:00", "template_suffix" => nil, "published_scope" => "web", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/921728736", "variants" => [{"id" => 447654529, "product_id" => 921728736, "title" => "Black", "price" => "199.00", "sku" => "IPOD2009BLACK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "shipwire-app", "inventory_management" => "shipwire-app", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 447654529, "inventory_quantity" => 13, "old_inventory_quantity" => 13, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/447654529"}], "options" => [{"id" => 891236591, "product_id" => 921728736, "name" => "Title", "position" => 1, "values" => ["Black"]}], "images" => [], "image" => nil}]}), headers: {})

    ShopifyAPI::Product.all(
      since_id: "632910392",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products.json?since_id=632910392")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products.json?presentment_currencies=USD")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"products" => [{"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2022-02-03T17:14:40-05:00", "handle" => "ipod-nano", "updated_at" => "2022-02-03T17:14:40-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1643926480", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}, {"id" => 921728736, "title" => "IPod Touch 8GB", "body_html" => "<p>The iPod Touch has the iPhone's multi-touch interface, with a physical home button off the touch screen. The home screen has a list of buttons for the available applications.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2022-02-03T17:14:40-05:00", "handle" => "ipod-touch", "updated_at" => "2022-02-03T17:14:40-05:00", "published_at" => "2008-09-25T20:00:00-04:00", "template_suffix" => nil, "published_scope" => "web", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/921728736", "variants" => [{"id" => 447654529, "product_id" => 921728736, "title" => "Black", "price" => "199.00", "sku" => "IPOD2009BLACK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "shipwire-app", "inventory_management" => "shipwire-app", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 447654529, "inventory_quantity" => 13, "old_inventory_quantity" => 13, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/447654529"}], "options" => [{"id" => 891236591, "product_id" => 921728736, "name" => "Title", "position" => 1, "values" => ["Black"]}], "images" => [], "image" => nil}]}), headers: {})

    ShopifyAPI::Product.all(
      presentment_currencies: "USD",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products.json?presentment_currencies=USD")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "tags" => ["Barnes & Noble", "Big Air", "John's Fav"]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 1071559616, "title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "created_at" => "2022-02-03T17:19:18-05:00", "handle" => "burton-custom-freestyle-151", "updated_at" => "2022-02-03T17:19:18-05:00", "published_at" => "2022-02-03T17:19:18-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Barnes & Noble, Big Air, John's Fav", "admin_graphql_api_id" => "gid://shopify/Product/1071559616", "variants" => [{"id" => 1070325084, "product_id" => 1071559616, "title" => "Default Title", "price" => "0.00", "sku" => "", "position" => 1, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "Default Title", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:19:18-05:00", "updated_at" => "2022-02-03T17:19:18-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325084, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "0.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325084"}], "options" => [{"id" => 1055547251, "product_id" => 1071559616, "name" => "Title", "position" => 1, "values" => ["Default Title"]}], "images" => [], "image" => nil}}), headers: {})

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
    product.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "published" => false}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 1071559617, "title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "created_at" => "2022-02-03T17:19:20-05:00", "handle" => "burton-custom-freestyle-151", "updated_at" => "2022-02-03T17:19:20-05:00", "published_at" => nil, "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/1071559617", "variants" => [{"id" => 1070325085, "product_id" => 1071559617, "title" => "Default Title", "price" => "0.00", "sku" => "", "position" => 1, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "Default Title", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:19:20-05:00", "updated_at" => "2022-02-03T17:19:20-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325085, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "0.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325085"}], "options" => [{"id" => 1055547252, "product_id" => 1071559617, "name" => "Title", "position" => 1, "values" => ["Default Title"]}], "images" => [], "image" => nil}}), headers: {})

    product = ShopifyAPI::Product.new
    product.title = "Burton Custom Freestyle 151"
    product.body_html = "<strong>Good snowboard!</strong>"
    product.vendor = "Burton"
    product.product_type = "Snowboard"
    product.published = false
    product.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "status" => "draft"}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 1071559618, "title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "created_at" => "2022-02-03T17:19:22-05:00", "handle" => "burton-custom-freestyle-151", "updated_at" => "2022-02-03T17:19:22-05:00", "published_at" => nil, "template_suffix" => nil, "status" => "draft", "published_scope" => "web", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/1071559618", "variants" => [{"id" => 1070325086, "product_id" => 1071559618, "title" => "Default Title", "price" => "0.00", "sku" => "", "position" => 1, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "Default Title", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:19:22-05:00", "updated_at" => "2022-02-03T17:19:22-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325086, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "0.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325086"}], "options" => [{"id" => 1055547253, "product_id" => 1071559618, "name" => "Title", "position" => 1, "values" => ["Default Title"]}], "images" => [], "image" => nil}}), headers: {})

    product = ShopifyAPI::Product.new
    product.title = "Burton Custom Freestyle 151"
    product.body_html = "<strong>Good snowboard!</strong>"
    product.vendor = "Burton"
    product.product_type = "Snowboard"
    product.status = "draft"
    product.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "variants" => [{"option1" => "First", "price" => "10.00", "sku" => "123"}, {"option1" => "Second", "price" => "20.00", "sku" => "123"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 1071559619, "title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "created_at" => "2022-02-03T17:19:26-05:00", "handle" => "burton-custom-freestyle-151", "updated_at" => "2022-02-03T17:19:27-05:00", "published_at" => "2022-02-03T17:19:26-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/1071559619", "variants" => [{"id" => 1070325087, "product_id" => 1071559619, "title" => "First", "price" => "10.00", "sku" => "123", "position" => 1, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "First", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:19:27-05:00", "updated_at" => "2022-02-03T17:19:27-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325087, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "10.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325087"}, {"id" => 1070325088, "product_id" => 1071559619, "title" => "Second", "price" => "20.00", "sku" => "123", "position" => 2, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "Second", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:19:27-05:00", "updated_at" => "2022-02-03T17:19:27-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325088, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "20.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325088"}], "options" => [{"id" => 1055547254, "product_id" => 1071559619, "name" => "Title", "position" => 1, "values" => ["First", "Second"]}], "images" => [], "image" => nil}}), headers: {})

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
    product.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products.json")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "variants" => [{"option1" => "Blue", "option2" => "155"}, {"option1" => "Black", "option2" => "159"}], "options" => [{"name" => "Color", "values" => ["Blue", "Black"]}, {"name" => "Size", "values" => ["155", "159"]}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 1071559620, "title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "created_at" => "2022-02-03T17:19:30-05:00", "handle" => "burton-custom-freestyle-151", "updated_at" => "2022-02-03T17:19:31-05:00", "published_at" => "2022-02-03T17:19:30-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/1071559620", "variants" => [{"id" => 1070325089, "product_id" => 1071559620, "title" => "Blue / 155", "price" => "0.00", "sku" => "", "position" => 1, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "Blue", "option2" => "155", "option3" => nil, "created_at" => "2022-02-03T17:19:31-05:00", "updated_at" => "2022-02-03T17:19:31-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325089, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "0.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325089"}, {"id" => 1070325090, "product_id" => 1071559620, "title" => "Black / 159", "price" => "0.00", "sku" => "", "position" => 2, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "Black", "option2" => "159", "option3" => nil, "created_at" => "2022-02-03T17:19:31-05:00", "updated_at" => "2022-02-03T17:19:31-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325090, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "0.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325090"}], "options" => [{"id" => 1055547255, "product_id" => 1071559620, "name" => "Color", "position" => 1, "values" => ["Blue", "Black"]}, {"id" => 1055547256, "product_id" => 1071559620, "name" => "Size", "position" => 2, "values" => ["155", "159"]}], "images" => [], "image" => nil}}), headers: {})

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
    product.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products.json")
  end

  sig do
    void
  end
  def test_12()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "images" => [{"attachment" => "R0lGODlhAQABAIAAAAAAAAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==\n"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 1071559621, "title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "created_at" => "2022-02-03T17:19:33-05:00", "handle" => "burton-custom-freestyle-151", "updated_at" => "2022-02-03T17:19:33-05:00", "published_at" => "2022-02-03T17:19:33-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/1071559621", "variants" => [{"id" => 1070325091, "product_id" => 1071559621, "title" => "Default Title", "price" => "0.00", "sku" => "", "position" => 1, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "Default Title", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:19:33-05:00", "updated_at" => "2022-02-03T17:19:33-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325091, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "0.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325091"}], "options" => [{"id" => 1055547257, "product_id" => 1071559621, "name" => "Title", "position" => 1, "values" => ["Default Title"]}], "images" => [{"id" => 1001473926, "product_id" => 1071559621, "position" => 1, "created_at" => "2022-02-03T17:19:33-05:00", "updated_at" => "2022-02-03T17:19:33-05:00", "alt" => nil, "width" => 1, "height" => 1, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/df3e567d6f16d040326c7a0ea29a4f41.gif?v=1643926773", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/1001473926"}], "image" => {"id" => 1001473926, "product_id" => 1071559621, "position" => 1, "created_at" => "2022-02-03T17:19:33-05:00", "updated_at" => "2022-02-03T17:19:33-05:00", "alt" => nil, "width" => 1, "height" => 1, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/df3e567d6f16d040326c7a0ea29a4f41.gif?v=1643926773", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/1001473926"}}}), headers: {})

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
    product.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products.json")
  end

  sig do
    void
  end
  def test_13()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "images" => [{"src" => "http://example.com/rails_logo.gif"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 1071559622, "title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "created_at" => "2022-02-03T17:19:35-05:00", "handle" => "burton-custom-freestyle-151", "updated_at" => "2022-02-03T17:19:35-05:00", "published_at" => "2022-02-03T17:19:35-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/1071559622", "variants" => [{"id" => 1070325092, "product_id" => 1071559622, "title" => "Default Title", "price" => "0.00", "sku" => "", "position" => 1, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "Default Title", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:19:35-05:00", "updated_at" => "2022-02-03T17:19:35-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325092, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "0.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325092"}], "options" => [{"id" => 1055547258, "product_id" => 1071559622, "name" => "Title", "position" => 1, "values" => ["Default Title"]}], "images" => [{"id" => 1001473927, "product_id" => 1071559622, "position" => 1, "created_at" => "2022-02-03T17:19:35-05:00", "updated_at" => "2022-02-03T17:19:35-05:00", "alt" => nil, "width" => 110, "height" => 140, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/rails_logo20220203-1526776-4yqywr.gif?v=1643926775", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/1001473927"}], "image" => {"id" => 1001473927, "product_id" => 1071559622, "position" => 1, "created_at" => "2022-02-03T17:19:35-05:00", "updated_at" => "2022-02-03T17:19:35-05:00", "alt" => nil, "width" => 110, "height" => 140, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/rails_logo20220203-1526776-4yqywr.gif?v=1643926775", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/1001473927"}}}), headers: {})

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
    product.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products.json")
  end

  sig do
    void
  end
  def test_14()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "metafields_global_title_tag" => "Product SEO Title", "metafields_global_description_tag" => "Product SEO Description"}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 1071559623, "title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "created_at" => "2022-02-03T17:19:38-05:00", "handle" => "burton-custom-freestyle-151", "updated_at" => "2022-02-03T17:19:38-05:00", "published_at" => "2022-02-03T17:19:38-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/1071559623", "variants" => [{"id" => 1070325093, "product_id" => 1071559623, "title" => "Default Title", "price" => "0.00", "sku" => "", "position" => 1, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "Default Title", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:19:38-05:00", "updated_at" => "2022-02-03T17:19:38-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325093, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "0.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325093"}], "options" => [{"id" => 1055547259, "product_id" => 1071559623, "name" => "Title", "position" => 1, "values" => ["Default Title"]}], "images" => [], "image" => nil}}), headers: {})

    product = ShopifyAPI::Product.new
    product.title = "Burton Custom Freestyle 151"
    product.body_html = "<strong>Good snowboard!</strong>"
    product.vendor = "Burton"
    product.product_type = "Snowboard"
    product.metafields_global_title_tag = "Product SEO Title"
    product.metafields_global_description_tag = "Product SEO Description"
    product.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products.json")
  end

  sig do
    void
  end
  def test_15()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "metafields" => [{"key" => "new", "value" => "newvalue", "value_type" => "string", "namespace" => "global"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 1071559624, "title" => "Burton Custom Freestyle 151", "body_html" => "<strong>Good snowboard!</strong>", "vendor" => "Burton", "product_type" => "Snowboard", "created_at" => "2022-02-03T17:19:40-05:00", "handle" => "burton-custom-freestyle-151", "updated_at" => "2022-02-03T17:19:40-05:00", "published_at" => "2022-02-03T17:19:40-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "", "admin_graphql_api_id" => "gid://shopify/Product/1071559624", "variants" => [{"id" => 1070325094, "product_id" => 1071559624, "title" => "Default Title", "price" => "0.00", "sku" => "", "position" => 1, "inventory_policy" => "deny", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => nil, "option1" => "Default Title", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:19:40-05:00", "updated_at" => "2022-02-03T17:19:40-05:00", "taxable" => true, "barcode" => nil, "grams" => 0, "image_id" => nil, "weight" => 0.0, "weight_unit" => "lb", "inventory_item_id" => 1070325094, "inventory_quantity" => 0, "old_inventory_quantity" => 0, "presentment_prices" => [{"price" => {"amount" => "0.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/1070325094"}], "options" => [{"id" => 1055547260, "product_id" => 1071559624, "name" => "Title", "position" => 1, "values" => ["Default Title"]}], "images" => [], "image" => nil}}), headers: {})

    product = ShopifyAPI::Product.new
    product.title = "Burton Custom Freestyle 151"
    product.body_html = "<strong>Good snowboard!</strong>"
    product.vendor = "Burton"
    product.product_type = "Snowboard"
    product.metafields = [
      {
        "key" => "new",
        "value" => "newvalue",
        "value_type" => "string",
        "namespace" => "global"
      }
    ]
    product.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products.json")
  end

  sig do
    void
  end
  def test_16()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 2}), headers: {})

    ShopifyAPI::Product.count()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products/count.json")
  end

  sig do
    void
  end
  def test_17()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products/count.json?collection_id=841564295")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    ShopifyAPI::Product.count(
      collection_id: "841564295",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products/count.json?collection_id=841564295")
  end

  sig do
    void
  end
  def test_18()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2022-02-03T17:14:40-05:00", "handle" => "ipod-nano", "updated_at" => "2022-02-03T17:14:40-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1643926480", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

    ShopifyAPI::Product.find(
      id: 632910392,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
  end

  sig do
    void
  end
  def test_19()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json?fields=id%2Cimages%2Ctitle")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1643926480", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}]}}), headers: {})

    ShopifyAPI::Product.find(
      id: 632910392,
      fields: "id,images,title",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json?fields=id%2Cimages%2Ctitle")
  end

  sig do
    void
  end
  def test_20()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"id" => 632910392, "title" => "New product title"}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "New product title", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2022-02-03T17:14:40-05:00", "handle" => "ipod-nano", "updated_at" => "2022-02-03T17:20:01-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1643926480", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

    product = ShopifyAPI::Product.new
    product.id = 632910392
    product.title = "New product title"
    product.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
  end

  sig do
    void
  end
  def test_21()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"id" => 632910392, "status" => "draft"}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2022-02-03T17:14:40-05:00", "handle" => "ipod-nano", "updated_at" => "2022-02-03T17:20:03-05:00", "published_at" => nil, "template_suffix" => nil, "status" => "draft", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1643926480", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

    product = ShopifyAPI::Product.new
    product.id = 632910392
    product.status = "draft"
    product.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
  end

  sig do
    void
  end
  def test_22()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"id" => 632910392, "tags" => "Barnes & Noble, John's Fav"}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2022-02-03T17:14:40-05:00", "handle" => "ipod-nano", "updated_at" => "2022-02-03T17:20:06-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Barnes & Noble, John's Fav", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1643926480", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

    product = ShopifyAPI::Product.new
    product.id = 632910392
    product.tags = "Barnes & Noble, John's Fav"
    product.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
  end

  sig do
    void
  end
  def test_23()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"id" => 632910392, "images" => []}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2022-02-03T17:14:40-05:00", "handle" => "ipod-nano", "updated_at" => "2022-02-03T17:20:08-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:20:07-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [], "image" => nil}}), headers: {})

    product = ShopifyAPI::Product.new
    product.id = 632910392
    product.images = []
    product.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
  end

  sig do
    void
  end
  def test_24()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"id" => 632910392, "images" => [{"id" => 850703190}, {"id" => 562641783}, {"id" => 378407906}, {"src" => "http://example.com/rails_logo.gif"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2022-02-03T17:14:40-05:00", "handle" => "ipod-nano", "updated_at" => "2022-02-03T17:20:11-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1643926480", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}, {"id" => 1001473930, "product_id" => 632910392, "position" => 4, "created_at" => "2022-02-03T17:20:10-05:00", "updated_at" => "2022-02-03T17:20:10-05:00", "alt" => nil, "width" => 110, "height" => 140, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/rails_logo20220203-1526776-in4aio.gif?v=1643926810", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/1001473930"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

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
    product.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
  end

  sig do
    void
  end
  def test_25()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"id" => 632910392, "images" => [{"id" => 850703190, "position" => 3}, {"id" => 562641783, "position" => 2}, {"id" => 378407906, "position" => 1}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2022-02-03T17:14:40-05:00", "handle" => "ipod-nano", "updated_at" => "2022-02-03T17:20:14-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 378407906, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:20:13-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926813", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1643926480", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 850703190, "product_id" => 632910392, "position" => 3, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:20:13-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926813", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}], "image" => {"id" => 378407906, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:20:13-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926813", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}}}), headers: {})

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
    product.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
  end

  sig do
    void
  end
  def test_26()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"id" => 632910392, "variants" => [{"id" => 457924702}, {"id" => 39072856}, {"id" => 49148385}, {"id" => 808950810}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2022-02-03T17:14:40-05:00", "handle" => "ipod-nano", "updated_at" => "2022-02-03T17:20:16-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:20:16-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:20:16-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:20:16-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:20:16-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Black", "Green", "Red", "Pink"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1643926480", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

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
    product.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
  end

  sig do
    void
  end
  def test_27()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"id" => 632910392, "title" => "Updated Product Title", "variants" => [{"id" => 808950810, "price" => "2000.00", "sku" => "Updating the Product SKU"}, {"id" => 49148385}, {"id" => 39072856}, {"id" => 457924702}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "Updated Product Title", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2022-02-03T17:14:40-05:00", "handle" => "ipod-nano", "updated_at" => "2022-02-03T17:20:20-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "2000.00", "sku" => "Updating the Product SKU", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:20:20-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1643926480", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

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
    product.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
  end

  sig do
    void
  end
  def test_28()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"id" => 632910392, "metafields_global_title_tag" => "Brand new title", "metafields_global_description_tag" => "Brand new description"}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2022-02-03T17:14:40-05:00", "handle" => "ipod-nano", "updated_at" => "2022-02-03T17:14:40-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1643926480", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

    product = ShopifyAPI::Product.new
    product.id = 632910392
    product.metafields_global_title_tag = "Brand new title"
    product.metafields_global_description_tag = "Brand new description"
    product.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
  end

  sig do
    void
  end
  def test_29()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"id" => 632910392, "published" => true}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2022-02-03T17:14:40-05:00", "handle" => "ipod-nano", "updated_at" => "2022-02-03T17:20:24-05:00", "published_at" => "2022-02-03T17:20:24-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1643926480", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

    product = ShopifyAPI::Product.new
    product.id = 632910392
    product.published = true
    product.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
  end

  sig do
    void
  end
  def test_30()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"id" => 632910392, "published" => false}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2022-02-03T17:14:40-05:00", "handle" => "ipod-nano", "updated_at" => "2022-02-03T17:20:26-05:00", "published_at" => nil, "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1643926480", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

    product = ShopifyAPI::Product.new
    product.id = 632910392
    product.published = false
    product.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
  end

  sig do
    void
  end
  def test_31()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "product" => hash_including({"id" => 632910392, "metafields" => [{"key" => "new", "value" => "newvalue", "value_type" => "string", "namespace" => "global"}]}) }
      )
      .to_return(status: 200, body: JSON.generate({"product" => {"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2022-02-03T17:14:40-05:00", "handle" => "ipod-nano", "updated_at" => "2022-02-03T17:20:32-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "status" => "active", "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "variants" => [{"id" => 808950810, "product_id" => 632910392, "title" => "Pink", "price" => "199.00", "sku" => "IPOD2008PINK", "position" => 1, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Pink", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_pink", "grams" => 567, "image_id" => 562641783, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 808950810, "inventory_quantity" => 10, "old_inventory_quantity" => 10, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/808950810"}, {"id" => 49148385, "product_id" => 632910392, "title" => "Red", "price" => "199.00", "sku" => "IPOD2008RED", "position" => 2, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Red", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_red", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 49148385, "inventory_quantity" => 20, "old_inventory_quantity" => 20, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/49148385"}, {"id" => 39072856, "product_id" => 632910392, "title" => "Green", "price" => "199.00", "sku" => "IPOD2008GREEN", "position" => 3, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Green", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_green", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 39072856, "inventory_quantity" => 30, "old_inventory_quantity" => 30, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/39072856"}, {"id" => 457924702, "product_id" => 632910392, "title" => "Black", "price" => "199.00", "sku" => "IPOD2008BLACK", "position" => 4, "inventory_policy" => "continue", "compare_at_price" => nil, "fulfillment_service" => "manual", "inventory_management" => "shopify", "option1" => "Black", "option2" => nil, "option3" => nil, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "taxable" => true, "barcode" => "1234_black", "grams" => 567, "image_id" => nil, "weight" => 1.25, "weight_unit" => "lb", "inventory_item_id" => 457924702, "inventory_quantity" => 40, "old_inventory_quantity" => 40, "presentment_prices" => [{"price" => {"amount" => "199.00", "currency_code" => "USD"}, "compare_at_price" => nil}], "requires_shipping" => true, "admin_graphql_api_id" => "gid://shopify/ProductVariant/457924702"}], "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1, "values" => ["Pink", "Red", "Green", "Black"]}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1643926480", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2022-02-03T17:14:40-05:00", "updated_at" => "2022-02-03T17:14:40-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1643926480", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}}), headers: {})

    product = ShopifyAPI::Product.new
    product.id = 632910392
    product.metafields = [
      {
        "key" => "new",
        "value" => "newvalue",
        "value_type" => "string",
        "namespace" => "global"
      }
    ]
    product.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
  end

  sig do
    void
  end
  def test_32()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Product.delete(
      id: 632910392,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
  end

end
