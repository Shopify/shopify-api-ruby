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

class Collect202304Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2023-04")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-04/collects.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "collect" => hash_including({"product_id" => 921728736, "collection_id" => 841564295}) }
      )
      .to_return(status: 200, body: JSON.generate({"collect" => {"id" => 1071559579, "collection_id" => 841564295, "product_id" => 921728736, "created_at" => "2023-02-02T09:37:22-05:00", "updated_at" => "2023-02-02T09:37:22-05:00", "position" => 2, "sort_value" => "0000000002"}}), headers: {})

    collect = ShopifyAPI::Collect.new
    collect.product_id = 921728736
    collect.collection_id = 841564295
    collect.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-04/collects.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/collects.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"collects" => [{"id" => 358268117, "collection_id" => 482865238, "product_id" => 632910392, "created_at" => nil, "updated_at" => nil, "position" => 1, "sort_value" => "0000000001"}, {"id" => 455204334, "collection_id" => 841564295, "product_id" => 632910392, "created_at" => nil, "updated_at" => nil, "position" => 1, "sort_value" => "0000000001"}, {"id" => 773559378, "collection_id" => 395646240, "product_id" => 632910392, "created_at" => nil, "updated_at" => nil, "position" => 1, "sort_value" => "0000000001"}, {"id" => 800915878, "collection_id" => 482865238, "product_id" => 921728736, "created_at" => nil, "updated_at" => nil, "position" => 1, "sort_value" => "0000000001"}]}), headers: {})

    ShopifyAPI::Collect.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/collects.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/collects.json?collection_id=841564295")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"collects" => [{"id" => 455204334, "collection_id" => 841564295, "product_id" => 632910392, "created_at" => nil, "updated_at" => nil, "position" => 1, "sort_value" => "0000000001"}, {"id" => 1071559580, "collection_id" => 841564295, "product_id" => 921728736, "created_at" => "2023-02-02T09:37:24-05:00", "updated_at" => "2023-02-02T09:37:24-05:00", "position" => 2, "sort_value" => "0000000002"}]}), headers: {})

    ShopifyAPI::Collect.all(
      collection_id: "841564295",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/collects.json?collection_id=841564295")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/collects.json?product_id=632910392")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"collects" => [{"id" => 358268117, "collection_id" => 482865238, "product_id" => 632910392, "created_at" => nil, "updated_at" => nil, "position" => 1, "sort_value" => "0000000001"}, {"id" => 455204334, "collection_id" => 841564295, "product_id" => 632910392, "created_at" => nil, "updated_at" => nil, "position" => 1, "sort_value" => "0000000001"}, {"id" => 773559378, "collection_id" => 395646240, "product_id" => 632910392, "created_at" => nil, "updated_at" => nil, "position" => 1, "sort_value" => "0000000001"}]}), headers: {})

    ShopifyAPI::Collect.all(
      product_id: "632910392",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/collects.json?product_id=632910392")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2023-04/collects/455204334.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    ShopifyAPI::Collect.delete(
      id: 455204334,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2023-04/collects/455204334.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/collects/455204334.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"collect" => {"id" => 455204334, "collection_id" => 841564295, "product_id" => 632910392, "created_at" => nil, "updated_at" => nil, "position" => 1, "sort_value" => "0000000001"}}), headers: {})

    ShopifyAPI::Collect.find(
      id: 455204334,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/collects/455204334.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/collects/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 2}), headers: {})

    ShopifyAPI::Collect.count

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/collects/count.json")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/collects/count.json?collection_id=841564295")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    ShopifyAPI::Collect.count(
      collection_id: "841564295",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/collects/count.json?collection_id=841564295")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-04/collects/count.json?product_id=632910392")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 2}), headers: {})

    ShopifyAPI::Collect.count(
      product_id: "632910392",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-04/collects/count.json?product_id=632910392")
  end

end
