# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class ResourceFeedback202107Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2021-07")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/resource_feedback.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "resource_feedback" => hash_including({state: "requires_action", messages: ["is not connected. Connect your account to use this sales channel."], feedback_generated_at: "2022-02-03T22:00:23.179942Z"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    resource_feedback = ShopifyAPI::ResourceFeedback.new
    resource_feedback.state = "requires_action"
    resource_feedback.messages = [
      "is not connected. Connect your account to use this sales channel."
    ]
    resource_feedback.feedback_generated_at = "2022-02-03T22:00:23.179942Z"
    resource_feedback.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/resource_feedback.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-07/resource_feedback.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "resource_feedback" => hash_including({state: "success", feedback_generated_at: "2022-02-03T22:00:24.490026Z"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    resource_feedback = ShopifyAPI::ResourceFeedback.new
    resource_feedback.state = "success"
    resource_feedback.feedback_generated_at = "2022-02-03T22:00:24.490026Z"
    resource_feedback.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-07/resource_feedback.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-07/resource_feedback.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::ResourceFeedback.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-07/resource_feedback.json")
  end

end
