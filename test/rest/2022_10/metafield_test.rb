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

class Metafield202210Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?metafield%5Bowner_id%5D=382285388&metafield%5Bowner_resource%5D=blog")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => []}), headers: {})

    ShopifyAPI::Metafield.all(
      metafield: {"owner_id" => "382285388", "owner_resource" => "blog"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?metafield%5Bowner_id%5D=382285388&metafield%5Bowner_resource%5D=blog")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?metafield%5Bowner_id%5D=632910392&metafield%5Bowner_resource%5D=product")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => [{"id" => 51714266, "namespace" => "my_namespace", "key" => "my_key", "value" => "Hello", "description" => nil, "owner_id" => 632910392, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "product", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/51714266"}, {"id" => 116539875, "namespace" => "descriptors", "key" => "subtitle", "value" => "The best ipod", "description" => nil, "owner_id" => 632910392, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "product", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/116539875"}, {"id" => 263497237, "namespace" => "installments", "key" => "disable", "value" => true, "description" => nil, "owner_id" => 632910392, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "product", "type" => "boolean", "admin_graphql_api_id" => "gid://shopify/Metafield/263497237"}, {"id" => 273160493, "namespace" => "facts", "key" => "isbn", "value" => "978-0-14-004259-7", "description" => nil, "owner_id" => 632910392, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "product", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/273160493"}, {"id" => 524118066, "namespace" => "facts", "key" => "ean", "value" => "0123456789012", "description" => nil, "owner_id" => 632910392, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "product", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/524118066"}, {"id" => 543636738, "namespace" => "reviews", "key" => "rating_count", "value" => 1, "description" => nil, "owner_id" => 632910392, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "product", "type" => "number_integer", "admin_graphql_api_id" => "gid://shopify/Metafield/543636738"}, {"id" => 572384404, "namespace" => "reviews", "key" => "rating", "value" => "{\"value\": \"3.5\", \"scale_min\": \"1.0\", \"scale_max\": \"5.0\"}", "description" => nil, "owner_id" => 632910392, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "product", "type" => "rating", "admin_graphql_api_id" => "gid://shopify/Metafield/572384404"}, {"id" => 613330208, "namespace" => "shopify_filter", "key" => "display", "value" => "retina", "description" => "This field keeps track of the type of display", "owner_id" => 632910392, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "product", "type" => "string", "admin_graphql_api_id" => "gid://shopify/Metafield/613330208"}, {"id" => 779326701, "namespace" => "facts", "key" => "upc", "value" => "012345678901", "description" => nil, "owner_id" => 632910392, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "product", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/779326701"}, {"id" => 845366454, "namespace" => "translations", "key" => "title_fr", "value" => "produit", "description" => "French product title", "owner_id" => 632910392, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "product", "type" => "string", "admin_graphql_api_id" => "gid://shopify/Metafield/845366454"}, {"id" => 861799889, "namespace" => "my_other_fields", "key" => "organic", "value" => true, "description" => nil, "owner_id" => 632910392, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "product", "type" => "boolean", "admin_graphql_api_id" => "gid://shopify/Metafield/861799889"}, {"id" => 870326793, "namespace" => "descriptors", "key" => "care_guide", "value" => "Wash in cold water", "description" => nil, "owner_id" => 632910392, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "product", "type" => nil, "admin_graphql_api_id" => "gid://shopify/Metafield/870326793"}, {"id" => 908250163, "namespace" => "my_other_fields", "key" => "shipping_policy", "value" => "Ships for free in Canada", "description" => nil, "owner_id" => 632910392, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "product", "type" => "multi_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/908250163"}, {"id" => 925288667, "namespace" => "my_other_fields", "key" => "year_released", "value" => 2019, "description" => nil, "owner_id" => 632910392, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "product", "type" => "number_integer", "admin_graphql_api_id" => "gid://shopify/Metafield/925288667"}, {"id" => 1001077698, "namespace" => "my_fields", "key" => "best_for", "value" => "travel", "description" => nil, "owner_id" => 632910392, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "product", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/1001077698"}, {"id" => 1029402048, "namespace" => "my_other_fields", "key" => "ingredients", "value" => "[\"apple\", \"music\", \"u2\"]", "description" => nil, "owner_id" => 632910392, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "product", "type" => "list.single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/1029402048"}]}), headers: {})

    ShopifyAPI::Metafield.all(
      metafield: {"owner_id" => "632910392", "owner_resource" => "product"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?metafield%5Bowner_id%5D=632910392&metafield%5Bowner_resource%5D=product")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?metafield%5Bowner_id%5D=207119551&metafield%5Bowner_resource%5D=customer")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => [{"id" => 220591908, "namespace" => "discounts", "key" => "returning_customer", "value" => "no", "description" => "Customer deserves discount", "owner_id" => 207119551, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "customer", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/220591908"}]}), headers: {})

    ShopifyAPI::Metafield.all(
      metafield: {"owner_id" => "207119551", "owner_resource" => "customer"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?metafield%5Bowner_id%5D=207119551&metafield%5Bowner_resource%5D=customer")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?metafield%5Bowner_id%5D=622762746&metafield%5Bowner_resource%5D=draft_order")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => [{"id" => 106172460, "namespace" => "notes", "key" => "note", "value" => "B flat", "description" => "This is for notes", "owner_id" => 622762746, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "draft_order", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/106172460"}]}), headers: {})

    ShopifyAPI::Metafield.all(
      metafield: {"owner_id" => "622762746", "owner_resource" => "draft_order"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?metafield%5Bowner_id%5D=622762746&metafield%5Bowner_resource%5D=draft_order")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?metafield%5Bowner_id%5D=131092082&metafield%5Bowner_resource%5D=page")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => [{"id" => 290519330, "namespace" => "translation", "key" => "title_fr", "value" => "Le TOS", "description" => "Page French title translation", "owner_id" => 131092082, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "page", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/290519330"}]}), headers: {})

    ShopifyAPI::Metafield.all(
      metafield: {"owner_id" => "131092082", "owner_resource" => "page"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?metafield%5Bowner_id%5D=131092082&metafield%5Bowner_resource%5D=page")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?since_id=721389482")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => [{"id" => 1063298188, "namespace" => "inventory", "key" => "warehouse", "value" => 25, "description" => nil, "owner_id" => 548380009, "created_at" => "2022-10-03T12:17:58-04:00", "updated_at" => "2022-10-03T12:17:58-04:00", "owner_resource" => "shop", "type" => "number_integer", "admin_graphql_api_id" => "gid://shopify/Metafield/1063298188"}]}), headers: {})

    ShopifyAPI::Metafield.all(
      since_id: "721389482",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?since_id=721389482")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?metafield%5Bowner_id%5D=674387490&metafield%5Bowner_resource%5D=article")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => []}), headers: {})

    ShopifyAPI::Metafield.all(
      metafield: {"owner_id" => "674387490", "owner_resource" => "article"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?metafield%5Bowner_id%5D=674387490&metafield%5Bowner_resource%5D=article")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?metafield%5Bowner_id%5D=482865238&metafield%5Bowner_resource%5D=collection")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => [{"id" => 519046726, "namespace" => "notes", "key" => "descriptionription", "value" => "Collection description", "description" => "Custom Collection notes", "owner_id" => 482865238, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "collection", "type" => "string", "admin_graphql_api_id" => "gid://shopify/Metafield/519046726"}, {"id" => 624849518, "namespace" => "global", "key" => "description_tag", "value" => "Some seo description value", "description" => nil, "owner_id" => 482865238, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "collection", "type" => "string", "admin_graphql_api_id" => "gid://shopify/Metafield/624849518"}, {"id" => 1010236510, "namespace" => "global", "key" => "title_tag", "value" => "Some seo title value", "description" => nil, "owner_id" => 482865238, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "collection", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/1010236510"}]}), headers: {})

    ShopifyAPI::Metafield.all(
      metafield: {"owner_id" => "482865238", "owner_resource" => "collection"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?metafield%5Bowner_id%5D=482865238&metafield%5Bowner_resource%5D=collection")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?metafield%5Bowner_id%5D=49148385&metafield%5Bowner_resource%5D=variants")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => []}), headers: {})

    ShopifyAPI::Metafield.all(
      metafield: {"owner_id" => "49148385", "owner_resource" => "variants"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?metafield%5Bowner_id%5D=49148385&metafield%5Bowner_resource%5D=variants")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => [{"id" => 721389482, "namespace" => "affiliates", "key" => "app_key", "value" => "app_key", "description" => nil, "owner_id" => 548380009, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "shop", "type" => "string", "admin_graphql_api_id" => "gid://shopify/Metafield/721389482"}]}), headers: {})

    ShopifyAPI::Metafield.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?metafield%5Bowner_id%5D=450789469&metafield%5Bowner_resource%5D=order")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => [{"id" => 915396079, "namespace" => "notes", "key" => "buyer", "value" => "Notes about this buyer", "description" => "This field is for buyer notes", "owner_id" => 450789469, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "order", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/915396079"}]}), headers: {})

    ShopifyAPI::Metafield.all(
      metafield: {"owner_id" => "450789469", "owner_resource" => "order"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?metafield%5Bowner_id%5D=450789469&metafield%5Bowner_resource%5D=order")
  end

  sig do
    void
  end
  def test_12()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?metafield%5Bowner_id%5D=850703190&metafield%5Bowner_resource%5D=product_image")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => [{"id" => 625663657, "namespace" => "translation", "key" => "title_fr", "value" => "tbn", "description" => "French product image title", "owner_id" => 850703190, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "product_image", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/625663657"}]}), headers: {})

    ShopifyAPI::Metafield.all(
      metafield: {"owner_id" => "850703190", "owner_resource" => "product_image"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields.json?metafield%5Bowner_id%5D=850703190&metafield%5Bowner_resource%5D=product_image")
  end

  sig do
    void
  end
  def test_13()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/pages/131092082/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    ShopifyAPI::Metafield.count(
      page_id: 131092082,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/pages/131092082/metafields/count.json")
  end

  sig do
    void
  end
  def test_14()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/collections/482865238/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 3}), headers: {})

    ShopifyAPI::Metafield.count(
      collection_id: 482865238,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/collections/482865238/metafields/count.json")
  end

  sig do
    void
  end
  def test_15()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/variants/49148385/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 0}), headers: {})

    ShopifyAPI::Metafield.count(
      variant_id: 49148385,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/variants/49148385/metafields/count.json")
  end

  sig do
    void
  end
  def test_16()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    ShopifyAPI::Metafield.count(
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/metafields/count.json")
  end

  sig do
    void
  end
  def test_17()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    ShopifyAPI::Metafield.count

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields/count.json")
  end

  sig do
    void
  end
  def test_18()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/draft_orders/622762746/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    ShopifyAPI::Metafield.count(
      draft_order_id: 622762746,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/draft_orders/622762746/metafields/count.json")
  end

  sig do
    void
  end
  def test_19()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/blogs/382285388/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 0}), headers: {})

    ShopifyAPI::Metafield.count(
      blog_id: 382285388,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/blogs/382285388/metafields/count.json")
  end

  sig do
    void
  end
  def test_20()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    ShopifyAPI::Metafield.count(
      customer_id: 207119551,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551/metafields/count.json")
  end

  sig do
    void
  end
  def test_21()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 16}), headers: {})

    ShopifyAPI::Metafield.count(
      product_id: 632910392,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392/metafields/count.json")
  end

  sig do
    void
  end
  def test_22()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/articles/674387490/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 0}), headers: {})

    ShopifyAPI::Metafield.count(
      article_id: 674387490,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/articles/674387490/metafields/count.json")
  end

  sig do
    void
  end
  def test_23()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/product_images/850703190/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    ShopifyAPI::Metafield.count(
      product_image_id: 850703190,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/product_images/850703190/metafields/count.json")
  end

  sig do
    void
  end
  def test_24()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/variants/49148385/metafields/323119633.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 323119633, "namespace" => "my_fields", "key" => "color", "value" => "Pink", "description" => nil, "owner_id" => 808950810, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "variant", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/323119633"}}), headers: {})

    ShopifyAPI::Metafield.find(
      variant_id: 49148385,
      id: 323119633,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/variants/49148385/metafields/323119633.json")
  end

  sig do
    void
  end
  def test_25()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/product_images/850703190/metafields/625663657.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 625663657, "namespace" => "translation", "key" => "title_fr", "value" => "tbn", "description" => "French product image title", "owner_id" => 850703190, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "product_image", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/625663657"}}), headers: {})

    ShopifyAPI::Metafield.find(
      product_image_id: 850703190,
      id: 625663657,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/product_images/850703190/metafields/625663657.json")
  end

  sig do
    void
  end
  def test_26()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/collections/482865238/metafields/1010236510.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 1010236510, "namespace" => "global", "key" => "title_tag", "value" => "Some seo title value", "description" => nil, "owner_id" => 482865238, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "collection", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/1010236510"}}), headers: {})

    ShopifyAPI::Metafield.find(
      collection_id: 482865238,
      id: 1010236510,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/collections/482865238/metafields/1010236510.json")
  end

  sig do
    void
  end
  def test_27()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/draft_orders/622762746/metafields/106172460.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 106172460, "namespace" => "notes", "key" => "note", "value" => "B flat", "description" => "This is for notes", "owner_id" => 622762746, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "draft_order", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/106172460"}}), headers: {})

    ShopifyAPI::Metafield.find(
      draft_order_id: 622762746,
      id: 106172460,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/draft_orders/622762746/metafields/106172460.json")
  end

  sig do
    void
  end
  def test_28()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392/metafields/1001077698.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 1001077698, "namespace" => "my_fields", "key" => "best_for", "value" => "travel", "description" => nil, "owner_id" => 632910392, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "product", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/1001077698"}}), headers: {})

    ShopifyAPI::Metafield.find(
      product_id: 632910392,
      id: 1001077698,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392/metafields/1001077698.json")
  end

  sig do
    void
  end
  def test_29()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields/721389482.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 721389482, "namespace" => "affiliates", "key" => "app_key", "value" => "app_key", "description" => nil, "owner_id" => 548380009, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "shop", "type" => "string", "admin_graphql_api_id" => "gid://shopify/Metafield/721389482"}}), headers: {})

    ShopifyAPI::Metafield.find(
      id: 721389482,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/metafields/721389482.json")
  end

  sig do
    void
  end
  def test_30()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551/metafields/220591908.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 220591908, "namespace" => "discounts", "key" => "returning_customer", "value" => "no", "description" => "Customer deserves discount", "owner_id" => 207119551, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "customer", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/220591908"}}), headers: {})

    ShopifyAPI::Metafield.find(
      customer_id: 207119551,
      id: 220591908,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551/metafields/220591908.json")
  end

  sig do
    void
  end
  def test_31()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/blogs/382285388/metafields/534526895.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 534526895, "namespace" => "translation", "key" => "title_fr", "value" => "Le iPod", "description" => "Blog French title translation", "owner_id" => 241253187, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "blog", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/534526895"}}), headers: {})

    ShopifyAPI::Metafield.find(
      blog_id: 382285388,
      id: 534526895,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/blogs/382285388/metafields/534526895.json")
  end

  sig do
    void
  end
  def test_32()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/pages/131092082/metafields/290519330.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 290519330, "namespace" => "translation", "key" => "title_fr", "value" => "Le TOS", "description" => "Page French title translation", "owner_id" => 131092082, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "page", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/290519330"}}), headers: {})

    ShopifyAPI::Metafield.find(
      page_id: 131092082,
      id: 290519330,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/pages/131092082/metafields/290519330.json")
  end

  sig do
    void
  end
  def test_33()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/metafields/915396079.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 915396079, "namespace" => "notes", "key" => "buyer", "value" => "Notes about this buyer", "description" => "This field is for buyer notes", "owner_id" => 450789469, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "order", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/915396079"}}), headers: {})

    ShopifyAPI::Metafield.find(
      order_id: 450789469,
      id: 915396079,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/metafields/915396079.json")
  end

  sig do
    void
  end
  def test_34()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-10/articles/674387490/metafields/838981074.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 838981074, "namespace" => "translation", "key" => "title_fr", "value" => "Le Article", "description" => "Article French title translation", "owner_id" => 134645308, "created_at" => "2022-10-03T12:15:55-04:00", "updated_at" => "2022-10-03T12:15:55-04:00", "owner_resource" => "article", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/838981074"}}), headers: {})

    ShopifyAPI::Metafield.find(
      article_id: 674387490,
      id: 838981074,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-10/articles/674387490/metafields/838981074.json")
  end

  sig do
    void
  end
  def test_35()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/product_images/850703190/metafields/625663657.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      product_image_id: 850703190,
      id: 625663657,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/product_images/850703190/metafields/625663657.json")
  end

  sig do
    void
  end
  def test_36()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/draft_orders/622762746/metafields/106172460.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      draft_order_id: 622762746,
      id: 106172460,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/draft_orders/622762746/metafields/106172460.json")
  end

  sig do
    void
  end
  def test_37()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551/metafields/220591908.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      customer_id: 207119551,
      id: 220591908,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/customers/207119551/metafields/220591908.json")
  end

  sig do
    void
  end
  def test_38()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/collections/482865238/metafields/1010236510.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      collection_id: 482865238,
      id: 1010236510,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/collections/482865238/metafields/1010236510.json")
  end

  sig do
    void
  end
  def test_39()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/blogs/382285388/metafields/534526895.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      blog_id: 382285388,
      id: 534526895,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/blogs/382285388/metafields/534526895.json")
  end

  sig do
    void
  end
  def test_40()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/metafields/721389482.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      id: 721389482,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/metafields/721389482.json")
  end

  sig do
    void
  end
  def test_41()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/variants/49148385/metafields/323119633.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      variant_id: 49148385,
      id: 323119633,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/variants/49148385/metafields/323119633.json")
  end

  sig do
    void
  end
  def test_42()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/pages/131092082/metafields/290519330.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      page_id: 131092082,
      id: 290519330,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/pages/131092082/metafields/290519330.json")
  end

  sig do
    void
  end
  def test_43()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392/metafields/1001077698.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      product_id: 632910392,
      id: 1001077698,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/products/632910392/metafields/1001077698.json")
  end

  sig do
    void
  end
  def test_44()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/metafields/915396079.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      order_id: 450789469,
      id: 915396079,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/orders/450789469/metafields/915396079.json")
  end

  sig do
    void
  end
  def test_45()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/articles/674387490/metafields/838981074.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      article_id: 674387490,
      id: 838981074,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2022-10/articles/674387490/metafields/838981074.json")
  end

end
