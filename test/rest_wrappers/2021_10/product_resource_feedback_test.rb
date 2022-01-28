# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class ProductResourceFeedback202110Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-10")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/products/632910392/resource_feedback.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: hash_including({resource_feedback: {state: "requires_action", messages: ["Needs at least one image."], resource_updated_at: "2022-01-06T15:16:43-05:00", feedback_generated_at: "2022-01-06T21:07:21.296824Z"}})
      )
      .to_return(status: 200, body: "{}", headers: {})

    product_resource_feedback = ShopifyAPI::ProductResourceFeedback.new(session: @test_session)
    product_resource_feedback.product_id = "632910392"
    product_resource_feedback.resource_feedback(
      body: {resource_feedback: {state: "requires_action", messages: ["Needs at least one image."], resource_updated_at: "2022-01-06T15:16:43-05:00", feedback_generated_at: "2022-01-06T21:07:21.296824Z"}},
    )

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/products/632910392/resource_feedback.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/products/632910392/resource_feedback.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: hash_including({resource_feedback: {state: "success", resource_updated_at: "2022-01-06T15:16:43-05:00", feedback_generated_at: "2022-01-06T21:07:22.256829Z"}})
      )
      .to_return(status: 200, body: "{}", headers: {})

    product_resource_feedback = ShopifyAPI::ProductResourceFeedback.new(session: @test_session)
    product_resource_feedback.product_id = "632910392"
    product_resource_feedback.resource_feedback(
      body: {resource_feedback: {state: "success", resource_updated_at: "2022-01-06T15:16:43-05:00", feedback_generated_at: "2022-01-06T21:07:22.256829Z"}},
    )

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/products/632910392/resource_feedback.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/products/632910392/resource_feedback.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::ProductResourceFeedback.resource_feedback(
      session: @test_session,
      product_id: "632910392",
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-10/products/632910392/resource_feedback.json")
  end

end
