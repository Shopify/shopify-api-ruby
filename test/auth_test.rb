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
        "myshopify.com/admin",
        "some-shopify-store.myshopify.com.example.com/admin",
      ].each do |host|
        assert_raises(ShopifyAPI::Errors::InvalidShopError, "expected #{host.inspect} to be rejected") do
          ShopifyAPI::Auth.embedded_app_url(Base64.strict_encode64(host))
        end
      end
    end

    def test_invalid_embedded_host_forms_are_rejected
      [
        "example.com%2F.myshopify.com/admin",
        "https://some-shopify-store.myshopify.com/admin",
      ].each do |host|
        assert_raises(ShopifyAPI::Errors::InvalidShopError, "expected #{host.inspect} to be rejected") do
          ShopifyAPI::Auth.embedded_app_url(Base64.strict_encode64(host))
        end
      end
    end

    def test_malformed_or_empty_hosts_are_rejected
      [
        "some-shopify-store.myshopify.com/admin\n",
        "some-shopify-store.myshopify.com/admin\xFF".b,
        "",
      ].each do |host|
        assert_raises(ShopifyAPI::Errors::InvalidShopError, "expected #{host.inspect} to be rejected") do
          ShopifyAPI::Auth.embedded_app_url(Base64.strict_encode64(host))
        end
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
