# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class DiscountCode202107Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-07")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175/discount_codes.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "discount_code" => hash_including({code: "SUMMERSALE10OFF"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    discount_code = ShopifyAPI::DiscountCode.new(session: @test_session)
    discount_code.price_rule_id = 507328175
    discount_code.code = "SUMMERSALE10OFF"
    discount_code.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175/discount_codes.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175/discount_codes.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::DiscountCode.all(
      session: @test_session,
      price_rule_id: 507328175,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175/discount_codes.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175/discount_codes/507328175.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "discount_code" => hash_including({id: 507328175, code: "WINTERSALE20OFF"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    discount_code = ShopifyAPI::DiscountCode.new(session: @test_session)
    discount_code.price_rule_id = 507328175
    discount_code.id = 507328175
    discount_code.code = "WINTERSALE20OFF"
    discount_code.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175/discount_codes/507328175.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175/discount_codes/507328175.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::DiscountCode.find(
      session: @test_session,
      price_rule_id: 507328175,
      id: 507328175,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175/discount_codes/507328175.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175/discount_codes/507328175.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::DiscountCode.delete(
      session: @test_session,
      price_rule_id: 507328175,
      id: 507328175,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175/discount_codes/507328175.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/discount_codes/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::DiscountCode.count(
      session: @test_session,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/discount_codes/count.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175/batch.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: hash_including({discount_codes: [{code: "SUMMER1"}, {code: "SUMMER2"}, {code: "SUMMER3"}]})
      )
      .to_return(status: 200, body: "{}", headers: {})

    discount_code = ShopifyAPI::DiscountCode.new(session: @test_session)
    discount_code.price_rule_id = 507328175
    discount_code.batch(
      body: {discount_codes: [{code: "SUMMER1"}, {code: "SUMMER2"}, {code: "SUMMER3"}]},
    )

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175/batch.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175/batch/173232803.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::DiscountCode.get_all(
      session: @test_session,
      price_rule_id: 507328175,
      batch_id: 173232803,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175/batch/173232803.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175/batch/173232803/discount_codes.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::DiscountCode.all(
      session: @test_session,
      price_rule_id: 507328175,
      batch_id: 173232803,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175/batch/173232803/discount_codes.json")
  end

end
