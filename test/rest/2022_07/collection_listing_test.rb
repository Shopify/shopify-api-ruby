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

class CollectionListing202207Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/collection_listings.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"collection_listings" => [{"collection_id" => 482865238, "updated_at" => "2022-07-02T01:33:09-04:00", "body_html" => "<p>The best selling ipod ever</p>", "default_product_image" => nil, "handle" => "smart-ipods", "image" => {"created_at" => "2022-07-02T01:33:09-04:00", "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/collections/ipod_nano_8gb.jpg?v=1656739989"}, "title" => "Smart iPods", "sort_order" => "manual", "published_at" => "2017-08-31T20:00:00-04:00"}, {"collection_id" => 841564295, "updated_at" => "2022-07-02T01:33:09-04:00", "body_html" => "<p>The best selling ipod ever</p>", "default_product_image" => nil, "handle" => "ipods", "image" => {"created_at" => "2022-07-02T01:33:09-04:00", "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/collections/ipod_nano_8gb.jpg?v=1656739989"}, "title" => "IPods", "sort_order" => "manual", "published_at" => "2017-08-31T20:00:00-04:00"}, {"collection_id" => 395646240, "updated_at" => "2022-07-02T01:33:09-04:00", "body_html" => "<p>The best selling ipod ever. Again</p>", "default_product_image" => {"id" => 850703190, "created_at" => "2022-07-02T01:33:09-04:00", "position" => 1, "updated_at" => "2022-07-02T01:33:09-04:00", "product_id" => 632910392, "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/products/ipod-nano.png?v=1656739989", "variant_ids" => [], "width" => 123, "height" => 456}, "handle" => "ipods_two", "image" => nil, "title" => "IPods Two", "sort_order" => "manual", "published_at" => "2017-08-31T20:00:00-04:00"}, {"collection_id" => 691652237, "updated_at" => "2022-07-02T01:33:09-04:00", "body_html" => "<p>No ipods here</p>", "default_product_image" => nil, "handle" => "non-ipods", "image" => nil, "title" => "Non Ipods", "sort_order" => "manual", "published_at" => "2017-08-31T20:00:00-04:00"}]}), headers: {})

    ShopifyAPI::CollectionListing.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/collection_listings.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/collection_listings/841564295/product_ids.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"product_ids" => [632910392]}), headers: {})

    ShopifyAPI::CollectionListing.product_ids(
      collection_id: 841564295,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/collection_listings/841564295/product_ids.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-07/collection_listings/482865238.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"collection_listing" => {"collection_id" => 482865238, "updated_at" => "2022-07-02T01:33:09-04:00", "body_html" => "<p>The best selling ipod ever</p>", "default_product_image" => nil, "handle" => "smart-ipods", "image" => {"created_at" => "2022-07-02T01:33:09-04:00", "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/collections/ipod_nano_8gb.jpg?v=1656739989"}, "title" => "Smart iPods", "sort_order" => "manual", "published_at" => "2017-08-31T20:00:00-04:00"}}), headers: {})

    ShopifyAPI::CollectionListing.find(
      collection_id: 482865238,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-07/collection_listings/482865238.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2022-07/collection_listings/482865238.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "collection_listing" => hash_including({}) }
      )
      .to_return(status: 200, body: JSON.generate({"collection_listing" => {"collection_id" => 482865238, "updated_at" => "2022-07-02T01:33:09-04:00", "body_html" => "<p>The best selling ipod ever</p>", "default_product_image" => nil, "handle" => "smart-ipods", "image" => {"created_at" => "2022-07-02T01:33:09-04:00", "src" => "https://cdn.shopify.com/s/files/1/0005/4838/0009/collections/ipod_nano_8gb.jpg?v=1656739989"}, "title" => "Smart iPods", "sort_order" => "manual", "published_at" => "2017-08-31T20:00:00-04:00"}}), headers: {})

    collection_listing = ShopifyAPI::CollectionListing.new
    collection_listing.collection_id = 482865238
    collection_listing.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2022-07/collection_listings/482865238.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-07/collection_listings/482865238.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::CollectionListing.delete(
      collection_id: 482865238,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-07/collection_listings/482865238.json")
  end

end
