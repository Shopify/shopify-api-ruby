# typed: true
# frozen_string_literal: true

require_relative "./test_helper"

module ShopifyAPITest
  class ContextTest < Minitest::Test
    def setup
      @reader, writer = IO.pipe
      ShopifyAPI::Context.setup(
        api_key: "key",
        api_secret_key: "secret",
        api_version: "unstable",
        host_name: "host",
        scope: ["scope1", "scope2"],
        is_private: true,
        is_embedded: true,
        session_storage: ShopifyAPI::Auth::FileSessionStorage.new,
        logger: Logger.new(writer),
        private_shop: "privateshop.myshopify.com",
        user_agent_prefix: "user_agent_prefix1",
        old_api_secret_key: "old_secret"
      )
    end

    def test_not_setup
      clear_context
      refute(ShopifyAPI::Context.setup?)
    end

    def test_setup
      assert(ShopifyAPI::Context.setup?)
      assert_equal("key", ShopifyAPI::Context.api_key)
      assert_equal("secret", ShopifyAPI::Context.api_secret_key)
      assert_equal("unstable", ShopifyAPI::Context.api_version,)
      assert_equal("host", ShopifyAPI::Context.host_name)
      assert_equal(ShopifyAPI::Auth::AuthScopes.new(["scope1", "scope2"]), ShopifyAPI::Context.scope)
      assert(ShopifyAPI::Context.private?)
      assert_equal(ShopifyAPI::Auth::FileSessionStorage.new, ShopifyAPI::Context.session_storage)
      ShopifyAPI::Context.logger.info("test log")
      assert_match(/test log/, @reader.gets)
      assert_equal("privateshop.myshopify.com", ShopifyAPI::Context.private_shop)
      assert_equal("user_agent_prefix1", ShopifyAPI::Context.user_agent_prefix)
      assert_equal("old_secret", ShopifyAPI::Context.old_api_secret_key)
    end

    def test_active_session_is_thread_safe
      session1 = ShopifyAPI::Auth::Session.new(shop: "test-shop2.myshopify.com", access_token: "token1")
      session2 = ShopifyAPI::Auth::Session.new(shop: "test-shop2.myshopify.com", access_token: "token2")

      session1_set = T.let(false, T::Boolean)
      session2_set = T.let(false, T::Boolean)

      threads = []

      threads << Thread.new do
        ShopifyAPI::Context.activate_session(session1)
        session1_set = true

        sleep(0.1) until session2_set

        assert_equal(session1, ShopifyAPI::Context.active_session)
      end

      threads << Thread.new do
        ShopifyAPI::Context.activate_session(session2)
        session2_set = true

        sleep(0.1) until session1_set

        assert_equal(session2, ShopifyAPI::Context.active_session)
      end

      threads.each(&:join)
    end

    def test_active_session_defaults_to_private_session
      assert_equal("privateshop.myshopify.com", T.must(ShopifyAPI::Context.active_session).shop)
      assert_equal("secret", T.must(ShopifyAPI::Context.active_session).access_token)
    end

    def test_active_session_defaults_to_nil
      clear_context
      assert_nil(ShopifyAPI::Context.active_session)
    end

    def test_deactivate_session
      clear_context
      session = ShopifyAPI::Auth::Session.new(shop: "test-shop.myshopify.com", access_token: "token")

      ShopifyAPI::Context.activate_session(session)
      assert_instance_of(ShopifyAPI::Auth::Session, ShopifyAPI::Context.active_session)

      ShopifyAPI::Context.deactivate_session
      assert_nil(ShopifyAPI::Context.active_session)
    end

    def test_unsupported_api_version
      assert_raises(ShopifyAPI::Errors::UnsupportedVersionError) do
        ShopifyAPI::Context.setup(
          api_key: "key",
          api_secret_key: "secret",
          api_version: "unsupported",
          host_name: "host",
          scope: ["scope1", "scope2"],
          is_private: false,
          is_embedded: true,
          session_storage: ShopifyAPI::Auth::FileSessionStorage.new,
          logger: Logger.new($stdout),
        )
      end
    end

    def teardown
      ShopifyAPI::Context.deactivate_session
    end

    private

    def clear_context
      ShopifyAPI::Context.setup(
        api_key: "",
        api_secret_key: "",
        api_version: "unstable",
        host_name: "",
        scope: [],
        is_private: false,
        is_embedded: true,
        session_storage: ShopifyAPI::Auth::FileSessionStorage.new,
        user_agent_prefix: nil,
        old_api_secret_key: nil
      )
    end
  end
end
