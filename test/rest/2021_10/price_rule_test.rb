# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class PriceRule202110Test < Test::Unit::TestCase
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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-10/price_rules.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "price_rule" => hash_including({"title" => "SUMMERSALE10OFF", "target_type" => "line_item", "target_selection" => "all", "allocation_method" => "across", "value_type" => "fixed_amount", "value" => "-10.0", "customer_selection" => "all", "starts_at" => "2017-01-19T17:59:10Z"}) }
      )
      .to_return(status: 200, body: JSON.generate({"price_rule" => {"id" => 996341483, "value_type" => "fixed_amount", "value" => "-10.0", "customer_selection" => "all", "target_type" => "line_item", "target_selection" => "all", "allocation_method" => "across", "allocation_limit" => nil, "once_per_customer" => false, "usage_limit" => nil, "starts_at" => "2017-01-19T12:59:10-05:00", "ends_at" => nil, "created_at" => "2022-02-03T17:07:46-05:00", "updated_at" => "2022-02-03T17:07:46-05:00", "entitled_product_ids" => [], "entitled_variant_ids" => [], "entitled_collection_ids" => [], "entitled_country_ids" => [], "prerequisite_product_ids" => [], "prerequisite_variant_ids" => [], "prerequisite_collection_ids" => [], "prerequisite_saved_search_ids" => [], "prerequisite_customer_ids" => [], "prerequisite_subtotal_range" => nil, "prerequisite_quantity_range" => nil, "prerequisite_shipping_price_range" => nil, "prerequisite_to_entitlement_quantity_ratio" => {"prerequisite_quantity" => nil, "entitled_quantity" => nil}, "prerequisite_to_entitlement_purchase" => {"prerequisite_amount" => nil}, "title" => "SUMMERSALE10OFF", "admin_graphql_api_id" => "gid://shopify/PriceRule/996341483"}}), headers: {})

    price_rule = ShopifyAPI::PriceRule.new
    price_rule.title = "SUMMERSALE10OFF"
    price_rule.target_type = "line_item"
    price_rule.target_selection = "all"
    price_rule.allocation_method = "across"
    price_rule.value_type = "fixed_amount"
    price_rule.value = "-10.0"
    price_rule.customer_selection = "all"
    price_rule.starts_at = "2017-01-19T17:59:10Z"
    price_rule.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-10/price_rules.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-10/price_rules.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "price_rule" => hash_including({"title" => "15OFFCOLLECTION", "target_type" => "line_item", "target_selection" => "entitled", "allocation_method" => "across", "value_type" => "percentage", "value" => "-15.0", "customer_selection" => "all", "entitled_collection_ids" => [841564295], "starts_at" => "2017-01-19T17:59:10Z"}) }
      )
      .to_return(status: 200, body: JSON.generate({"price_rule" => {"id" => 996341484, "value_type" => "percentage", "value" => "-15.0", "customer_selection" => "all", "target_type" => "line_item", "target_selection" => "entitled", "allocation_method" => "across", "allocation_limit" => nil, "once_per_customer" => false, "usage_limit" => nil, "starts_at" => "2017-01-19T12:59:10-05:00", "ends_at" => nil, "created_at" => "2022-02-03T17:07:48-05:00", "updated_at" => "2022-02-03T17:07:48-05:00", "entitled_product_ids" => [], "entitled_variant_ids" => [], "entitled_collection_ids" => [841564295], "entitled_country_ids" => [], "prerequisite_product_ids" => [], "prerequisite_variant_ids" => [], "prerequisite_collection_ids" => [], "prerequisite_saved_search_ids" => [], "prerequisite_customer_ids" => [], "prerequisite_subtotal_range" => nil, "prerequisite_quantity_range" => nil, "prerequisite_shipping_price_range" => nil, "prerequisite_to_entitlement_quantity_ratio" => {"prerequisite_quantity" => nil, "entitled_quantity" => nil}, "prerequisite_to_entitlement_purchase" => {"prerequisite_amount" => nil}, "title" => "15OFFCOLLECTION", "admin_graphql_api_id" => "gid://shopify/PriceRule/996341484"}}), headers: {})

    price_rule = ShopifyAPI::PriceRule.new
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

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-10/price_rules.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-10/price_rules.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "price_rule" => hash_including({"title" => "FREESHIPPING", "target_type" => "shipping_line", "target_selection" => "all", "allocation_method" => "each", "value_type" => "percentage", "value" => "-100.0", "usage_limit" => 20, "customer_selection" => "all", "prerequisite_subtotal_range" => {"greater_than_or_equal_to" => "50.0"}, "starts_at" => "2017-01-19T17:59:10Z"}) }
      )
      .to_return(status: 200, body: JSON.generate({"price_rule" => {"id" => 996341485, "value_type" => "percentage", "value" => "-100.0", "customer_selection" => "all", "target_type" => "shipping_line", "target_selection" => "all", "allocation_method" => "each", "allocation_limit" => nil, "once_per_customer" => false, "usage_limit" => 20, "starts_at" => "2017-01-19T12:59:10-05:00", "ends_at" => nil, "created_at" => "2022-02-03T17:07:49-05:00", "updated_at" => "2022-02-03T17:07:49-05:00", "entitled_product_ids" => [], "entitled_variant_ids" => [], "entitled_collection_ids" => [], "entitled_country_ids" => [], "prerequisite_product_ids" => [], "prerequisite_variant_ids" => [], "prerequisite_collection_ids" => [], "prerequisite_saved_search_ids" => [], "prerequisite_customer_ids" => [], "prerequisite_subtotal_range" => {"greater_than_or_equal_to" => "50.0"}, "prerequisite_quantity_range" => nil, "prerequisite_shipping_price_range" => nil, "prerequisite_to_entitlement_quantity_ratio" => {"prerequisite_quantity" => nil, "entitled_quantity" => nil}, "prerequisite_to_entitlement_purchase" => {"prerequisite_amount" => nil}, "title" => "FREESHIPPING", "admin_graphql_api_id" => "gid://shopify/PriceRule/996341485"}}), headers: {})

    price_rule = ShopifyAPI::PriceRule.new
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

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-10/price_rules.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-10/price_rules.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "price_rule" => hash_including({"title" => "5OFFCUSTOMERGROUP", "target_type" => "line_item", "target_selection" => "all", "allocation_method" => "across", "value_type" => "fixed_amount", "value" => "-5.0", "customer_selection" => "prerequisite", "prerequisite_saved_search_ids" => [789629109], "starts_at" => "2017-01-19T17:59:10Z"}) }
      )
      .to_return(status: 200, body: JSON.generate({"price_rule" => {"id" => 996341486, "value_type" => "fixed_amount", "value" => "-5.0", "customer_selection" => "prerequisite", "target_type" => "line_item", "target_selection" => "all", "allocation_method" => "across", "allocation_limit" => nil, "once_per_customer" => false, "usage_limit" => nil, "starts_at" => "2017-01-19T12:59:10-05:00", "ends_at" => nil, "created_at" => "2022-02-03T17:07:50-05:00", "updated_at" => "2022-02-03T17:07:50-05:00", "entitled_product_ids" => [], "entitled_variant_ids" => [], "entitled_collection_ids" => [], "entitled_country_ids" => [], "prerequisite_product_ids" => [], "prerequisite_variant_ids" => [], "prerequisite_collection_ids" => [], "prerequisite_saved_search_ids" => [789629109], "prerequisite_customer_ids" => [], "prerequisite_subtotal_range" => nil, "prerequisite_quantity_range" => nil, "prerequisite_shipping_price_range" => nil, "prerequisite_to_entitlement_quantity_ratio" => {"prerequisite_quantity" => nil, "entitled_quantity" => nil}, "prerequisite_to_entitlement_purchase" => {"prerequisite_amount" => nil}, "title" => "5OFFCUSTOMERGROUP", "admin_graphql_api_id" => "gid://shopify/PriceRule/996341486"}}), headers: {})

    price_rule = ShopifyAPI::PriceRule.new
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

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-10/price_rules.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-10/price_rules.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "price_rule" => hash_including({"title" => "Buy2iPodsGetiPodTouchForFree", "value_type" => "percentage", "value" => "-100.0", "customer_selection" => "all", "target_type" => "line_item", "target_selection" => "entitled", "allocation_method" => "each", "starts_at" => "2018-03-22T00:00:00-00:00", "prerequisite_collection_ids" => [841564295], "entitled_product_ids" => [921728736], "prerequisite_to_entitlement_quantity_ratio" => {"prerequisite_quantity" => 2, "entitled_quantity" => 1}, "allocation_limit" => 3}) }
      )
      .to_return(status: 200, body: JSON.generate({"price_rule" => {"id" => 996341487, "value_type" => "percentage", "value" => "-100.0", "customer_selection" => "all", "target_type" => "line_item", "target_selection" => "entitled", "allocation_method" => "each", "allocation_limit" => 3, "once_per_customer" => false, "usage_limit" => nil, "starts_at" => "2018-03-21T20:00:00-04:00", "ends_at" => nil, "created_at" => "2022-02-03T17:07:52-05:00", "updated_at" => "2022-02-03T17:07:52-05:00", "entitled_product_ids" => [921728736], "entitled_variant_ids" => [], "entitled_collection_ids" => [], "entitled_country_ids" => [], "prerequisite_product_ids" => [], "prerequisite_variant_ids" => [], "prerequisite_collection_ids" => [841564295], "prerequisite_saved_search_ids" => [], "prerequisite_customer_ids" => [], "prerequisite_subtotal_range" => nil, "prerequisite_quantity_range" => nil, "prerequisite_shipping_price_range" => nil, "prerequisite_to_entitlement_quantity_ratio" => {"prerequisite_quantity" => 2, "entitled_quantity" => 1}, "prerequisite_to_entitlement_purchase" => {"prerequisite_amount" => nil}, "title" => "Buy2iPodsGetiPodTouchForFree", "admin_graphql_api_id" => "gid://shopify/PriceRule/996341487"}}), headers: {})

    price_rule = ShopifyAPI::PriceRule.new
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

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-10/price_rules.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/price_rules.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"price_rules" => [{"id" => 507328175, "value_type" => "fixed_amount", "value" => "-10.0", "customer_selection" => "all", "target_type" => "line_item", "target_selection" => "all", "allocation_method" => "across", "allocation_limit" => nil, "once_per_customer" => false, "usage_limit" => nil, "starts_at" => "2022-01-28T16:53:36-05:00", "ends_at" => "2022-02-09T16:53:36-05:00", "created_at" => "2022-02-03T16:53:36-05:00", "updated_at" => "2022-02-03T16:53:36-05:00", "entitled_product_ids" => [], "entitled_variant_ids" => [], "entitled_collection_ids" => [], "entitled_country_ids" => [], "prerequisite_product_ids" => [], "prerequisite_variant_ids" => [], "prerequisite_collection_ids" => [], "prerequisite_saved_search_ids" => [], "prerequisite_customer_ids" => [], "prerequisite_subtotal_range" => nil, "prerequisite_quantity_range" => nil, "prerequisite_shipping_price_range" => nil, "prerequisite_to_entitlement_quantity_ratio" => {"prerequisite_quantity" => nil, "entitled_quantity" => nil}, "title" => "SUMMERSALE10OFF", "admin_graphql_api_id" => "gid://shopify/PriceRule/507328175"}, {"id" => 106886544, "value_type" => "fixed_amount", "value" => "-10.0", "customer_selection" => "all", "target_type" => "line_item", "target_selection" => "all", "allocation_method" => "across", "allocation_limit" => nil, "once_per_customer" => false, "usage_limit" => nil, "starts_at" => "2022-02-01T16:53:36-05:00", "ends_at" => "2022-02-05T16:53:36-05:00", "created_at" => "2022-02-03T16:53:36-05:00", "updated_at" => "2022-02-03T16:53:36-05:00", "entitled_product_ids" => [], "entitled_variant_ids" => [], "entitled_collection_ids" => [], "entitled_country_ids" => [], "prerequisite_product_ids" => [], "prerequisite_variant_ids" => [], "prerequisite_collection_ids" => [], "prerequisite_saved_search_ids" => [], "prerequisite_customer_ids" => [], "prerequisite_subtotal_range" => nil, "prerequisite_quantity_range" => nil, "prerequisite_shipping_price_range" => nil, "prerequisite_to_entitlement_quantity_ratio" => {"prerequisite_quantity" => nil, "entitled_quantity" => nil}, "title" => "TENOFF", "admin_graphql_api_id" => "gid://shopify/PriceRule/106886544"}]}), headers: {})

    ShopifyAPI::PriceRule.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/price_rules.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-10/price_rules/507328175.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "price_rule" => hash_including({"id" => 507328175, "title" => "WINTER SALE"}) }
      )
      .to_return(status: 200, body: JSON.generate({"price_rule" => {"id" => 507328175, "value_type" => "fixed_amount", "value" => "-10.0", "customer_selection" => "all", "target_type" => "line_item", "target_selection" => "all", "allocation_method" => "across", "allocation_limit" => nil, "once_per_customer" => false, "usage_limit" => nil, "starts_at" => "2022-01-28T16:53:36-05:00", "ends_at" => "2022-02-09T16:53:36-05:00", "created_at" => "2022-02-03T16:53:36-05:00", "updated_at" => "2022-02-03T17:07:53-05:00", "entitled_product_ids" => [], "entitled_variant_ids" => [], "entitled_collection_ids" => [], "entitled_country_ids" => [], "prerequisite_product_ids" => [], "prerequisite_variant_ids" => [], "prerequisite_collection_ids" => [], "prerequisite_saved_search_ids" => [], "prerequisite_customer_ids" => [], "prerequisite_subtotal_range" => nil, "prerequisite_quantity_range" => nil, "prerequisite_shipping_price_range" => nil, "prerequisite_to_entitlement_quantity_ratio" => {"prerequisite_quantity" => nil, "entitled_quantity" => nil}, "prerequisite_to_entitlement_purchase" => {"prerequisite_amount" => nil}, "title" => "WINTER SALE", "admin_graphql_api_id" => "gid://shopify/PriceRule/507328175"}}), headers: {})

    price_rule = ShopifyAPI::PriceRule.new
    price_rule.id = 507328175
    price_rule.title = "WINTER SALE"
    price_rule.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-10/price_rules/507328175.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/price_rules/507328175.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"price_rule" => {"id" => 507328175, "value_type" => "fixed_amount", "value" => "-10.0", "customer_selection" => "all", "target_type" => "line_item", "target_selection" => "all", "allocation_method" => "across", "allocation_limit" => nil, "once_per_customer" => false, "usage_limit" => nil, "starts_at" => "2022-01-28T16:53:36-05:00", "ends_at" => "2022-02-09T16:53:36-05:00", "created_at" => "2022-02-03T16:53:36-05:00", "updated_at" => "2022-02-03T16:53:36-05:00", "entitled_product_ids" => [], "entitled_variant_ids" => [], "entitled_collection_ids" => [], "entitled_country_ids" => [], "prerequisite_product_ids" => [], "prerequisite_variant_ids" => [], "prerequisite_collection_ids" => [], "prerequisite_saved_search_ids" => [], "prerequisite_customer_ids" => [], "prerequisite_subtotal_range" => nil, "prerequisite_quantity_range" => nil, "prerequisite_shipping_price_range" => nil, "prerequisite_to_entitlement_quantity_ratio" => {"prerequisite_quantity" => nil, "entitled_quantity" => nil}, "prerequisite_to_entitlement_purchase" => {"prerequisite_amount" => nil}, "title" => "SUMMERSALE10OFF", "admin_graphql_api_id" => "gid://shopify/PriceRule/507328175"}}), headers: {})

    ShopifyAPI::PriceRule.find(
      id: 507328175,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/price_rules/507328175.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-10/price_rules/507328175.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::PriceRule.delete(
      id: 507328175,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-10/price_rules/507328175.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/price_rules/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 2}), headers: {})

    ShopifyAPI::PriceRule.count()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/price_rules/count.json")
  end

end
