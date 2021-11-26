# typed: false
# frozen_string_literal: true

require_relative "../test_helper.rb"

class RegistryTest < Test::Unit::TestCase
  def setup
    @topic = "some_topic"
    @shop = "shop.myshopify.com"

    hmac = OpenSSL::HMAC.digest(
      OpenSSL::Digest.new("sha256"),
      ShopifyAPI::Context.api_secret_key,
      "{}"
    )

    @headers = {
      "x-shopify-topic" => @topic,
      "x-shopify-hmac-sha256" => Base64.encode64(hmac),
      "x-shopify-shop-domain" => @shop,
    }

    @webhook_request = ShopifyAPI::Webhooks::Request.new(raw_body: "{}", headers: @headers)
  end

  def test_add_http_registration_without_handler
    assert_raises(ShopifyAPI::Errors::InvalidWebhookRegistrationError) do
      ShopifyAPI::Webhooks::Registry.add_registration(topic: "some_topic", path: "path", delivery_method: :http)
    end
  end

  def test_process
    handler_called = false

    handler = TestHelpers::FakeWebhookHandler.new(
      lambda do |topic, shop, body|
        assert_equal(@topic, topic)
        assert_equal(@shop, shop)
        assert_equal({}, body)
        handler_called = true
      end
    )

    ShopifyAPI::Webhooks::Registry.add_registration(
      topic: @topic, path: "path", delivery_method: :http, handler: handler
    )

    ShopifyAPI::Webhooks::Registry.process(@webhook_request)

    assert(handler_called)
  end

  def test_process_hmac_validation_fails
    headers = {
      "x-shopify-topic" => "some_topic",
      "x-shopify-hmac-sha256" => "invalid",
      "x-shopify-shop-domain" => "shop.myshopify.com",
    }

    assert_raises(ShopifyAPI::Errors::InvalidWebhookError) do
      ShopifyAPI::Webhooks::Registry.process(ShopifyAPI::Webhooks::Request.new(raw_body: "{}", headers: headers))
    end
  end

  def test_process_no_handler
    @headers["x-shopify-topic"] = "non_registered_topic"

    assert_raises(ShopifyAPI::Errors::NoWebhookHandler) do
      ShopifyAPI::Webhooks::Registry.process(ShopifyAPI::Webhooks::Request.new(raw_body: "{}",
        headers: @headers))
    end
  end
end
