# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class ProductResourceFeedback202104Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-04")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392/resource_feedback.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "resource_feedback" => hash_including({"state" => "requires_action", "messages" => ["Needs at least one image."], "resource_updated_at" => "2022-02-03T16:53:36-05:00", "feedback_generated_at" => "2022-02-03T22:11:14.477009Z"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    product_resource_feedback = ShopifyAPI::ProductResourceFeedback.new(session: @test_session)
    product_resource_feedback.product_id = 632910392
    product_resource_feedback.state = "requires_action"
    product_resource_feedback.messages = [
      "Needs at least one image."
    ]
    product_resource_feedback.resource_updated_at = "2022-02-03T16:53:36-05:00"
    product_resource_feedback.feedback_generated_at = "2022-02-03T22:11:14.477009Z"
    product_resource_feedback.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392/resource_feedback.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392/resource_feedback.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "resource_feedback" => hash_including({"state" => "success", "resource_updated_at" => "2022-02-03T16:53:36-05:00", "feedback_generated_at" => "2022-02-03T22:11:15.898793Z"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    product_resource_feedback = ShopifyAPI::ProductResourceFeedback.new(session: @test_session)
    product_resource_feedback.product_id = 632910392
    product_resource_feedback.state = "success"
    product_resource_feedback.resource_updated_at = "2022-02-03T16:53:36-05:00"
    product_resource_feedback.feedback_generated_at = "2022-02-03T22:11:15.898793Z"
    product_resource_feedback.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392/resource_feedback.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392/resource_feedback.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::ProductResourceFeedback.all(
      session: @test_session,
      product_id: 632910392,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-04/products/632910392/resource_feedback.json")
  end

end
