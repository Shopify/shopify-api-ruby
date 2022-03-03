# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class Webhook202110Test < Test::Unit::TestCase
  def setup
    super

    @test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    modify_context(api_version: "2021-10")
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/webhooks.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Webhook.all(
      session: @test_session,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/webhooks.json")
  end

  sig do
    void
  end
  def test_2()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/webhooks.json?since_id=901431826")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Webhook.all(
      session: @test_session,
      since_id: "901431826",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/webhooks.json?since_id=901431826")
  end

  sig do
    void
  end
  def test_3()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-10/webhooks.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "webhook" => hash_including({"topic" => "orders/create", "address" => "https://example.hostname.com/", "format" => "json", "fields" => ["id", "note"]}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    webhook = ShopifyAPI::Webhook.new(session: @test_session)
    webhook.topic = "orders/create"
    webhook.address = "https://example.hostname.com/"
    webhook.format = "json"
    webhook.fields = [
      "id",
      "note"
    ]
    webhook.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-10/webhooks.json")
  end

  sig do
    void
  end
  def test_4()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-10/webhooks.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "webhook" => hash_including({"address" => "arn:aws:events:us-east-1::event-source/aws.partner/shopify.com/755357713/example-event-source", "topic" => "customers/update", "format" => "json"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    webhook = ShopifyAPI::Webhook.new(session: @test_session)
    webhook.address = "arn:aws:events:us-east-1::event-source/aws.partner/shopify.com/755357713/example-event-source"
    webhook.topic = "customers/update"
    webhook.format = "json"
    webhook.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-10/webhooks.json")
  end

  sig do
    void
  end
  def test_5()
    stub_request(:post, "https://test-shop.myshopify.io/admin/api/2021-10/webhooks.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "webhook" => hash_including({"address" => "pubsub://projectName:topicName", "topic" => "customers/update", "format" => "json"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    webhook = ShopifyAPI::Webhook.new(session: @test_session)
    webhook.address = "pubsub://projectName:topicName"
    webhook.topic = "customers/update"
    webhook.format = "json"
    webhook.save()

    assert_requested(:post, "https://test-shop.myshopify.io/admin/api/2021-10/webhooks.json")
  end

  sig do
    void
  end
  def test_6()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/webhooks/count.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Webhook.count(
      session: @test_session,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/webhooks/count.json")
  end

  sig do
    void
  end
  def test_7()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/webhooks/count.json?topic=orders%2Fcreate")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Webhook.count(
      session: @test_session,
      topic: "orders/create",
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/webhooks/count.json?topic=orders%2Fcreate")
  end

  sig do
    void
  end
  def test_8()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/webhooks/4759306.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Webhook.find(
      session: @test_session,
      id: 4759306,
    )

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/webhooks/4759306.json")
  end

  sig do
    void
  end
  def test_9()
    stub_request(:put, "https://test-shop.myshopify.io/admin/api/2021-10/webhooks/4759306.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json", "Content-Type"=>"application/json"},
        body: { "webhook" => hash_including({"id" => 4759306, "address" => "https://somewhere-else.com/"}) }
      )
      .to_return(status: 200, body: "{}", headers: {})

    webhook = ShopifyAPI::Webhook.new(session: @test_session)
    webhook.id = 4759306
    webhook.address = "https://somewhere-else.com/"
    webhook.save()

    assert_requested(:put, "https://test-shop.myshopify.io/admin/api/2021-10/webhooks/4759306.json")
  end

  sig do
    void
  end
  def test_10()
    stub_request(:delete, "https://test-shop.myshopify.io/admin/api/2021-10/webhooks/4759306.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: "{}", headers: {})

    ShopifyAPI::Webhook.delete(
      session: @test_session,
      id: 4759306,
    )

    assert_requested(:delete, "https://test-shop.myshopify.io/admin/api/2021-10/webhooks/4759306.json")
  end

end
