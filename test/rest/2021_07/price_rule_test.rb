# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class PriceRule202107Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-07")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "price_rule" => hash_including({"title" => "SUMMERSALE10OFF", "target_type" => "line_item", "target_selection" => "all", "allocation_method" => "across", "value_type" => "fixed_amount", "value" => "-10.0", "customer_selection" => "all", "starts_at" => "2017-01-19T17:59:10Z"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    price_rule = ShopifyAPI::PriceRule.new(session: @test_session)
    price_rule.title = "SUMMERSALE10OFF"
    price_rule.target_type = "line_item"
    price_rule.target_selection = "all"
    price_rule.allocation_method = "across"
    price_rule.value_type = "fixed_amount"
    price_rule.value = "-10.0"
    price_rule.customer_selection = "all"
    price_rule.starts_at = "2017-01-19T17:59:10Z"
    price_rule.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "price_rule" => hash_including({"title" => "15OFFCOLLECTION", "target_type" => "line_item", "target_selection" => "entitled", "allocation_method" => "across", "value_type" => "percentage", "value" => "-15.0", "customer_selection" => "all", "entitled_collection_ids" => [841564295], "starts_at" => "2017-01-19T17:59:10Z"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    price_rule = ShopifyAPI::PriceRule.new(session: @test_session)
    price_rule.title = "15OFFCOLLECTION"
    price_rule.target_type = "line_item"
    price_rule.target_selection = "entitled"
    price_rule.allocation_method = "across"
    price_rule.value_type = "percentage"
    price_rule.value = "-15.0"
    price_rule.customer_selection = "all"
    price_rule.entitled_collection_ids = [
      841564295
    ]
    price_rule.starts_at = "2017-01-19T17:59:10Z"
    price_rule.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "price_rule" => hash_including({"title" => "FREESHIPPING", "target_type" => "shipping_line", "target_selection" => "all", "allocation_method" => "each", "value_type" => "percentage", "value" => "-100.0", "usage_limit" => 20, "customer_selection" => "all", "prerequisite_subtotal_range" => {"greater_than_or_equal_to" => "50.0"}, "starts_at" => "2017-01-19T17:59:10Z"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    price_rule = ShopifyAPI::PriceRule.new(session: @test_session)
    price_rule.title = "FREESHIPPING"
    price_rule.target_type = "shipping_line"
    price_rule.target_selection = "all"
    price_rule.allocation_method = "each"
    price_rule.value_type = "percentage"
    price_rule.value = "-100.0"
    price_rule.usage_limit = 20
    price_rule.customer_selection = "all"
    price_rule.prerequisite_subtotal_range = {
      "greater_than_or_equal_to" => "50.0"
    }
    price_rule.starts_at = "2017-01-19T17:59:10Z"
    price_rule.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "price_rule" => hash_including({"title" => "5OFFCUSTOMERGROUP", "target_type" => "line_item", "target_selection" => "all", "allocation_method" => "across", "value_type" => "fixed_amount", "value" => "-5.0", "customer_selection" => "prerequisite", "prerequisite_saved_search_ids" => [789629109], "starts_at" => "2017-01-19T17:59:10Z"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    price_rule = ShopifyAPI::PriceRule.new(session: @test_session)
    price_rule.title = "5OFFCUSTOMERGROUP"
    price_rule.target_type = "line_item"
    price_rule.target_selection = "all"
    price_rule.allocation_method = "across"
    price_rule.value_type = "fixed_amount"
    price_rule.value = "-5.0"
    price_rule.customer_selection = "prerequisite"
    price_rule.prerequisite_saved_search_ids = [
      789629109
    ]
    price_rule.starts_at = "2017-01-19T17:59:10Z"
    price_rule.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "price_rule" => hash_including({"title" => "Buy2iPodsGetiPodTouchForFree", "value_type" => "percentage", "value" => "-100.0", "customer_selection" => "all", "target_type" => "line_item", "target_selection" => "entitled", "allocation_method" => "each", "starts_at" => "2018-03-22T00:00:00-00:00", "prerequisite_collection_ids" => [841564295], "entitled_product_ids" => [921728736], "prerequisite_to_entitlement_quantity_ratio" => {"prerequisite_quantity" => 2, "entitled_quantity" => 1}, "allocation_limit" => 3}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    price_rule = ShopifyAPI::PriceRule.new(session: @test_session)
    price_rule.title = "Buy2iPodsGetiPodTouchForFree"
    price_rule.value_type = "percentage"
    price_rule.value = "-100.0"
    price_rule.customer_selection = "all"
    price_rule.target_type = "line_item"
    price_rule.target_selection = "entitled"
    price_rule.allocation_method = "each"
    price_rule.starts_at = "2018-03-22T00:00:00-00:00"
    price_rule.prerequisite_collection_ids = [
      841564295
    ]
    price_rule.entitled_product_ids = [
      921728736
    ]
    price_rule.prerequisite_to_entitlement_quantity_ratio = {
      "prerequisite_quantity" => 2,
      "entitled_quantity" => 1
    }
    price_rule.allocation_limit = 3
    price_rule.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::PriceRule.all(
      session: @test_session,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "price_rule" => hash_including({"id" => 507328175, "title" => "WINTER SALE"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    price_rule = ShopifyAPI::PriceRule.new(session: @test_session)
    price_rule.id = 507328175
    price_rule.title = "WINTER SALE"
    price_rule.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::PriceRule.find(
      session: @test_session,
      id: 507328175,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::PriceRule.delete(
      session: @test_session,
      id: 507328175,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/507328175.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::PriceRule.count(
      session: @test_session,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/price_rules/count.json")
  end

end
