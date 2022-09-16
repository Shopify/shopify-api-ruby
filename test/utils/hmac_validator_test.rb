# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

module ShopifyAPITest
  module Utils
    class HmacValidatorTest < Test::Unit::TestCase
      def setup
        super

        @query = {
          code: "somecode",
          host: "host",
          shop: "some-shop.myshopify.com",
          state: "1234",
          timestamp: "123456",
        }
      end

      def test_invalid_signature
        auth_query = ShopifyAPI::Auth::Oauth::AuthQuery.new(
          code: @query[:code],
          shop: @query[:shop],
          timestamp: @query[:timestamp],
          state: @query[:state],
          host: @query[:host],
          hmac: "invalid",
        )
        refute(ShopifyAPI::Utils::HmacValidator.validate(auth_query))
      end

      def test_valid_signature
        auth_query = ShopifyAPI::Auth::Oauth::AuthQuery.new(
          code: @query[:code],
          shop: @query[:shop],
          timestamp: @query[:timestamp],
          state: @query[:state],
          host: @query[:host],
          hmac: hmac(@query, ShopifyAPI::Context.api_secret_key),
        )
        assert(ShopifyAPI::Utils::HmacValidator.validate(auth_query))
      end

      def test_valid_signature_signed_with_old_api_secret_key
        modify_context(old_api_secret_key: "OLD_API_SECRET_KEY")
        auth_query = ShopifyAPI::Auth::Oauth::AuthQuery.new(
          code: @query[:code],
          shop: @query[:shop],
          timestamp: @query[:timestamp],
          state: @query[:state],
          host: @query[:host],
          hmac: hmac(@query, ShopifyAPI::Context.old_api_secret_key),
        )
        assert(ShopifyAPI::Utils::HmacValidator.validate(auth_query))
      end

      private

      def hmac(query_to_sign, secret)
        OpenSSL::HMAC.hexdigest(
          OpenSSL::Digest.new("sha256"),
          secret,
          URI.encode_www_form(query_to_sign),
        )
      end
    end
  end
end
