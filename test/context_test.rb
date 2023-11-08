# typed: true
# frozen_string_literal: true

require_relative "./test_helper"

module ShopifyAPITest
  class ContextTest < Minitest::Test
    def setup
      @reader, writer = IO.pipe
      ENV["HOST"] = "http://localhost:3000"

      ShopifyAPI::Context.setup(
        api_key: "key",
        api_secret_key: "secret",
        api_version: "2023-10",
        scope: ["scope1", "scope2"],
        is_private: true,
        is_embedded: true,
        log_level: :off,
        logger: Logger.new(writer),
        private_shop: "privateshop.myshopify.com",
        user_agent_prefix: "user_agent_prefix1",
        old_api_secret_key: "old_secret",
        api_host: "example.com",
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
      assert_equal("2023-10", ShopifyAPI::Context.api_version)
      assert_equal("http://localhost:3000", ShopifyAPI::Context.host)
      assert_equal(ShopifyAPI::Auth::AuthScopes.new(["scope1", "scope2"]), ShopifyAPI::Context.scope)
      assert(ShopifyAPI::Context.private?)
      ShopifyAPI::Context.logger.info("test log")
      assert_match(/test log/, @reader.gets)
      assert_equal("privateshop.myshopify.com", ShopifyAPI::Context.private_shop)
      assert_equal("user_agent_prefix1", ShopifyAPI::Context.user_agent_prefix)
      assert_equal("old_secret", ShopifyAPI::Context.old_api_secret_key)
      assert_equal("http", ShopifyAPI::Context.host_scheme)
      assert_equal("localhost", ShopifyAPI::Context.host_name)
      assert_equal("example.com", ShopifyAPI::Context.api_host)
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
          logger: Logger.new($stdout),
        )
      end
    end

    def test_with_host_name_and_no_host_env
      clear_context
      old_host = ENV["HOST"]
      ENV["HOST"] = nil

      ShopifyAPI::Context.setup(
        api_key: "key",
        api_secret_key: "secret",
        api_version: "2023-10",
        host_name: "tunnel-o-security.com",
        scope: ["scope1", "scope2"],
        is_private: true,
        is_embedded: true,
        private_shop: "privateshop.myshopify.com",
        user_agent_prefix: "user_agent_prefix1",
        old_api_secret_key: "old_secret",
        log_level: :off,
      )
      assert_equal("https", ShopifyAPI::Context.host_scheme)
      assert_equal("https://tunnel-o-security.com", ShopifyAPI::Context.host)
      assert_equal("tunnel-o-security.com", ShopifyAPI::Context.host_name)
      ENV["HOST"] = old_host
    end

    def test_send_a_warning_if_log_level_is_invalid
      ShopifyAPI::Context.stubs(:log_level).returns(:warn)
      ShopifyAPI::Logger.expects(:warn).with("not_a_level is not a valid log_level. "\
        "Valid options are #{::ShopifyAPI::Logger::LOG_LEVELS.keys.join(", ")}")
      ShopifyAPI::Context.setup(
        api_key: "",
        api_secret_key: "",
        api_version: "2023-10",
        host_name: "",
        scope: [],
        is_private: false,
        is_embedded: true,
        logger: ::Logger.new(T.let(StringIO.new, StringIO)),
        user_agent_prefix: nil,
        old_api_secret_key: nil,
        log_level: :not_a_level,
      )
    end

    def teardown
      ShopifyAPI::Context.deactivate_session
    end

    private

    def clear_context
      ShopifyAPI::Context.setup(
        api_key: "",
        api_secret_key: "",
        api_version: "2023-10",
        host_name: "",
        scope: [],
        is_private: false,
        is_embedded: true,
        user_agent_prefix: nil,
        old_api_secret_key: nil,
        log_level: :off,
      )
    end
  end
end
