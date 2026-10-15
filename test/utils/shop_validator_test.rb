# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

module ShopifyAPITest
  module Utils
    class ShopValidatorTest < Test::Unit::TestCase
      def test_accepts_valid_myshopify_com_domain
        assert_equal("test-shop.myshopify.com", ShopifyAPI::Utils::ShopValidator.sanitize!("test-shop.myshopify.com"))
      end

      def test_accepts_valid_myshopify_io_domain
        assert_equal("test-shop.myshopify.io", ShopifyAPI::Utils::ShopValidator.sanitize!("test-shop.myshopify.io"))
      end

      def test_strips_https_scheme
        assert_equal("test-shop.myshopify.com", ShopifyAPI::Utils::ShopValidator.sanitize!("https://test-shop.myshopify.com"))
      end

      def test_strips_http_scheme
        assert_equal("test-shop.myshopify.com", ShopifyAPI::Utils::ShopValidator.sanitize!("http://test-shop.myshopify.com"))
      end

      def test_strips_trailing_slash
        assert_equal("test-shop.myshopify.com", ShopifyAPI::Utils::ShopValidator.sanitize!("test-shop.myshopify.com/"))
      end

      def test_normalizes_to_lowercase
        assert_equal("test-shop.myshopify.com", ShopifyAPI::Utils::ShopValidator.sanitize!("Test-Shop.MyShopify.com"))
      end

      def test_strips_whitespace
        result = ShopifyAPI::Utils::ShopValidator.sanitize!("  test-shop.myshopify.com  ")
        assert_equal("test-shop.myshopify.com", result)
      end

      def test_rejects_attacker_controlled_domain
        assert_raises(ShopifyAPI::Errors::InvalidShopError) do
          ShopifyAPI::Utils::ShopValidator.sanitize!("attacker.example")
        end
      end

      def test_rejects_empty_string
        assert_raises(ShopifyAPI::Errors::InvalidShopError) do
          ShopifyAPI::Utils::ShopValidator.sanitize!("")
        end
      end

      def test_rejects_non_shopify_domain
        assert_raises(ShopifyAPI::Errors::InvalidShopError) do
          ShopifyAPI::Utils::ShopValidator.sanitize!("evil.com")
        end
      end

      def test_rejects_shopify_suffix_as_subdomain_of_attacker
        assert_raises(ShopifyAPI::Errors::InvalidShopError) do
          ShopifyAPI::Utils::ShopValidator.sanitize!("myshopify.com.evil.com")
        end
      end

      def test_rejects_similar_looking_domain
        assert_raises(ShopifyAPI::Errors::InvalidShopError) do
          ShopifyAPI::Utils::ShopValidator.sanitize!("test-shop.notmyshopify.com")
        end
      end

      def test_rejects_path_that_suffix_matches_myshopify_host
        assert_raises(ShopifyAPI::Errors::InvalidShopError) do
          ShopifyAPI::Utils::ShopValidator.sanitize!("attacker.com/.myshopify.com")
        end
      end

      def test_rejects_userinfo_before_at_sign
        assert_raises(ShopifyAPI::Errors::InvalidShopError) do
          ShopifyAPI::Utils::ShopValidator.sanitize!("shop.myshopify.com@evil.com")
        end
      end

      def test_sanitize_shop_domain_returns_nil_for_invalid
        assert_nil(ShopifyAPI::Utils::ShopValidator.sanitize_shop_domain("evil.com"))
        assert_nil(ShopifyAPI::Utils::ShopValidator.sanitize_shop_domain("myshopify.com"))
      end

      def test_unified_admin_store_url_maps_to_myshopify_host
        assert_equal(
          "cool-shop.myshopify.com",
          ShopifyAPI::Utils::ShopValidator.sanitize!("https://admin.shopify.com/store/cool-shop"),
        )
        assert_equal(
          "cool-shop.myshopify.com",
          ShopifyAPI::Utils::ShopValidator.sanitize_shop_domain("https://admin.shopify.com/store/cool-shop"),
        )
      end

      def test_unified_admin_store_url_accepts_valid_handles
        {
          "https://admin.shopify.com/store/shop1" => "shop1.myshopify.com",
          "https://admin.shopify.com/store/cool-shop/" => "cool-shop.myshopify.com",
          "https://Admin.Shopify.com/store/Cool-Shop" => "cool-shop.myshopify.com",
          "admin.shopify.com/store/1-shop" => "1-shop.myshopify.com",
          "https://admin.shopify.com/store/shop1/apps/cool_app_hansel" => "shop1.myshopify.com",
          "https://admin.web.my-spin.user.us.spin.dev/store/shop1" => "shop1.myshopify.com",
        }.each do |shop, expected|
          assert_equal(expected, ShopifyAPI::Utils::ShopValidator.sanitize!(shop))
        end
      end

      def test_unified_admin_store_url_rejects_invalid_handles
        [
          "https://admin.shopify.com/store/bad.handle",
          "https://admin.shopify.com/store/bad_handle",
          "https://admin.shopify.com/store/-bad-handle",
          "https://admin.shopify.com/store/bad%2Ehandle",
          "https://admin.shopify.com/store/bad\\handle",
          "https://admin.shopify.com/store/bad:handle",
          "https://admin.shopify.com/store/",
          "https://admin.shopify.com/apps/cool-app",
          "https://admin.shopify.com",
        ].each do |shop|
          assert_nil(
            ShopifyAPI::Utils::ShopValidator.sanitize_shop_domain(shop),
            "expected #{shop.inspect} to be rejected",
          )
          assert_raises(ShopifyAPI::Errors::InvalidShopError, "expected #{shop.inspect} to be rejected") do
            ShopifyAPI::Utils::ShopValidator.sanitize!(shop)
          end
        end
      end

      def test_rejects_hosts_with_non_hostname_characters
        [
          "bad%5Chost.myshopify.com",
          "bad%2Fhost.myshopify.com",
          "bad%40host.myshopify.com",
          "bad;host.myshopify.com",
          "bad,host.myshopify.com",
          "bad!host.myshopify.com",
          "bad+host.myshopify.com",
          "bad=host.myshopify.com",
        ].each do |shop|
          assert_nil(
            ShopifyAPI::Utils::ShopValidator.sanitize_shop_domain(shop),
            "expected #{shop.inspect} to be rejected",
          )
        end
      end

      def test_sanitize_shop_domain_with_custom_myshopify_domain
        assert_equal(
          "mystore.myshopify.com",
          ShopifyAPI::Utils::ShopValidator.sanitize_shop_domain("mystore", myshopify_domain: "myshopify.com"),
        )
      end
    end
  end
end
