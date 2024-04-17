# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

module ShopifyAPITest
  module Utils
    class SessionUtils < Test::Unit::TestCase
      def setup
        super
        @user_id = "my_user_id"
        @shop = "test-shop.myshopify.io"

        @jwt_payload = {
          iss: "https://#{@shop}/admin",
          dest: "https://#{@shop}",
          aud: ShopifyAPI::Context.api_key,
          sub: @user_id,
          exp: (Time.now + 10).to_i,
          nbf: 1234,
          iat: 1234,
          jti: "4321",
          sid: "abc123",
        }

        @jwt_token = JWT.encode(@jwt_payload, ShopifyAPI::Context.api_secret_key, "HS256")
      end

      def test_gets_online_session_id_from_shopify_id_token
        expected_session_id = "#{@shop}_#{@user_id}"
        assert_equal(
          expected_session_id,
          ShopifyAPI::Utils::SessionUtils.session_id_from_shopify_id_token(id_token: @jwt_token, online: true),
        )
      end

      def test_gets_offline_session_id_from_shopify_id_token
        expected_session_id = "offline_#{@shop}"
        assert_equal(
          expected_session_id,
          ShopifyAPI::Utils::SessionUtils.session_id_from_shopify_id_token(id_token: @jwt_token, online: false),
        )
      end

      def test_session_id_from_shopify_id_token_raises_invalid_jwt_errors
        assert_raises(ShopifyAPI::Errors::InvalidJwtTokenError) do
          ShopifyAPI::Utils::SessionUtils.session_id_from_shopify_id_token(id_token: "invalid_token", online: true)
        end
      end
    end
  end
end
