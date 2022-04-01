# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class ResourceFeedback202204Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2022-04")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/resource_feedback.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "resource_feedback" => hash_including({"state" => "requires_action", "messages" => ["is not connected. Connect your account to use this sales channel."], "feedback_generated_at" => "2022-03-30T23:20:14.321460Z"}) }
      )
      .to_return(status: 200, body: JSON.generate({"resource_feedback" => {"created_at" => "2022-03-30T19:20:15-04:00", "updated_at" => "2022-03-30T19:20:15-04:00", "resource_id" => 548380009, "resource_type" => "Shop", "resource_updated_at" => nil, "messages" => ["is not connected. Connect your account to use this sales channel."], "feedback_generated_at" => "2022-03-30T19:20:14-04:00", "state" => "requires_action"}}), headers: {})

    resource_feedback = ShopifyAPI::ResourceFeedback.new
    resource_feedback.state = "requires_action"
    resource_feedback.messages = [
      "is not connected. Connect your account to use this sales channel."
    ]
    resource_feedback.feedback_generated_at = "2022-03-30T23:20:14.321460Z"
    resource_feedback.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/resource_feedback.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2022-04/resource_feedback.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "resource_feedback" => hash_including({"state" => "success", "feedback_generated_at" => "2022-03-30T23:20:15.395706Z"}) }
      )
      .to_return(status: 200, body: JSON.generate({"resource_feedback" => {"created_at" => "2022-03-30T19:20:16-04:00", "updated_at" => "2022-03-30T19:20:16-04:00", "resource_id" => 548380009, "resource_type" => "Shop", "resource_updated_at" => nil, "messages" => [], "feedback_generated_at" => "2022-03-30T19:20:15-04:00", "state" => "success"}}), headers: {})

    resource_feedback = ShopifyAPI::ResourceFeedback.new
    resource_feedback.state = "success"
    resource_feedback.feedback_generated_at = "2022-03-30T23:20:15.395706Z"
    resource_feedback.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2022-04/resource_feedback.json")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2022-04/resource_feedback.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"resource_feedback" => [{"created_at" => "2022-03-30T19:20:18-04:00", "updated_at" => "2022-03-30T19:20:18-04:00", "resource_id" => 548380009, "resource_type" => "Shop", "resource_updated_at" => nil, "messages" => ["is not connected. Connect your account to use this sales channel."], "feedback_generated_at" => "2022-03-30T18:20:18-04:00", "state" => "requires_action"}]}), headers: {})

    ShopifyAPI::ResourceFeedback.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2022-04/resource_feedback.json")
  end

end
