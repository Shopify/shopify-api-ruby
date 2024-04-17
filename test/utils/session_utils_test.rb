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
        @auth_header = "Bearer #{@jwt_token}"
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

      def test_session_id_from_shopify_id_token_raises_missing_jwt_token_error
        error = assert_raises(ShopifyAPI::Errors::MissingJwtTokenError) do
          ShopifyAPI::Utils::SessionUtils.session_id_from_shopify_id_token(id_token: nil, online: true)
        end

        assert_equal("Missing Shopify ID Token", error.message)
      end

      def test_non_embedded_app_current_session_id_raises_cookie_not_found_error
        ShopifyAPI::Context.stubs(:embedded?).returns(false)

        [
          nil,
          {},
          { "not-session-cookie-name": "not-this-cookie" },
        ].each do |cookies|
          error = assert_raises(ShopifyAPI::Errors::CookieNotFoundError) do
            ShopifyAPI::Utils::SessionUtils.current_session_id(nil, cookies, true)
          end
          assert_equal("Session cookie not found for app", error.message)
        end
      end

      def test_non_embedded_app_current_session_id_returns_id_from_cookie
        ShopifyAPI::Context.stubs(:embedded?).returns(false)
        expected_session_id = "cookie_value"
        cookies = { ShopifyAPI::Auth::Oauth::SessionCookie::SESSION_COOKIE_NAME => expected_session_id }

        assert_equal(
          expected_session_id,
          ShopifyAPI::Utils::SessionUtils.current_session_id(nil, cookies, true),
        )
      end

      def test_embedded_app_current_session_id_raises_cookie_not_found_error
        ShopifyAPI::Context.stubs(:embedded?).returns(true)

        [
          nil,
          {},
          { "not-session-cookie-name": "not-this-cookie" },
        ].each do |cookies|
          error = assert_raises(ShopifyAPI::Errors::CookieNotFoundError) do
            ShopifyAPI::Utils::SessionUtils.current_session_id(nil, cookies, true)
          end
          assert_equal("JWT token or Session cookie not found for app", error.message)
        end
      end

      def test_embedded_app_current_session_id_raises_missing_jwt_token_error
        ShopifyAPI::Context.stubs(:embedded?).returns(true)

        error = assert_raises(ShopifyAPI::Errors::MissingJwtTokenError) do
          ShopifyAPI::Utils::SessionUtils.current_session_id("", nil, true)
        end

        assert_equal("Missing Bearer token in authorization header", error.message)
      end

      def test_embedded_app_current_session_id_returns_online_id_from_auth_header
        ShopifyAPI::Context.stubs(:embedded?).returns(true)
        expected_session_id = "#{@shop}_#{@user_id}"

        assert_equal(
          expected_session_id,
          ShopifyAPI::Utils::SessionUtils.current_session_id(@auth_header, nil, true),
        )
      end

      def test_embedded_app_current_session_id_returns_offline_id_from_auth_header
        ShopifyAPI::Context.stubs(:embedded?).returns(true)
        expected_session_id = "offline_#{@shop}"

        assert_equal(
          expected_session_id,
          ShopifyAPI::Utils::SessionUtils.current_session_id(@auth_header, nil, false),
        )
      end

      def test_embedded_app_current_session_id_returns_id_from_auth_header_even_with_cookies
        ShopifyAPI::Context.stubs(:embedded?).returns(true)
        cookies = { ShopifyAPI::Auth::Oauth::SessionCookie::SESSION_COOKIE_NAME => "cookie_value" }
        expected_session_id = "#{@shop}_#{@user_id}"

        assert_equal(
          expected_session_id,
          ShopifyAPI::Utils::SessionUtils.current_session_id(@auth_header, cookies, true),
        )
      end
    end
  end
end
