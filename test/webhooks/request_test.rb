# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

module ShopifyAPITest
  module Webhooks
    class WebhookRequestTest < Minitest::Test
      def test_create_webhook_request
        headers = {
          "HTTP_X_SHOPIFY_TOPIC" => "some/topic",
          "HTTP_X_SHOPIFY_HMAC_SHA256" => "some_hmac",
          "HTTP_X_SHOPIFY_SHOP_DOMAIN" => "shop.myshopify.com",
        }

        assert(ShopifyAPI::Webhooks::Request.new(raw_body: "{}", headers: headers))
      end

      def test_error_when_headers_missing
        assert_raises(ShopifyAPI::Errors::InvalidWebhookError) do
          ShopifyAPI::Webhooks::Request.new(raw_body: "{}", headers: {})
        end
      end

      def test_with_symbol_headers
        headers = {
          "HTTP_X_SHOPIFY_TOPIC" => "some/topic",
          "HTTP_X_SHOPIFY_HMAC_SHA256" => "some_hmac",
          "HTTP_X_SHOPIFY_SHOP_DOMAIN" => "shop.myshopify.com",
          :clearance => "session",
        }

        assert(ShopifyAPI::Webhooks::Request.new(raw_body: "{}", headers: headers))
      end

      def test_create_webhook_request_with_new_format_headers
        headers = {
          "shopify-topic" => "some/topic",
          "shopify-hmac-sha256" => "some_hmac",
          "shopify-shop-domain" => "shop.myshopify.com",
        }

        assert(ShopifyAPI::Webhooks::Request.new(raw_body: "{}", headers: headers))
      end

      def test_create_webhook_request_with_both_header_formats
        headers = {
          "x-shopify-topic" => "some/topic",
          "x-shopify-hmac-sha256" => "some_hmac",
          "x-shopify-shop-domain" => "shop.myshopify.com",
          "shopify-topic" => "some/topic",
          "shopify-hmac-sha256" => "some_hmac",
          "shopify-shop-domain" => "shop.myshopify.com",
        }

        assert(ShopifyAPI::Webhooks::Request.new(raw_body: "{}", headers: headers))
      end

      def test_accessor_values_with_new_format_headers
        hmac_value = Base64.encode64("test_hmac_bytes")
        headers = {
          "shopify-topic" => "orders/create",
          "shopify-hmac-sha256" => hmac_value,
          "shopify-shop-domain" => "test-shop.myshopify.com",
          "shopify-api-version" => "2024-01",
          "shopify-webhook-id" => "b1234-eefd-4c9e-9520-049845a02082",
        }

        request = ShopifyAPI::Webhooks::Request.new(raw_body: "{}", headers: headers)

        assert_equal("orders/create", request.topic)
        assert_equal("test-shop.myshopify.com", request.shop)
        assert_equal("2024-01", request.api_version)
        assert_equal("b1234-eefd-4c9e-9520-049845a02082", request.webhook_id)
        assert_equal(Digest.hexencode(Base64.decode64(hmac_value)), request.hmac)
      end

      def test_error_when_headers_missing_in_either_format
        error = assert_raises(ShopifyAPI::Errors::InvalidWebhookError) do
          ShopifyAPI::Webhooks::Request.new(raw_body: "{}", headers: {})
        end

        assert_includes(error.message, "shopify-topic or x-shopify-topic")
        assert_includes(error.message, "shopify-hmac-sha256 or x-shopify-hmac-sha256")
        assert_includes(error.message, "shopify-shop-domain or x-shopify-shop-domain")
      end
    end
  end
end
