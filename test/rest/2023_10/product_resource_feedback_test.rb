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

class ProductResourceFeedback202310Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2023-10")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-10/products/632910392/resource_feedback.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "resource_feedback" => hash_including({"state" => "requires_action", "messages" => ["Needs at least one image."], "resource_updated_at" => "2023-10-03T13:19:52-04:00", "feedback_generated_at" => "2023-10-03T17:33:45.394311Z"}) }
      )
      .to_return(status: 200, body: JSON.generate({"resource_feedback" => {"created_at" => "2023-10-03T13:33:45-04:00", "updated_at" => "2023-10-03T13:33:45-04:00", "resource_id" => 632910392, "resource_type" => "Product", "resource_updated_at" => "2023-10-03T13:19:52-04:00", "messages" => ["Needs at least one image."], "feedback_generated_at" => "2023-10-03T13:33:45-04:00", "state" => "requires_action"}}), headers: {})

    response = product_resource_feedback = ShopifyAPI::ProductResourceFeedback.new
    product_resource_feedback.product_id = 632910392
    product_resource_feedback.state = "requires_action"
    product_resource_feedback.messages = [
      "Needs at least one image."
    ]
    product_resource_feedback.resource_updated_at = "2023-10-03T13:19:52-04:00"
    product_resource_feedback.feedback_generated_at = "2023-10-03T17:33:45.394311Z"
    product_resource_feedback.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-10/products/632910392/resource_feedback.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_2()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-10/products/632910392/resource_feedback.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "resource_feedback" => hash_including({"state" => "success", "resource_updated_at" => "2023-10-03T13:19:52-04:00", "feedback_generated_at" => "2023-10-03T17:33:42.337822Z"}) }
      )
      .to_return(status: 200, body: JSON.generate({"resource_feedback" => {"created_at" => "2023-10-03T13:33:42-04:00", "updated_at" => "2023-10-03T13:33:42-04:00", "resource_id" => 632910392, "resource_type" => "Product", "resource_updated_at" => "2023-10-03T13:19:52-04:00", "messages" => [], "feedback_generated_at" => "2023-10-03T13:33:42-04:00", "state" => "success"}}), headers: {})

    response = product_resource_feedback = ShopifyAPI::ProductResourceFeedback.new
    product_resource_feedback.product_id = 632910392
    product_resource_feedback.state = "success"
    product_resource_feedback.resource_updated_at = "2023-10-03T13:19:52-04:00"
    product_resource_feedback.feedback_generated_at = "2023-10-03T17:33:42.337822Z"
    product_resource_feedback.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-10/products/632910392/resource_feedback.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

  sig do
    void
  end
  def test_3()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-10/products/632910392/resource_feedback.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"resource_feedback" => [{"created_at" => "2023-10-03T13:33:42-04:00", "updated_at" => "2023-10-03T13:33:42-04:00", "resource_id" => 632910392, "resource_type" => "Product", "resource_updated_at" => "2023-10-03T13:19:52-04:00", "messages" => ["Needs at least one image."], "feedback_generated_at" => "2023-10-03T12:33:42-04:00", "state" => "requires_action"}]}), headers: {})

    response = ShopifyAPI::ProductResourceFeedback.all(
      product_id: 632910392,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-10/products/632910392/resource_feedback.json")

    response = response.first if response.respond_to?(:first)

    # Assert attributes are correctly typed preventing Sorbet errors downstream
    if response.respond_to?(:original_state)
      response&.original_state&.each do |key, value|
        begin
          response.send(key)
        rescue TypeError => error
          fail TypeError.new("#{self.class}##{key} is mistyped: #{error.message}")
        end
        response.send(key)
      end
    end
  end

end
