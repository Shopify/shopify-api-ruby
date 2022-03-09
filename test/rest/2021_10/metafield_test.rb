# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Metafield202110Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2021-10")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/metafields.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => [{"id" => 721389482, "namespace" => "affiliates", "key" => "app_key", "value" => "app_key", "value_type" => "string", "description" => nil, "owner_id" => 548380009, "created_at" => "2022-02-03T16:53:36-05:00", "updated_at" => "2022-02-03T16:53:36-05:00", "owner_resource" => "shop", "type" => "string", "admin_graphql_api_id" => "gid://shopify/Metafield/721389482"}]}), headers: {})

    ShopifyAPI::Metafield.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/metafields.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/metafields.json?since_id=721389482")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => [{"id" => 1063298241, "namespace" => "inventory", "key" => "warehouse", "value" => 25, "value_type" => "integer", "description" => nil, "owner_id" => 548380009, "created_at" => "2022-02-03T17:01:04-05:00", "updated_at" => "2022-02-03T17:01:04-05:00", "owner_resource" => "shop", "type" => "number_integer", "admin_graphql_api_id" => "gid://shopify/Metafield/1063298241"}]}), headers: {})

    ShopifyAPI::Metafield.all(
      since_id: "721389482",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/metafields.json?since_id=721389482")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-10/metafields.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"namespace" => "inventory", "key" => "warehouse", "value" => 25, "type" => "number_integer"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 1063298244, "namespace" => "inventory", "key" => "warehouse", "value" => 25, "value_type" => "integer", "description" => nil, "owner_id" => 548380009, "created_at" => "2022-02-03T17:01:25-05:00", "updated_at" => "2022-02-03T17:01:25-05:00", "owner_resource" => "shop", "type" => "number_integer", "admin_graphql_api_id" => "gid://shopify/Metafield/1063298244"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.namespace = "inventory"
    metafield.key = "warehouse"
    metafield.value = 25
    metafield.type = "number_integer"
    metafield.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-10/metafields.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/metafields.json?metafield%5Bowner_id%5D=850703190&metafield%5Bowner_resource%5D=product_image")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafields" => [{"id" => 625663657, "namespace" => "translation", "key" => "title_fr", "value" => "tbn", "description" => "French product image title", "owner_id" => 850703190, "created_at" => "2022-02-03T16:53:36-05:00", "updated_at" => "2022-02-03T16:53:36-05:00", "owner_resource" => "product_image", "type" => "string", "admin_graphql_api_id" => "gid://shopify/Metafield/625663657"}]}), headers: {})

    ShopifyAPI::Metafield.all(
      metafield: {"owner_id" => "850703190", "owner_resource" => "product_image"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/metafields.json?metafield%5Bowner_id%5D=850703190&metafield%5Bowner_resource%5D=product_image")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    ShopifyAPI::Metafield.count()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/metafields/count.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/metafields/721389482.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"id" => 721389482, "namespace" => "affiliates", "key" => "app_key", "value" => "app_key", "value_type" => "string", "description" => nil, "owner_id" => 548380009, "created_at" => "2022-02-03T16:53:36-05:00", "updated_at" => "2022-02-03T16:53:36-05:00", "owner_resource" => "shop", "type" => "string", "admin_graphql_api_id" => "gid://shopify/Metafield/721389482"}}), headers: {})

    ShopifyAPI::Metafield.find(
      id: 721389482,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/metafields/721389482.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-10/metafields/721389482.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({"id" => 721389482, "value" => "something new", "type" => "single_line_text_field"}) }
      )
      .to_return(status: 200, body: JSON.generate({"metafield" => {"value" => "something new", "value_type" => "string", "namespace" => "affiliates", "key" => "app_key", "id" => 721389482, "description" => nil, "owner_id" => 548380009, "created_at" => "2022-02-03T16:53:36-05:00", "updated_at" => "2022-02-03T17:01:32-05:00", "owner_resource" => "shop", "type" => "single_line_text_field", "admin_graphql_api_id" => "gid://shopify/Metafield/721389482"}}), headers: {})

    metafield = ShopifyAPI::Metafield.new
    metafield.id = 721389482
    metafield.value = "something new"
    metafield.type = "single_line_text_field"
    metafield.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-10/metafields/721389482.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-10/metafields/721389482.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Metafield.delete(
      id: 721389482,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-10/metafields/721389482.json")
  end

end
