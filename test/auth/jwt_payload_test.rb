# typed: true
# frozen_string_literal: true

require_relative "../test_helper"

class JwtPayloadTest < Test::Unit::TestCase
  def setup
    super
    @jwt_payload = {
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
  end

  def test_decode_jwt_payload_succeeds_with_valid_token
    jwt_token = JWT.encode(@jwt_payload, ShopifyAPI::Context.api_secret_key, "HS256")
    decoded = ShopifyAPI::Auth::JwtPayload.new(jwt_token)
    assert_equal(@jwt_payload,
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
  end

  def test_decode_jwt_payload_fails_with_wrong_key
    jwt_token = JWT.encode(@jwt_payload, "Wrong", "HS256")
    assert_raises(ShopifyAPI::Errors::InvalidJwtTokenError) do
      ShopifyAPI::Auth::JwtPayload.new(jwt_token)
    end
  end

  def test_decode_jwt_payload_fails_with_expired_token
    payload = @jwt_payload.dup
    payload[:exp] = (Time.now - 40).to_i
    jwt_token = JWT.encode(payload, ShopifyAPI::Context.api_secret_key, "HS256")
    assert_raises(ShopifyAPI::Errors::InvalidJwtTokenError) do
      ShopifyAPI::Auth::JwtPayload.new(jwt_token)
    end
  end

  def test_decode_jwt_payload_fails_if_not_activated_yet
    payload = @jwt_payload.dup
    payload[:nbf] = (Time.now + 10).to_i
    jwt_token = JWT.encode(payload, ShopifyAPI::Context.api_secret_key, "HS256")
    assert_raises(ShopifyAPI::Errors::InvalidJwtTokenError) do
      ShopifyAPI::Auth::JwtPayload.new(jwt_token)
    end
  end

  def test_decode_jwt_payload_fails_if_domain_is_invalid
    payload = @jwt_payload.dup
    payload[:dest] = "https://notadomain"
    jwt_token = JWT.encode(payload, ShopifyAPI::Context.api_secret_key, "HS256")
    assert_raises(ShopifyAPI::Errors::InvalidJwtTokenError) do
      ShopifyAPI::Auth::JwtPayload.new(jwt_token)
    end
  end

  def test_decode_jwt_payload_fails_with_invalid_api_key
    jwt_token = JWT.encode(@jwt_payload, ShopifyAPI::Context.api_secret_key, "HS256")
    ShopifyAPI::Context.setup(
      api_key: "invalid",
      api_secret_key: ShopifyAPI::Context.api_secret_key,
      host_name: ShopifyAPI::Context.host_name,
      scope: ShopifyAPI::Context.scope,
      is_private: false,
      is_embedded: true,
      session_storage: ShopifyAPI::Context.session_storage,
    )
    assert_raises(ShopifyAPI::Errors::InvalidJwtTokenError) do
      ShopifyAPI::Auth::JwtPayload.new(jwt_token)
    end
  end
end
