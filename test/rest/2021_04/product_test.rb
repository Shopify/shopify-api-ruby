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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

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
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Product.delete(
      id: 632910392,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392.json")
  end

end
