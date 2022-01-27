# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Variant202107Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-07")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/products/632910392/variants.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Variant.all(
      session: @test_session,
      product_id: "632910392",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/products/632910392/variants.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/products/632910392/variants.json?since_id=49148385")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Variant.all(
      session: @test_session,
      product_id: "632910392",
      since_id: "49148385",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/products/632910392/variants.json?since_id=49148385")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/products/632910392/variants.json?presentment_currencies=USD%2CCAD")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Variant.all(
      session: @test_session,
      product_id: "632910392",
      presentment_currencies: "USD,CAD",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/products/632910392/variants.json?presentment_currencies=USD%2CCAD")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/products/632910392/variants.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "variant" => hash_including({option1: "Yellow", price: "1.00"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    variant = ShopifyAPI::Variant.new(session: @test_session)
    variant.product_id = 632910392
    variant.option1 = "Yellow"
    variant.price = "1.00"
    variant.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/products/632910392/variants.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/products/632910392/variants.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "variant" => hash_including({image_id: 850703190, option1: "Purple"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    variant = ShopifyAPI::Variant.new(session: @test_session)
    variant.product_id = 632910392
    variant.image_id = 850703190
    variant.option1 = "Purple"
    variant.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/products/632910392/variants.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/products/632910392/variants.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "variant" => hash_including({option1: "Blue", metafields: [{key: "new", value: "newvalue", type: "single_line_text_field", namespace: "global"}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    variant = ShopifyAPI::Variant.new(session: @test_session)
    variant.product_id = 632910392
    variant.option1 = "Blue"
    variant.metafields = [
      {
        key: "new",
        value: "newvalue",
        type: "single_line_text_field",
        namespace: "global"
      }
    ]
    variant.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/products/632910392/variants.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/products/632910392/variants/count.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Variant.count(
      session: @test_session,
      product_id: "632910392",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/products/632910392/variants/count.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/variants/808950810.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Variant.find(
      session: @test_session,
      id: "808950810",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/variants/808950810.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/variants/808950810.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "variant" => hash_including({id: 808950810, option1: "Not Pink", price: "99.00"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    variant = ShopifyAPI::Variant.new(session: @test_session)
    variant.id = 808950810
    variant.option1 = "Not Pink"
    variant.price = "99.00"
    variant.save()

    assert_requested(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/variants/808950810.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/variants/808950810.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "variant" => hash_including({id: 808950810, image_id: 562641783}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    variant = ShopifyAPI::Variant.new(session: @test_session)
    variant.id = 808950810
    variant.image_id = 562641783
    variant.save()

    assert_requested(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/variants/808950810.json")
  end

  sig do
    void
  end
  def test_11()
    stub_request(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/variants/808950810.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "variant" => hash_including({id: 808950810, metafields: [{key: "new", value: "newvalue", type: "single_line_text_field", namespace: "global"}]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    variant = ShopifyAPI::Variant.new(session: @test_session)
    variant.id = 808950810
    variant.metafields = [
      {
        key: "new",
        value: "newvalue",
        type: "single_line_text_field",
        namespace: "global"
      }
    ]
    variant.save()

    assert_requested(:put, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/variants/808950810.json")
  end

  sig do
    void
  end
  def test_12()
    stub_request(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/products/632910392/variants/808950810.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Variant.delete(
      session: @test_session,
      product_id: "632910392",
      id: "808950810",
    )

    assert_requested(:delete, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-07/products/632910392/variants/808950810.json")
  end

end
