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

class Webhook202310Test < Test::Unit::TestCase
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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-10/webhooks.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"webhooks" => [{"id" => 4759306, "address" => "https://apple.com", "topic" => "orders/create", "created_at" => "2023-10-10T11:30:21-04:00", "updated_at" => "2023-10-10T11:30:21-04:00", "format" => "json", "fields" => [], "metafield_namespaces" => [], "api_version" => "unstable", "private_metafield_namespaces" => []}, {"id" => 892403750, "address" => "https://example.org/fully_loaded_1", "topic" => "orders/cancelled", "created_at" => "2021-12-01T05:23:43-05:00", "updated_at" => "2021-12-01T05:23:43-05:00", "format" => "json", "fields" => [], "metafield_namespaces" => [], "api_version" => "unstable", "private_metafield_namespaces" => []}, {"id" => 901431826, "address" => "https://apple.com/uninstall", "topic" => "app/uninstalled", "created_at" => "2023-10-10T11:30:21-04:00", "updated_at" => "2023-10-10T11:30:21-04:00", "format" => "json", "fields" => [], "metafield_namespaces" => [], "api_version" => "unstable", "private_metafield_namespaces" => []}, {"id" => 1014196360, "address" => "https://example.org/app_uninstalled", "topic" => "app/uninstalled", "created_at" => "2023-10-10T11:30:21-04:00", "updated_at" => "2023-10-10T11:30:21-04:00", "format" => "json", "fields" => [], "metafield_namespaces" => [], "api_version" => "unstable", "private_metafield_namespaces" => []}]}), headers: {})

    response = ShopifyAPI::Webhook.all

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-10/webhooks.json")

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
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-10/webhooks.json?since_id=901431826")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"webhooks" => [{"id" => 1014196360, "address" => "https://example.org/app_uninstalled", "topic" => "app/uninstalled", "created_at" => "2023-10-10T11:30:21-04:00", "updated_at" => "2023-10-10T11:30:21-04:00", "format" => "json", "fields" => [], "metafield_namespaces" => [], "api_version" => "unstable", "private_metafield_namespaces" => []}]}), headers: {})

    response = ShopifyAPI::Webhook.all(
      since_id: "901431826",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-10/webhooks.json?since_id=901431826")

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
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-10/webhooks.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "webhook" => hash_including({"address" => "pubsub://projectName:topicName", "topic" => "customers/update", "format" => "json"}) }
      )
      .to_return(status: 200, body: JSON.generate({"webhook" => {"id" => 6908876587, "address" => "pubsub://projectName:topicName", "topic" => "customers/update", "created_at" => "2023-10-10T11:58:56-04:00", "updated_at" => "2023-10-10T11:58:56-04:00", "format" => "json", "fields" => [], "metafield_namespaces" => [], "api_version" => "unstable", "private_metafield_namespaces" => []}}), headers: {})

    response = webhook = ShopifyAPI::Webhook.new
    webhook.address = "pubsub://projectName:topicName"
    webhook.topic = "customers/update"
    webhook.format = "json"
    webhook.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-10/webhooks.json")

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
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-10/webhooks.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "webhook" => hash_including({"address" => "arn:aws:events:us-east-1::event-source/aws.partner/shopify.com/755357713/example-event-source", "topic" => "customers/update", "format" => "json"}) }
      )
      .to_return(status: 200, body: JSON.generate({"webhook" => {"id" => 6908876549, "address" => "arn:aws:events:us-east-1::event-source/aws.partner/shopify.com/755357713/example-event-source", "topic" => "customers/update", "created_at" => "2023-10-10T11:56:50-04:00", "updated_at" => "2023-10-10T11:56:50-04:00", "format" => "json", "fields" => [], "metafield_namespaces" => [], "api_version" => "unstable", "private_metafield_namespaces" => []}}), headers: {})

    response = webhook = ShopifyAPI::Webhook.new
    webhook.address = "arn:aws:events:us-east-1::event-source/aws.partner/shopify.com/755357713/example-event-source"
    webhook.topic = "customers/update"
    webhook.format = "json"
    webhook.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-10/webhooks.json")

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
  def test_5()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2023-10/webhooks.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "webhook" => hash_including({"topic" => "orders/create", "address" => "https://example.hostname.com/", "format" => "json", "fields" => ["id", "note"]}) }
      )
      .to_return(status: 200, body: JSON.generate({"webhook" => {"id" => 6908876548, "address" => "https://example.hostname.com/", "topic" => "orders/create", "created_at" => "2023-10-10T11:56:48-04:00", "updated_at" => "2023-10-10T11:56:48-04:00", "format" => "json", "fields" => ["id", "note"], "metafield_namespaces" => [], "api_version" => "unstable", "private_metafield_namespaces" => []}}), headers: {})

    response = webhook = ShopifyAPI::Webhook.new
    webhook.topic = "orders/create"
    webhook.address = "https://example.hostname.com/"
    webhook.format = "json"
    webhook.fields = [
      "id",
      "note"
    ]
    webhook.save

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2023-10/webhooks.json")

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
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-10/webhooks/count.json?topic=orders%2Fcreate")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 1}), headers: {})

    response = ShopifyAPI::Webhook.count(
      topic: "orders/create",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-10/webhooks/count.json?topic=orders%2Fcreate")

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
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-10/webhooks/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"count" => 4}), headers: {})

    response = ShopifyAPI::Webhook.count

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-10/webhooks/count.json")

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
  def test_8()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2023-10/webhooks/4759306.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"webhook" => {"id" => 4759306, "address" => "https://apple.com", "topic" => "orders/create", "created_at" => "2023-10-10T11:30:21-04:00", "updated_at" => "2023-10-10T11:30:21-04:00", "format" => "json", "fields" => [], "metafield_namespaces" => [], "api_version" => "unstable", "private_metafield_namespaces" => []}}), headers: {})

    response = ShopifyAPI::Webhook.find(
      id: 4759306,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2023-10/webhooks/4759306.json")

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
  def test_9()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2023-10/webhooks/4759306.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "webhook" => hash_including({"address" => "https://somewhere-else.com/"}) }
      )
      .to_return(status: 200, body: JSON.generate({"webhook" => {"id" => 4759306, "address" => "https://somewhere-else.com/", "topic" => "orders/create", "created_at" => "2023-10-10T11:30:21-04:00", "updated_at" => "2023-10-10T11:56:28-04:00", "format" => "json", "fields" => [], "metafield_namespaces" => [], "api_version" => "unstable", "private_metafield_namespaces" => []}}), headers: {})

    response = webhook = ShopifyAPI::Webhook.new
    webhook.id = 4759306
    webhook.address = "https://somewhere-else.com/"
    webhook.save

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2023-10/webhooks/4759306.json")

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
  def test_10()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2023-10/webhooks/4759306.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({}), headers: {})

    response = ShopifyAPI::Webhook.delete(
      id: 4759306,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2023-10/webhooks/4759306.json")

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
