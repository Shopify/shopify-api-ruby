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

class Metafield202107Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2021-07")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => [{"id" => 721389482, "namespace" => "affiliates", "key" => "app_key", "value" => "app_key", "value_type" => "string", "description" => nil, "owner_id" => 548380009, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:17:47-04:00", "owner_resource" => "shop", "type" => "string", "admin_graphql_api_id" => "gid://shopify/Metafield/721389482"}]}), headers: {})

    ShopifyAPI::Metafield.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?since_id=721389482")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => [{"id" => 1063298198, "namespace" => "inventory", "key" => "warehouse", "value" => 25, "value_type" => "integer", "description" => nil, "owner_id" => 548380009, "created_at" => "2022-04-05T13:21:10-04:00", "updated_at" => "2022-04-05T13:21:10-04:00", "owner_resource" => "shop", "type" => "number_integer", "admin_graphql_api_id" => "gid://shopify/Metafield/1063298198"}]}), headers: {})

    ShopifyAPI::Metafield.all(
      since_id: "721389482",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?since_id=721389482")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?metafield%5Bowner_id%5D=674387490&metafield%5Bowner_resource%5D=article")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => []}), headers: {})

    ShopifyAPI::Metafield.all(
      metafield: {"owner_id" => "674387490", "owner_resource" => "article"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?metafield%5Bowner_id%5D=674387490&metafield%5Bowner_resource%5D=article")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?metafield%5Bowner_id%5D=382285388&metafield%5Bowner_resource%5D=blog")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => []}), headers: {})

    ShopifyAPI::Metafield.all(
      metafield: {"owner_id" => "382285388", "owner_resource" => "blog"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?metafield%5Bowner_id%5D=382285388&metafield%5Bowner_resource%5D=blog")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?metafield%5Bowner_id%5D=482865238&metafield%5Bowner_resource%5D=collection")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => [{"id" => 519046726, "namespace" => "notes", "key" => "descriptionription", "value" => "Collection description", "description" => "Custom Collection notes", "owner_id" => 482865238, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:17:47-04:00", "owner_resource" => "collection", "type" => "string", "admin_graphql_api_id" => "gid://shopify/Metafield/519046726"}, {"id" => 624849518, "namespace" => "global", "key" => "description_tag", "value" => "Some seo description value", "description" => nil, "owner_id" => 482865238, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:17:47-04:00", "owner_resource" => "collection", "type" => "string", "admin_graphql_api_id" => "gid://shopify/Metafield/624849518"}, {"id" => 1010236510, "namespace" => "global", "key" => "title_tag", "value" => "Some seo title value", "description" => nil, "owner_id" => 482865238, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:17:47-04:00", "owner_resource" => "collection", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/1010236510"}]}), headers: {})

    ShopifyAPI::Metafield.all(
      metafield: {"owner_id" => "482865238", "owner_resource" => "collection"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?metafield%5Bowner_id%5D=482865238&metafield%5Bowner_resource%5D=collection")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?metafield%5Bowner_id%5D=207119551&metafield%5Bowner_resource%5D=customer")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => [{"id" => 220591908, "namespace" => "discounts", "key" => "returning_customer", "value" => "no", "description" => "Customer deserves discount", "owner_id" => 207119551, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:17:47-04:00", "owner_resource" => "customer", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/220591908"}]}), headers: {})

    ShopifyAPI::Metafield.all(
      metafield: {"owner_id" => "207119551", "owner_resource" => "customer"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?metafield%5Bowner_id%5D=207119551&metafield%5Bowner_resource%5D=customer")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?metafield%5Bowner_id%5D=622762746&metafield%5Bowner_resource%5D=draft_order")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => [{"id" => 106172460, "namespace" => "notes", "key" => "note", "value" => "B flat", "description" => "This is for notes", "owner_id" => 622762746, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:17:47-04:00", "owner_resource" => "draft_order", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/106172460"}]}), headers: {})

    ShopifyAPI::Metafield.all(
      metafield: {"owner_id" => "622762746", "owner_resource" => "draft_order"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?metafield%5Bowner_id%5D=622762746&metafield%5Bowner_resource%5D=draft_order")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?metafield%5Bowner_id%5D=450789469&metafield%5Bowner_resource%5D=order")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => [{"id" => 915396079, "namespace" => "notes", "key" => "buyer", "value" => "Notes about this buyer", "description" => "This field is for buyer notes", "owner_id" => 450789469, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:17:47-04:00", "owner_resource" => "order", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/915396079"}]}), headers: {})

    ShopifyAPI::Metafield.all(
      metafield: {"owner_id" => "450789469", "owner_resource" => "order"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?metafield%5Bowner_id%5D=450789469&metafield%5Bowner_resource%5D=order")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?metafield%5Bowner_id%5D=131092082&metafield%5Bowner_resource%5D=page")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => [{"id" => 290519330, "namespace" => "translation", "key" => "title_fr", "value" => "Le TOS", "description" => "Page French title translation", "owner_id" => 131092082, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:17:47-04:00", "owner_resource" => "page", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/290519330"}]}), headers: {})

    ShopifyAPI::Metafield.all(
      metafield: {"owner_id" => "131092082", "owner_resource" => "page"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?metafield%5Bowner_id%5D=131092082&metafield%5Bowner_resource%5D=page")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?metafield%5Bowner_id%5D=632910392&metafield%5Bowner_resource%5D=product")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => [{"id" => 613330208, "namespace" => "shopify_filter", "key" => "display", "value" => "retina", "description" => "This field keeps track of the type of display", "owner_id" => 632910392, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:17:47-04:00", "owner_resource" => "product", "type" => "string", "admin_graphql_api_id" => "gid://shopify/Metafield/613330208"}, {"id" => 845366454, "namespace" => "translations", "key" => "title_fr", "value" => "produit", "description" => "French product title", "owner_id" => 632910392, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:17:47-04:00", "owner_resource" => "product", "type" => "string", "admin_graphql_api_id" => "gid://shopify/Metafield/845366454"}, {"id" => 861799889, "namespace" => "my_other_fields", "key" => "organic", "value" => true, "description" => nil, "owner_id" => 632910392, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:17:47-04:00", "owner_resource" => "product", "type" => "boolean", "admin_graphql_api_id" => "gid://shopify/Metafield/861799889"}, {"id" => 908250163, "namespace" => "my_other_fields", "key" => "shipping_policy", "value" => "Ships for free in Canada", "description" => nil, "owner_id" => 632910392, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:17:47-04:00", "owner_resource" => "product", "type" => "multi_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/908250163"}, {"id" => 925288667, "namespace" => "my_other_fields", "key" => "year_released", "value" => 2019, "description" => nil, "owner_id" => 632910392, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:17:47-04:00", "owner_resource" => "product", "type" => "number_integer", "admin_graphql_api_id" => "gid://shopify/Metafield/925288667"}, {"id" => 1001077698, "namespace" => "my_fields", "key" => "best_for", "value" => "travel", "description" => nil, "owner_id" => 632910392, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:17:47-04:00", "owner_resource" => "product", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/1001077698"}, {"id" => 1029402048, "namespace" => "my_other_fields", "key" => "ingredients", "value" => "[\"apple\", \"music\", \"u2\"]", "description" => nil, "owner_id" => 632910392, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:17:47-04:00", "owner_resource" => "product", "type" => "list.single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/1029402048"}]}), headers: {})

    ShopifyAPI::Metafield.all(
      metafield: {"owner_id" => "632910392", "owner_resource" => "product"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?metafield%5Bowner_id%5D=632910392&metafield%5Bowner_resource%5D=product")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?metafield%5Bowner_id%5D=49148385&metafield%5Bowner_resource%5D=variants")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => []}), headers: {})

    ShopifyAPI::Metafield.all(
      metafield: {"owner_id" => "49148385", "owner_resource" => "variants"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?metafield%5Bowner_id%5D=49148385&metafield%5Bowner_resource%5D=variants")
  end

  sig do
    void
  end
  def test_12()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?metafield%5Bowner_id%5D=850703190&metafield%5Bowner_resource%5D=product_image")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => [{"id" => 625663657, "namespace" => "translation", "key" => "title_fr", "value" => "tbn", "description" => "French product image title", "owner_id" => 850703190, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:17:47-04:00", "owner_resource" => "product_image", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/625663657"}]}), headers: {})

    ShopifyAPI::Metafield.all(
      metafield: {"owner_id" => "850703190", "owner_resource" => "product_image"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json?metafield%5Bowner_id%5D=850703190&metafield%5Bowner_resource%5D=product_image")
  end

  sig do
    void
  end
  def test_13()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"namespace" => "inventory", "key" => "warehouse", "value" => 25, "type" => "number_integer"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 1063298220, "namespace" => "inventory", "key" => "warehouse", "value" => 25, "value_type" => "integer", "description" => nil, "owner_id" => 548380009, "created_at" => "2022-04-05T13:22:30-04:00", "updated_at" => "2022-04-05T13:22:30-04:00", "owner_resource" => "shop", "type" => "number_integer", "admin_graphql_api_id" => "gid://shopify/Metafield/1063298220"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.namespace = "inventory"
    metafield.key = "warehouse"
    metafield.value = 25
    metafield.type = "number_integer"
    metafield.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/metafields.json")
  end

  sig do
    void
  end
  def test_14()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/articles/674387490/metafields.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"namespace" => "my_fields", "key" => "category", "type" => "single_line_text_field", "value" => "outdoors"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 1063298221, "namespace" => "my_fields", "key" => "category", "value" => "outdoors", "value_type" => "string", "description" => nil, "owner_id" => 674387490, "created_at" => "2022-04-05T13:22:31-04:00", "updated_at" => "2022-04-05T13:22:31-04:00", "owner_resource" => "article", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/1063298221"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.article_id = 674387490
    metafield.namespace = "my_fields"
    metafield.key = "category"
    metafield.type = "single_line_text_field"
    metafield.value = "outdoors"
    metafield.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/articles/674387490/metafields.json")
  end

  sig do
    void
  end
  def test_15()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/blogs/382285388/metafields.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"namespace" => "my_fields", "key" => "sponsor", "type" => "single_line_text_field", "value" => "Shopify"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 1063298222, "namespace" => "my_fields", "key" => "sponsor", "value" => "Shopify", "value_type" => "string", "description" => nil, "owner_id" => 382285388, "created_at" => "2022-04-05T13:22:33-04:00", "updated_at" => "2022-04-05T13:22:33-04:00", "owner_resource" => "blog", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/1063298222"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.blog_id = 382285388
    metafield.namespace = "my_fields"
    metafield.key = "sponsor"
    metafield.type = "single_line_text_field"
    metafield.value = "Shopify"
    metafield.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/blogs/382285388/metafields.json")
  end

  sig do
    void
  end
  def test_16()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/collections/482865238/metafields.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"namespace" => "my_fields", "key" => "discount", "type" => "single_line_text_field", "value" => "25%"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 1063298223, "namespace" => "my_fields", "key" => "discount", "value" => "25%", "value_type" => "string", "description" => nil, "owner_id" => 482865238, "created_at" => "2022-04-05T13:22:34-04:00", "updated_at" => "2022-04-05T13:22:34-04:00", "owner_resource" => "collection", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/1063298223"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.collection_id = 482865238
    metafield.namespace = "my_fields"
    metafield.key = "discount"
    metafield.type = "single_line_text_field"
    metafield.value = "25%"
    metafield.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/collections/482865238/metafields.json")
  end

  sig do
    void
  end
  def test_17()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551/metafields.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"namespace" => "discounts", "key" => "special", "value" => "yes", "type" => "single_line_text_field"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 1063298224, "namespace" => "discounts", "key" => "special", "value" => "yes", "value_type" => "string", "description" => nil, "owner_id" => 207119551, "created_at" => "2022-04-05T13:22:35-04:00", "updated_at" => "2022-04-05T13:22:35-04:00", "owner_resource" => "customer", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/1063298224"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.customer_id = 207119551
    metafield.namespace = "discounts"
    metafield.key = "special"
    metafield.value = "yes"
    metafield.type = "single_line_text_field"
    metafield.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551/metafields.json")
  end

  sig do
    void
  end
  def test_18()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/622762746/metafields.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"namespace" => "my_fields", "key" => "purchase_order", "type" => "single_line_text_field", "value" => "97453"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 1063298225, "namespace" => "my_fields", "key" => "purchase_order", "value" => "97453", "value_type" => "string", "description" => nil, "owner_id" => 622762746, "created_at" => "2022-04-05T13:22:36-04:00", "updated_at" => "2022-04-05T13:22:36-04:00", "owner_resource" => "draft_order", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/1063298225"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.draft_order_id = 622762746
    metafield.namespace = "my_fields"
    metafield.key = "purchase_order"
    metafield.type = "single_line_text_field"
    metafield.value = "97453"
    metafield.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/622762746/metafields.json")
  end

  sig do
    void
  end
  def test_19()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/metafields.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"namespace" => "my_fields", "key" => "purchase_order", "type" => "single_line_text_field", "value" => "123"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 1063298226, "namespace" => "my_fields", "key" => "purchase_order", "value" => "123", "value_type" => "string", "description" => nil, "owner_id" => 450789469, "created_at" => "2022-04-05T13:22:38-04:00", "updated_at" => "2022-04-05T13:22:38-04:00", "owner_resource" => "order", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/1063298226"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.order_id = 450789469
    metafield.namespace = "my_fields"
    metafield.key = "purchase_order"
    metafield.type = "single_line_text_field"
    metafield.value = "123"
    metafield.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/metafields.json")
  end

  sig do
    void
  end
  def test_20()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/pages/131092082/metafields.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"namespace" => "my_fields", "key" => "subtitle", "type" => "single_line_text_field", "value" => "A subtitle for my page"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 1063298227, "namespace" => "my_fields", "key" => "subtitle", "value" => "A subtitle for my page", "value_type" => "string", "description" => nil, "owner_id" => 131092082, "created_at" => "2022-04-05T13:22:39-04:00", "updated_at" => "2022-04-05T13:22:39-04:00", "owner_resource" => "page", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/1063298227"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.page_id = 131092082
    metafield.namespace = "my_fields"
    metafield.key = "subtitle"
    metafield.type = "single_line_text_field"
    metafield.value = "A subtitle for my page"
    metafield.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/pages/131092082/metafields.json")
  end

  sig do
    void
  end
  def test_21()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/product_images/850703190/metafields.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"namespace" => "translaction", "key" => "title_spanish", "type" => "single_line_text_field", "value" => "botas"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 1063298228, "namespace" => "translaction", "key" => "title_spanish", "value" => "botas", "value_type" => "string", "description" => nil, "owner_id" => 850703190, "created_at" => "2022-04-05T13:22:40-04:00", "updated_at" => "2022-04-05T13:22:40-04:00", "owner_resource" => "product_image", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/1063298228"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.product_image_id = 850703190
    metafield.namespace = "translaction"
    metafield.key = "title_spanish"
    metafield.type = "single_line_text_field"
    metafield.value = "botas"
    metafield.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/product_images/850703190/metafields.json")
  end

  sig do
    void
  end
  def test_22()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/variants/49148385/metafields.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"namespace" => "my_fields", "key" => "liner_material", "type" => "single_line_text_field", "value" => "synthetic leather"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 1063298229, "namespace" => "my_fields", "key" => "liner_material", "value" => "synthetic leather", "value_type" => "string", "description" => nil, "owner_id" => 49148385, "created_at" => "2022-04-05T13:22:41-04:00", "updated_at" => "2022-04-05T13:22:41-04:00", "owner_resource" => "variant", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/1063298229"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.variant_id = 49148385
    metafield.namespace = "my_fields"
    metafield.key = "liner_material"
    metafield.type = "single_line_text_field"
    metafield.value = "synthetic leather"
    metafield.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/variants/49148385/metafields.json")
  end

  sig do
    void
  end
  def test_23()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/products/632910392/metafields.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"namespace" => "inventory", "key" => "warehouse", "value" => 25, "type" => "number_integer"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 1063298230, "namespace" => "inventory", "key" => "warehouse", "value" => 25, "value_type" => "integer", "description" => nil, "owner_id" => 632910392, "created_at" => "2022-04-05T13:22:42-04:00", "updated_at" => "2022-04-05T13:22:42-04:00", "owner_resource" => "product", "type" => "number_integer", "admin_graphql_api_id" => "gid://shopify/Metafield/1063298230"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.product_id = 632910392
    metafield.namespace = "inventory"
    metafield.key = "warehouse"
    metafield.value = 25
    metafield.type = "number_integer"
    metafield.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/products/632910392/metafields.json")
  end

  sig do
    void
  end
  def test_24()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    ShopifyAPI::Metafield.count()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/metafields/count.json")
  end

  sig do
    void
  end
  def test_25()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/articles/674387490/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 0}), headers: {})

    ShopifyAPI::Metafield.count(
      article_id: 674387490,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/articles/674387490/metafields/count.json")
  end

  sig do
    void
  end
  def test_26()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/blogs/382285388/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 0}), headers: {})

    ShopifyAPI::Metafield.count(
      blog_id: 382285388,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/blogs/382285388/metafields/count.json")
  end

  sig do
    void
  end
  def test_27()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/collections/482865238/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 3}), headers: {})

    ShopifyAPI::Metafield.count(
      collection_id: 482865238,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/collections/482865238/metafields/count.json")
  end

  sig do
    void
  end
  def test_28()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    ShopifyAPI::Metafield.count(
      customer_id: 207119551,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551/metafields/count.json")
  end

  sig do
    void
  end
  def test_29()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/622762746/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    ShopifyAPI::Metafield.count(
      draft_order_id: 622762746,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/622762746/metafields/count.json")
  end

  sig do
    void
  end
  def test_30()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    ShopifyAPI::Metafield.count(
      order_id: 450789469,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/metafields/count.json")
  end

  sig do
    void
  end
  def test_31()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/pages/131092082/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    ShopifyAPI::Metafield.count(
      page_id: 131092082,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/pages/131092082/metafields/count.json")
  end

  sig do
    void
  end
  def test_32()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/products/632910392/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 7}), headers: {})

    ShopifyAPI::Metafield.count(
      product_id: 632910392,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/products/632910392/metafields/count.json")
  end

  sig do
    void
  end
  def test_33()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/variants/49148385/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 0}), headers: {})

    ShopifyAPI::Metafield.count(
      variant_id: 49148385,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/variants/49148385/metafields/count.json")
  end

  sig do
    void
  end
  def test_34()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/product_images/850703190/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    ShopifyAPI::Metafield.count(
      product_image_id: 850703190,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/product_images/850703190/metafields/count.json")
  end

  sig do
    void
  end
  def test_35()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/metafields/721389482.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"value" => "something new", "type" => "single_line_text_field"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"value" => "something new", "value_type" => "string", "namespace" => "affiliates", "key" => "app_key", "id" => 721389482, "description" => nil, "owner_id" => 548380009, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:22:47-04:00", "owner_resource" => "shop", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/721389482"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.id = 721389482
    metafield.value = "something new"
    metafield.type = "single_line_text_field"
    metafield.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/metafields/721389482.json")
  end

  sig do
    void
  end
  def test_36()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/articles/674387490/metafields/838981074.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"value" => "a translated title", "type" => "single_line_text_field"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"value" => "a translated title", "value_type" => "string", "namespace" => "translation", "key" => "title_fr", "id" => 838981074, "description" => "Article French title translation", "owner_id" => 134645308, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:22:49-04:00", "owner_resource" => "article", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/838981074"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.article_id = 674387490
    metafield.id = 838981074
    metafield.value = "a translated title"
    metafield.type = "single_line_text_field"
    metafield.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/articles/674387490/metafields/838981074.json")
  end

  sig do
    void
  end
  def test_37()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/blogs/382285388/metafields/534526895.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"value" => "a translated blog title", "type" => "single_line_text_field"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"value" => "a translated blog title", "value_type" => "string", "namespace" => "translation", "key" => "title_fr", "id" => 534526895, "description" => "Blog French title translation", "owner_id" => 241253187, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:22:50-04:00", "owner_resource" => "blog", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/534526895"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.blog_id = 382285388
    metafield.id = 534526895
    metafield.value = "a translated blog title"
    metafield.type = "single_line_text_field"
    metafield.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/blogs/382285388/metafields/534526895.json")
  end

  sig do
    void
  end
  def test_38()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/collections/482865238/metafields/1010236510.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"value" => "seo title", "type" => "single_line_text_field"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"value" => "seo title", "value_type" => "string", "namespace" => "global", "key" => "title_tag", "id" => 1010236510, "description" => nil, "owner_id" => 482865238, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:22:51-04:00", "owner_resource" => "collection", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/1010236510"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.collection_id = 482865238
    metafield.id = 1010236510
    metafield.value = "seo title"
    metafield.type = "single_line_text_field"
    metafield.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/collections/482865238/metafields/1010236510.json")
  end

  sig do
    void
  end
  def test_39()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551/metafields/220591908.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"value" => "yes", "type" => "single_line_text_field"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"value" => "yes", "value_type" => "string", "namespace" => "discounts", "key" => "returning_customer", "id" => 220591908, "description" => "Customer deserves discount", "owner_id" => 207119551, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:22:52-04:00", "owner_resource" => "customer", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/220591908"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.customer_id = 207119551
    metafield.id = 220591908
    metafield.value = "yes"
    metafield.type = "single_line_text_field"
    metafield.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551/metafields/220591908.json")
  end

  sig do
    void
  end
  def test_40()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/622762746/metafields/106172460.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"value" => "110000", "type" => "single_line_text_field"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"value" => "110000", "value_type" => "string", "namespace" => "notes", "key" => "note", "id" => 106172460, "description" => "This is for notes", "owner_id" => 622762746, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:22:53-04:00", "owner_resource" => "draft_order", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/106172460"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.draft_order_id = 622762746
    metafield.id = 106172460
    metafield.value = "110000"
    metafield.type = "single_line_text_field"
    metafield.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/622762746/metafields/106172460.json")
  end

  sig do
    void
  end
  def test_41()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/metafields/915396079.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"value" => "Provided a discount code", "type" => "single_line_text_field"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"value" => "Provided a discount code", "value_type" => "string", "namespace" => "notes", "key" => "buyer", "id" => 915396079, "description" => "This field is for buyer notes", "owner_id" => 450789469, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:22:55-04:00", "owner_resource" => "order", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/915396079"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.order_id = 450789469
    metafield.id = 915396079
    metafield.value = "Provided a discount code"
    metafield.type = "single_line_text_field"
    metafield.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/metafields/915396079.json")
  end

  sig do
    void
  end
  def test_42()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/pages/131092082/metafields/290519330.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"value" => "An updated translation", "type" => "single_line_text_field"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"value" => "An updated translation", "value_type" => "string", "namespace" => "translation", "key" => "title_fr", "id" => 290519330, "description" => "Page French title translation", "owner_id" => 131092082, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:22:56-04:00", "owner_resource" => "page", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/290519330"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.page_id = 131092082
    metafield.id = 290519330
    metafield.value = "An updated translation"
    metafield.type = "single_line_text_field"
    metafield.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/pages/131092082/metafields/290519330.json")
  end

  sig do
    void
  end
  def test_43()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/products/632910392/metafields/1001077698.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"value" => "having fun", "type" => "single_line_text_field"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"value" => "having fun", "value_type" => "string", "namespace" => "my_fields", "key" => "best_for", "id" => 1001077698, "description" => nil, "owner_id" => 632910392, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:22:57-04:00", "owner_resource" => "product", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/1001077698"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.product_id = 632910392
    metafield.id = 1001077698
    metafield.value = "having fun"
    metafield.type = "single_line_text_field"
    metafield.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/products/632910392/metafields/1001077698.json")
  end

  sig do
    void
  end
  def test_44()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/variants/49148385/metafields/323119633.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"value" => "Red", "type" => "single_line_text_field"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"value" => "Red", "value_type" => "string", "namespace" => "my_fields", "key" => "color", "id" => 323119633, "description" => nil, "owner_id" => 808950810, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:22:58-04:00", "owner_resource" => "variant", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/323119633"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.variant_id = 49148385
    metafield.id = 323119633
    metafield.value = "Red"
    metafield.type = "single_line_text_field"
    metafield.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/variants/49148385/metafields/323119633.json")
  end

  sig do
    void
  end
  def test_45()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/product_images/850703190/metafields/625663657.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"value" => "translated description", "type" => "single_line_text_field"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"value" => "translated description", "value_type" => "string", "namespace" => "translation", "key" => "title_fr", "id" => 625663657, "description" => "French product image title", "owner_id" => 850703190, "created_at" => "2022-04-05T13:17:47-04:00", "updated_at" => "2022-04-05T13:22:59-04:00", "owner_resource" => "product_image", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/625663657"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.product_image_id = 850703190
    metafield.id = 625663657
    metafield.value = "translated description"
    metafield.type = "single_line_text_field"
    metafield.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/product_images/850703190/metafields/625663657.json")
  end

  sig do
    void
  end
  def test_46()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/metafields/721389482.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      id: 721389482,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/metafields/721389482.json")
  end

  sig do
    void
  end
  def test_47()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/articles/674387490/metafields/838981074.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      article_id: 674387490,
      id: 838981074,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/articles/674387490/metafields/838981074.json")
  end

  sig do
    void
  end
  def test_48()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/blogs/382285388/metafields/534526895.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      blog_id: 382285388,
      id: 534526895,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/blogs/382285388/metafields/534526895.json")
  end

  sig do
    void
  end
  def test_49()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/collections/482865238/metafields/1010236510.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      collection_id: 482865238,
      id: 1010236510,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/collections/482865238/metafields/1010236510.json")
  end

  sig do
    void
  end
  def test_50()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551/metafields/220591908.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      customer_id: 207119551,
      id: 220591908,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/customers/207119551/metafields/220591908.json")
  end

  sig do
    void
  end
  def test_51()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/622762746/metafields/106172460.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      draft_order_id: 622762746,
      id: 106172460,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/draft_orders/622762746/metafields/106172460.json")
  end

  sig do
    void
  end
  def test_52()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/metafields/915396079.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      order_id: 450789469,
      id: 915396079,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/orders/450789469/metafields/915396079.json")
  end

  sig do
    void
  end
  def test_53()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/pages/131092082/metafields/290519330.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      page_id: 131092082,
      id: 290519330,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/pages/131092082/metafields/290519330.json")
  end

  sig do
    void
  end
  def test_54()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/products/632910392/metafields/1001077698.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      product_id: 632910392,
      id: 1001077698,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/products/632910392/metafields/1001077698.json")
  end

  sig do
    void
  end
  def test_55()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/variants/49148385/metafields/323119633.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      variant_id: 49148385,
      id: 323119633,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/variants/49148385/metafields/323119633.json")
  end

  sig do
    void
  end
  def test_56()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/product_images/850703190/metafields/625663657.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      product_image_id: 850703190,
      id: 625663657,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/product_images/850703190/metafields/625663657.json")
  end

end
