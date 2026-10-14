# typed: false
# frozen_string_literal: true

require_relative "test_helper"

module ShopifyAPITest
  class AuthTest < Test::Unit::TestCase
    def setup
      super
      @host = "some-shopify-store.myshopify.com/admin"
      @encoded_host = Base64.strict_encode64(@host)
    end

    def test_valid_host
      assert_equal(
        ShopifyAPI::Auth.embedded_app_url(@encoded_host),
        "https://#{@host}/apps/#{ShopifyAPI::Context.api_key}",
      )
    end

    def test_supported_admin_hosts_are_unchanged
      [
        "some-shopify-store.myshopify.com/admin",
        "admin.shopify.com/store/some-shopify-store",
        "some-shopify-store.myshopify.io/admin",
        "admin.web.my-spin.user.us.spin.dev/store/shop1",
        "shop1.my.shop.dev/admin",
        "shop1.myshopify.io:3000/admin",
      ].each do |host|
        assert_equal(
          "https://#{host}/apps/#{ShopifyAPI::Context.api_key}",
          ShopifyAPI::Auth.embedded_app_url(Base64.strict_encode64(host)),
        )
      end
    end

    def test_unpadded_host_is_still_decoded
      host = "admin.shopify.com/store/some-shop1"
      encoded_host = Base64.strict_encode64(host).delete("=")

      refute_equal(Base64.strict_encode64(host), encoded_host)
      assert_equal(
        "https://#{host}/apps/#{ShopifyAPI::Context.api_key}",
        ShopifyAPI::Auth.embedded_app_url(encoded_host),
      )
    end

    def test_untrusted_hosts_are_rejected
      [
        "example.com/admin",
        "example.com",
        "myshopify.com/admin",
        "shopify.com/admin",
        "notmyshopify.com/admin",
        "some-shopify-store.notmyshopify.com/admin",
        "some-shopify-store.myshopify.com.example.com/admin",
        "admin.shopify.com.example.com/store/some-shop",
        "admin.example.com/store/some-shop",
        "example.com/some-shopify-store.myshopify.com/admin",
      ].each do |host|
        assert_raises(ShopifyAPI::Errors::InvalidShopError, "expected #{host.inspect} to be rejected") do
          ShopifyAPI::Auth.embedded_app_url(Base64.strict_encode64(host))
        end
      end
    end

    def test_hosts_with_unexpected_authority_characters_are_rejected
      [
        "user@some-shopify-store.myshopify.com/admin",
        "some-shopify-store.myshopify.com@example.com/admin",
        "example.com?.myshopify.com/admin",
        "example.com#.myshopify.com/admin",
        "example.com\\.myshopify.com/admin",
        "example.com%2F.myshopify.com/admin",
        "some-shopify-store.myshopify.com:/admin",
        "/admin",
      ].each do |host|
        assert_raises(ShopifyAPI::Errors::InvalidShopError, "expected #{host.inspect} to be rejected") do
          ShopifyAPI::Auth.embedded_app_url(Base64.strict_encode64(host))
        end
      end
    end

    def test_full_url_hosts_are_rejected
      [
        "https://some-shopify-store.myshopify.com/admin",
        "//some-shopify-store.myshopify.com/admin",
      ].each do |host|
        assert_raises(ShopifyAPI::Errors::InvalidShopError, "expected #{host.inspect} to be rejected") do
          ShopifyAPI::Auth.embedded_app_url(Base64.strict_encode64(host))
        end
      end
    end

    def test_hosts_with_malformed_bytes_are_rejected
      [
        "some-shopify-store.myshopify.com/admin\n",
        "some-shopify-store.myshopify.com\t/admin",
        "some-shopify-store.myshopify.com /admin",
        "some-shopify-store.myshopify.com/admin\x00",
        "some-shopify-store.myshopify.com\r\n/admin",
        "s\u00F6me-shop.myshopify.com/admin",
        "some-shopify-store.myshopify.com/admin\xFF".b,
      ].each do |host|
        assert_raises(ShopifyAPI::Errors::InvalidShopError, "expected #{host.inspect} to be rejected") do
          ShopifyAPI::Auth.embedded_app_url(Base64.strict_encode64(host))
        end
      end
    end

    def test_empty_host_is_rejected
      assert_raises(ShopifyAPI::Errors::InvalidShopError) do
        ShopifyAPI::Auth.embedded_app_url("")
      end
    end

    def test_no_host
      assert_raises(ShopifyAPI::Errors::MissingRequiredArgumentError) do
        ShopifyAPI::Auth.embedded_app_url(nil)
      end
    end

    def test_context_not_setup
      modify_context(api_key: "", api_secret_key: "", host: "")

      assert_raises(ShopifyAPI::Errors::ContextNotSetupError) do
        ShopifyAPI::Auth.embedded_app_url(@encoded_host)
      end
    end
  end
end
