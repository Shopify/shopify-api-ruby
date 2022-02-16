# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Metafield202104Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-04")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/metafields.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Metafield.all(
      session: @test_session,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/metafields.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/metafields.json?since_id=721389482")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Metafield.all(
      session: @test_session,
      since_id: "721389482",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/metafields.json?since_id=721389482")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/metafields.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({namespace: "inventory", key: "warehouse", value: 25, type: "number_integer", value_type: "integer"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    metafield = ShopifyAPI::Metafield.new(session: @test_session)
    metafield.namespace = "inventory"
    metafield.key = "warehouse"
    metafield.value = 25
    metafield.type = "number_integer"
    metafield.value_type = "integer"
    metafield.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/metafields.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/metafields.json?metafield%5Bowner_id%5D=850703190&metafield%5Bowner_resource%5D=product_image")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Metafield.all(
      session: @test_session,
      metafield: {"owner_id" => 850703190, "owner_resource" => "product_image"},
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/metafields.json?metafield%5Bowner_id%5D=850703190&metafield%5Bowner_resource%5D=product_image")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/metafields/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Metafield.count(
      session: @test_session,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/metafields/count.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/metafields/721389482.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Metafield.find(
      session: @test_session,
      id: 721389482,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/metafields/721389482.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-04/metafields/721389482.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "metafield" => hash_including({id: 721389482, value: "something new", type: "single_line_text_field", value_type: "string"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    metafield = ShopifyAPI::Metafield.new(session: @test_session)
    metafield.id = 721389482
    metafield.value = "something new"
    metafield.type = "single_line_text_field"
    metafield.value_type = "string"
    metafield.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-04/metafields/721389482.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-04/metafields/721389482.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Metafield.delete(
      session: @test_session,
      id: 721389482,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-04/metafields/721389482.json")
  end

end
