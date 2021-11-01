# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

class HmacValidatorTest < Test::Unit::TestCase
  def test_missing_hmac_param
    query = ShopifyAPI::Utils::AuthQuery.new(
      code: "somecode",
      shop: "some-shop.myshopify.com",
      state: "1234",
      timestamp: "123456",
    )
    refute(ShopifyAPI::Utils::HmacValidator.validate(query))
  end

  def test_invalid_signature
    query = ShopifyAPI::Utils::AuthQuery.new(
      code: "somecode",
      shop: "some-shop.myshopify.com",
      state: "1234",
      timestamp: "123456",
      hmac: "invalid"
    )
    refute(ShopifyAPI::Utils::HmacValidator.validate(query))
  end

  def test_valid_signature
    query_to_sign = ShopifyAPI::Utils::AuthQuery.new(
      code: "somecode",
      shop: "some-shop.myshopify.com",
      state: "1234",
      timestamp: "123456",
    )
    hmac = OpenSSL::HMAC.hexdigest(
      OpenSSL::Digest.new("sha256"),
      ShopifyAPI::Context.api_secret_key,
      URI.encode_www_form(query_to_sign.to_signable_hash)
    )
    query = ShopifyAPI::Utils::AuthQuery.new(
      code: "somecode",
      shop: "some-shop.myshopify.com",
      state: "1234",
      timestamp: "123456",
      hmac: hmac
    )
    assert(ShopifyAPI::Utils::HmacValidator.validate(query))
  end
end
