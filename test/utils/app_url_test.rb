# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

module ShopifyAPITest
  module Utils
    class AppUrlTest < Test::Unit::TestCase
      def setup
        super
        @host = "some-shopify-store.myshopify.com/admin"
        @encoded_host = Base64.strict_encode64(@host)
      end

      def test_valid_host
        assert_equal(
          ShopifyAPI::Utils::AppUrl.get_embedded(@encoded_host),
          "https://#{@host}/apps/#{ShopifyAPI::Context.api_key}"
        )
      end

      def test_no_host
        assert_raises(ShopifyAPI::Errors::MissingRequiredArgumentError) do
          ShopifyAPI::Utils::AppUrl.get_embedded(nil)
        end
      end

      def test_context_not_setup
        modify_context(api_key: "", api_secret_key: "", host_name: "")

        assert_raises(ShopifyAPI::Errors::ContextNotSetupError) do
          ShopifyAPI::Utils::AppUrl.get_embedded(@encoded_host)
        end
      end
    end
  end
end
