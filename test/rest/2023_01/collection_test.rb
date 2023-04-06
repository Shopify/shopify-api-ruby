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

class Collection202301Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2023-01")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/collections/841564295.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"collection" => {"id" => 841564295, "handle" => "ipods", "title" => "IPods", "updated_at" => "2008-02-01T19:00:00-05:00", "body_html" => "<p>The best selling ipod ever</p>", "published_at" => "2008-02-01T19:00:00-05:00", "sort_order" => "manual", "template_suffix" => nil, "products_count" => 1, "collection_type" => "custom", "published_scope" => "web", "admin_graphql_api_id" => "gid://shopify/Collection/841564295", "image" => {"created_at" => "2023-02-02T09:56:58-05:00", "alt" => "MP3 Player 8gb", "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/collections/ipod_nano_8gb.jpg?v=1675349818"}}}), headers: {})

    ShopifyAPI::Collection.find(
      id: 841564295,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/collections/841564295.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-01/collections/841564295/products.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"products" => [{"id" => 632910392, "title" => "IPod Nano - 8GB", "body_html" => "<p>It's the small iPod with one very big idea: Video. Now the world's most popular music player, available in 4GB and 8GB models, lets you enjoy TV shows, movies, video podcasts, and more. The larger, brighter display means amazing picture quality. In six eye-catching colors, iPod nano is stunning all around. And with models starting at just $149, little speaks volumes.</p>", "vendor" => "Apple", "product_type" => "Cult Products", "created_at" => "2023-02-02T09:56:58-05:00", "handle" => "ipod-nano", "updated_at" => "2023-02-02T09:56:58-05:00", "published_at" => "2007-12-31T19:00:00-05:00", "template_suffix" => nil, "published_scope" => "web", "tags" => "Emotive, Flash Memory, MP3, Music", "admin_graphql_api_id" => "gid://shopify/Product/632910392", "options" => [{"id" => 594680422, "product_id" => 632910392, "name" => "Color", "position" => 1}], "images" => [{"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-02-02T09:56:58-05:00", "updated_at" => "2023-02-02T09:56:58-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1675349818", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}, {"id" => 562641783, "product_id" => 632910392, "position" => 2, "created_at" => "2023-02-02T09:56:58-05:00", "updated_at" => "2023-02-02T09:56:58-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano-2.png?v=1675349818", "variant_ids" => [808950810], "admin_graphql_api_id" => "gid://shopify/ProductImage/562641783"}, {"id" => 378407906, "product_id" => 632910392, "position" => 3, "created_at" => "2023-02-02T09:56:58-05:00", "updated_at" => "2023-02-02T09:56:58-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1675349818", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/378407906"}], "image" => {"id" => 850703190, "product_id" => 632910392, "position" => 1, "created_at" => "2023-02-02T09:56:58-05:00", "updated_at" => "2023-02-02T09:56:58-05:00", "alt" => nil, "width" => 123, "height" => 456, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1675349818", "variant_ids" => [], "admin_graphql_api_id" => "gid://shopify/ProductImage/850703190"}}]}), headers: {})

    ShopifyAPI::Collection.products(
      id: 841564295,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-01/collections/841564295/products.json")
  end

end
