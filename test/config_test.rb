# typed: true
# frozen_string_literal: true

require_relative "./test_helper"

module ShopifyAPITest
  class ConfigTest < Minitest::Test
    def setup
      @reader, writer = IO.pipe
      ENV["HOST"] = "http://localhost:3000"

      @config = ShopifyAPI::Config.new(
        api_key: "key",
        api_secret_key: "secret",
        api_version: "unstable",
        scope: ["scope1", "scope2"],
        is_private: true,
        is_embedded: true,
        log_level: :off,
        logger: Logger.new(writer),
        private_shop: "privateshop.myshopify.com",
        user_agent_prefix: "user_agent_prefix1",
        old_api_secret_key: "old_secret",
      )
    end

    def test_not_setup
      clear_context
      refute(@config.setup?)
    end

    def test_setup
      assert(@config.setup?)
      assert_equal("key", @config.api_key)
      assert_equal("secret", @config.api_secret_key)
      assert_equal("unstable", @config.api_version)
      assert_equal("http://localhost:3000", @config.host)
      assert_equal(ShopifyAPI::Auth::AuthScopes.new(["scope1", "scope2"]), @config.scope)
      assert(@config.private?)
      @config.logger.info("test log")
      assert_match(/test log/, @reader.gets)
      assert_equal("privateshop.myshopify.com", @config.private_shop)
      assert_equal("user_agent_prefix1", @config.user_agent_prefix)
      assert_equal("old_secret", @config.old_api_secret_key)
      assert_equal("http", @config.host_scheme)
      assert_equal("localhost", @config.host_name)
    end

    def test_active_session_is_thread_safe
      session1 = ShopifyAPI::Auth::Session.new(shop: "test-shop2.myshopify.com", access_token: "token1")
      session2 = ShopifyAPI::Auth::Session.new(shop: "test-shop2.myshopify.com", access_token: "token2")

      session1_set = T.let(false, T::Boolean)
      session2_set = T.let(false, T::Boolean)

      threads = []

      threads << Thread.new do
        @config.activate_session(session1)
        session1_set = true

        sleep(0.1) until session2_set

        assert_equal(session1, @config.active_session)
      end

      threads << Thread.new do
        @config.activate_session(session2)
        session2_set = true

        sleep(0.1) until session1_set

        assert_equal(session2, @config.active_session)
      end

      threads.each(&:join)
    end

    def test_active_session_defaults_to_nil
      clear_context
      assert_nil(@config.active_session)
    end

    def test_deactivate_session
      clear_context
      session = ShopifyAPI::Auth::Session.new(shop: "test-shop.myshopify.com", access_token: "token")

      @config.activate_session(session)
      assert_instance_of(ShopifyAPI::Auth::Session, @config.active_session)

      @config.deactivate_session
      assert_nil(@config.active_session)
    end

    def test_unsupported_api_version
      assert_raises(ShopifyAPI::Errors::UnsupportedVersionError) do
        ShopifyAPI::Config.new(
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

      config = ShopifyAPI::Config.new(
        api_key: "key",
        api_secret_key: "secret",
        api_version: "unstable",
        host_name: "tunnel-o-security.com",
        scope: ["scope1", "scope2"],
        is_private: true,
        is_embedded: true,
        private_shop: "privateshop.myshopify.com",
        user_agent_prefix: "user_agent_prefix1",
        old_api_secret_key: "old_secret",
        log_level: :off,
      )
      assert_equal("https", config.host_scheme)
      assert_equal("https://tunnel-o-security.com", config.host)
      assert_equal("tunnel-o-security.com", config.host_name)
      ENV["HOST"] = old_host
    end

    def test_send_a_warning_if_log_level_is_invalid
      ShopifyAPI::Config.stubs(:log_level).returns(:warn)
      ShopifyAPI::Logger.expects(:warn).with("not_a_level is not a valid log_level. "\
        "Valid options are #{::ShopifyAPI::Logger::LOG_LEVELS.keys.join(", ")}", instance_of(ShopifyAPI::Config))
      @config = ShopifyAPI::Config.new(
        api_key: "",
        api_secret_key: "",
        api_version: "unstable",
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
      @config.deactivate_session
    end

    private

    def clear_context
      @config = ShopifyAPI::Config.new(
        api_key: "",
        api_secret_key: "",
        api_version: "unstable",
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
