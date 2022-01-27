# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class ResourceFeedback202104Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "this-is-a-test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-04")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-04/resource_feedback.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "resource_feedback" => hash_including({state: "success", feedback_generated_at: "2022-01-06T21:43:55.995092Z"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    resource_feedback = ShopifyAPI::ResourceFeedback.new(session: @test_session)
    resource_feedback.state = "success"
    resource_feedback.feedback_generated_at = "2022-01-06T21:43:55.995092Z"
    resource_feedback.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-04/resource_feedback.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-04/resource_feedback.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token", "Content-Type"=>"application/json"},
        body: { "resource_feedback" => hash_including({state: "requires_action", messages: ["is not connected. Connect your account to use this sales channel."], feedback_generated_at: "2022-01-06T21:43:59.759379Z"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    resource_feedback = ShopifyAPI::ResourceFeedback.new(session: @test_session)
    resource_feedback.state = "requires_action"
    resource_feedback.messages = [
      "is not connected. Connect your account to use this sales channel."
    ]
    resource_feedback.feedback_generated_at = "2022-01-06T21:43:59.759379Z"
    resource_feedback.save()

    assert_requested(:post, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-04/resource_feedback.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-04/resource_feedback.json")
      .with(
        headers: {"Accept"=>"application/json", "X-Shopify-Access-Token"=>"this_is_a_test_token"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::ResourceFeedback.all(
      session: @test_session,
    )

    assert_requested(:get, "https://this-is-a-test-shop.myshopify.io/admin/api/2021-04/resource_feedback.json")
  end

end
