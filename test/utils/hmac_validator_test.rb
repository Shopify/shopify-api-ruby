# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

class HmacValidatorTest < Test::Unit::TestCase
  def test_invalid_signature
    query = ShopifyAPI::Auth::Oauth::AuthQuery.new(
      code: "somecode",
      shop: "some-shop.myshopify.com",
      state: "1234",
      timestamp: "123456",
      hmac: "invalid",
      host: "host"
    )
    refute(ShopifyAPI::Utils::HmacValidator.validate(query))
  end

  def test_valid_signature
    query_to_sign = {
      code: "somecode",
      host: "host",
      shop: "some-shop.myshopify.com",
      state: "1234",
      timestamp: "123456",
    }
    hmac = OpenSSL::HMAC.hexdigest(
      OpenSSL::Digest.new("sha256"),
      ShopifyAPI::Context.api_secret_key,
      URI.encode_www_form(query_to_sign)
    )
    query = ShopifyAPI::Auth::Oauth::AuthQuery.new(
      code: "somecode",
      shop: "some-shop.myshopify.com",
      state: "1234",
      timestamp: "123456",
      host: "host",
      hmac: hmac
    )
    assert(ShopifyAPI::Utils::HmacValidator.validate(query))
  end
end
