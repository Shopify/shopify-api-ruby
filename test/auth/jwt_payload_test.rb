# typed: true
# frozen_string_literal: true

require_relative "../test_helper"

module ShopifyAPITest
  module Auth
    class JwtPayloadTest < Test::Unit::TestCase
      def setup
        super
        @admin_jwt_payload = {
          iss: "https://test-shop.myshopify.io/admin",
          dest: "https://test-shop.myshopify.io",
          aud: ShopifyAPI::Context.api_key,
          sub: "1",
          exp: (Time.now + 10).to_i,
          nbf: 1234,
          iat: 1234,
          jti: "4321",
          sid: "abc123",
        }

        @checkout_ui_extension_jwt_payload = {
          iss: "https://test-shop.myshopify.io/checkouts",
          dest: "test-shop.myshopify.io",
          aud: ShopifyAPI::Context.api_key,
          sub: "gid://shopify/Customer/123456789",
          exp: (Time.now + 10).to_i,
          nbf: 1234,
          iat: 1234,
          jti: "4321",
        }
      end

      def test_decode_jwt_payload_succeeds_with_valid_token
        jwt_token = JWT.encode(@admin_jwt_payload, ShopifyAPI::Context.api_secret_key, "HS256")
        decoded = ShopifyAPI::Auth::JwtPayload.new(jwt_token)
        assert_equal(@admin_jwt_payload,
          {
            iss: decoded.iss,
            dest: decoded.dest,
            aud: decoded.aud,
            sub: decoded.sub,
            exp: decoded.exp,
            nbf: decoded.nbf,
            iat: decoded.iat,
            jti: decoded.jti,
            sid: decoded.sid,
          })

        # Helper methods
        assert_equal(decoded.expire_at, @admin_jwt_payload[:exp])
        assert_equal("test-shop.myshopify.io", decoded.shopify_domain)
        assert_equal("test-shop.myshopify.io", decoded.shop)
        assert_equal(1, decoded.shopify_user_id)
      end

      def test_decode_jwt_payload_succeeds_with_spin_domain
        payload = @admin_jwt_payload.dup
        payload[:iss] = "https://test-shop.other.spin.dev/admin"
        payload[:dest] = "https://test-shop.other.spin.dev"
        jwt_token = JWT.encode(payload, ShopifyAPI::Context.api_secret_key, "HS256")
        decoded = ShopifyAPI::Auth::JwtPayload.new(jwt_token)
        assert_equal(payload,
          {
            iss: decoded.iss,
            dest: decoded.dest,
            aud: decoded.aud,
            sub: decoded.sub,
            exp: decoded.exp,
            nbf: decoded.nbf,
            iat: decoded.iat,
            jti: decoded.jti,
            sid: decoded.sid,
          })

        assert_equal("test-shop.other.spin.dev", decoded.shopify_domain)
        assert_equal("test-shop.other.spin.dev", decoded.shop)
      end

      def test_decode_jwt_payload_fails_with_wrong_key
        jwt_token = JWT.encode(@admin_jwt_payload, "Wrong", "HS256")
        assert_raises(ShopifyAPI::Errors::InvalidJwtTokenError) do
          ShopifyAPI::Auth::JwtPayload.new(jwt_token)
        end
      end

      def test_decode_jwt_payload_fails_with_expired_token
        payload = @admin_jwt_payload.dup
        payload[:exp] = (Time.now - 40).to_i
        jwt_token = JWT.encode(payload, ShopifyAPI::Context.api_secret_key, "HS256")
        assert_raises(ShopifyAPI::Errors::InvalidJwtTokenError) do
          ShopifyAPI::Auth::JwtPayload.new(jwt_token)
        end
      end

      def test_decode_jwt_payload_fails_if_not_activated_yet
        payload = @admin_jwt_payload.dup
        payload[:nbf] = (Time.now + 12).to_i
        jwt_token = JWT.encode(payload, ShopifyAPI::Context.api_secret_key, "HS256")
        assert_raises(ShopifyAPI::Errors::InvalidJwtTokenError) do
          ShopifyAPI::Auth::JwtPayload.new(jwt_token)
        end
      end

      def test_decode_jwt_payload_fails_with_invalid_api_key
        jwt_token = JWT.encode(@admin_jwt_payload, ShopifyAPI::Context.api_secret_key, "HS256")

        modify_context(api_key: "invalid")

        assert_raises(ShopifyAPI::Errors::InvalidJwtTokenError) do
          ShopifyAPI::Auth::JwtPayload.new(jwt_token)
        end
      end

      def test_decode_jwt_payload_succeeds_with_expiration_in_the_past_within_10s_leeway
        payload = @admin_jwt_payload.merge(exp: Time.now.to_i - 8)
        jwt_token = JWT.encode(payload, ShopifyAPI::Context.api_secret_key, "HS256")

        decoded = ShopifyAPI::Auth::JwtPayload.new(jwt_token)

        assert_equal(payload, {
          iss: decoded.iss,
          dest: decoded.dest,
          aud: decoded.aud,
          sub: decoded.sub,
          exp: decoded.exp,
          nbf: decoded.nbf,
          iat: decoded.iat,
          jti: decoded.jti,
          sid: decoded.sid,
        })
      end

      def test_decode_jwt_payload_succeeds_with_not_before_in_the_future_within_10s_leeway
        payload = @admin_jwt_payload.merge(nbf: Time.now.to_i + 8)
        jwt_token = JWT.encode(payload, ShopifyAPI::Context.api_secret_key, "HS256")

        decoded = ShopifyAPI::Auth::JwtPayload.new(jwt_token)

        assert_equal(payload, {
          iss: decoded.iss,
          dest: decoded.dest,
          aud: decoded.aud,
          sub: decoded.sub,
          exp: decoded.exp,
          nbf: decoded.nbf,
          iat: decoded.iat,
          jti: decoded.jti,
          sid: decoded.sid,
        })
      end

      def test_decode_jwt_payload_coming_from_checkout_ui_extension
        payload = @checkout_ui_extension_jwt_payload.dup
        jwt_token = JWT.encode(payload, ShopifyAPI::Context.api_secret_key, "HS256")
        decoded = ShopifyAPI::Auth::JwtPayload.new(jwt_token)
        assert_equal(payload,
          {
            iss: decoded.iss,
            dest: decoded.dest,
            aud: decoded.aud,
            sub: decoded.sub,
            exp: decoded.exp,
            nbf: decoded.nbf,
            iat: decoded.iat,
            jti: decoded.jti,
          })

        assert_equal(decoded.expire_at, @checkout_ui_extension_jwt_payload[:exp])
        assert_equal("test-shop.myshopify.io", decoded.shopify_domain)
        assert_equal("test-shop.myshopify.io", decoded.shop)
        assert_nil(decoded.shopify_user_id)
      end

      def test_decode_jwt_payload_coming_from_checkout_ui_extension_without_user_logged_in
        payload = @checkout_ui_extension_jwt_payload.dup
        payload[:sub] = nil
        jwt_token = JWT.encode(payload, ShopifyAPI::Context.api_secret_key, "HS256")
        decoded = ShopifyAPI::Auth::JwtPayload.new(jwt_token)
        assert_equal(payload,
          {
            iss: decoded.iss,
            dest: decoded.dest,
            aud: decoded.aud,
            sub: decoded.sub,
            exp: decoded.exp,
            nbf: decoded.nbf,
            iat: decoded.iat,
            jti: decoded.jti,
          })

        assert_equal(decoded.expire_at, @checkout_ui_extension_jwt_payload[:exp])
        assert_equal("test-shop.myshopify.io", decoded.shopify_domain)
        assert_equal("test-shop.myshopify.io", decoded.shop)
        assert_nil(decoded.shopify_user_id)
      end
    end
  end
end
