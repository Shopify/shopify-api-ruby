# typed: true
# frozen_string_literal: true

require_relative "./test_helper"

module ShopifyAPITest
  class ContextTest < Minitest::Test
    def test_not_setup
      ShopifyAPI::Context.setup(
        api_key: "",
        api_secret_key: "",
        api_version: "",
        host_name: "",
        scope: [],
        is_private: false,
        is_embedded: true,
        session_storage: ShopifyAPI::Auth::FileSessionStorage.new
      )

      refute(ShopifyAPI::Context.setup?)
    end

    def test_setup
      reader, writer = IO.pipe
      ShopifyAPI::Context.setup(
        api_key: "key",
        api_secret_key: "secret",
        api_version: "version",
        host_name: "host",
        scope: ["scope1", "scope2"],
        is_private: true,
        is_embedded: true,
        session_storage: ShopifyAPI::Auth::FileSessionStorage.new,
        logger: Logger.new(writer),
        private_shop: "privateshop.myshopify.com"
      )

      assert(ShopifyAPI::Context.setup?)
      assert_equal("key", ShopifyAPI::Context.api_key)
      assert_equal("secret", ShopifyAPI::Context.api_secret_key)
      assert_equal("version", ShopifyAPI::Context.api_version,)
      assert_equal("host", ShopifyAPI::Context.host_name)
      assert_equal(ShopifyAPI::Auth::AuthScopes.new(["scope1", "scope2"]), ShopifyAPI::Context.scope)
      assert(ShopifyAPI::Context.private?)
      assert_equal(ShopifyAPI::Auth::FileSessionStorage.new, ShopifyAPI::Context.session_storage)
      ShopifyAPI::Context.logger.info("test log")
      assert_match(/test log/, reader.gets)
      assert_equal("privateshop.myshopify.com", ShopifyAPI::Context.private_shop)
    end
  end
end
