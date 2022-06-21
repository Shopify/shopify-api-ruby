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
    end
  end
end
