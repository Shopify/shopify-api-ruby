# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"
require "mocha"
require "mocha/minitest"

require "shopify_api"
require "pry-byebug"

require_relative("./test_helpers/constants.rb")

Dir[File.dirname(__FILE__) + "/test_helpers/*.rb"].each { |file| require file }

module Test
  module Unit
    class TestCase < Minitest::Test
      extend T::Sig

      sig { void }
      def setup
        ShopifyAPI::Context.setup(
          api_key: "API_KEY",
          api_secret_key: "API_SECRET_KEY",
          api_version: "unstable",
          host: "https://app-address.com",
          scope: ["scope1", "scope2"],
          is_private: false,
          is_embedded: false,
          session_storage: TestHelpers::FakeSessionStorage.new,
          user_agent_prefix: nil,
          old_api_secret_key: nil,
        )
      end

      sig do
        params(
          api_key: T.nilable(String),
          api_secret_key: T.nilable(String),
          api_version: T.nilable(String),
          host: T.nilable(String),
          scope: T.nilable(T.any(T::Array[String], String)),
          is_private: T.nilable(T::Boolean),
          is_embedded: T.nilable(T::Boolean),
          session_storage: T.nilable(ShopifyAPI::Auth::SessionStorage),
          logger: T.nilable(Logger),
          private_shop: T.nilable(String),
          user_agent_prefix: T.nilable(String),
          old_api_secret_key: T.nilable(String),
        ).void
      end
      def modify_context(
        api_key: nil,
        api_secret_key: nil,
        api_version: nil,
        host: nil,
        scope: nil,
        is_private: nil,
        is_embedded: nil,
        session_storage: nil,
        logger: nil,
        private_shop: "do-not-set",
        user_agent_prefix: nil,
        old_api_secret_key: nil
      )
        ShopifyAPI::Context.setup(
          api_key: api_key ? api_key : ShopifyAPI::Context.api_key,
          api_secret_key: api_secret_key ? api_secret_key : ShopifyAPI::Context.api_secret_key,
          api_version: api_version ? api_version : ShopifyAPI::Context.api_version,
          host: host ? host : ShopifyAPI::Context.host,
          scope: scope ? scope : ShopifyAPI::Context.scope.to_s,
          is_private: !is_private.nil? ? is_private : ShopifyAPI::Context.private?,
          is_embedded: !is_embedded.nil? ? is_embedded : ShopifyAPI::Context.embedded?,
          session_storage: session_storage ? session_storage : ShopifyAPI::Context.session_storage,
          logger: logger ? logger : ShopifyAPI::Context.logger,
          private_shop: private_shop != "do-not-set" ? private_shop : ShopifyAPI::Context.private_shop,
          user_agent_prefix: user_agent_prefix ? user_agent_prefix : ShopifyAPI::Context.user_agent_prefix,
          old_api_secret_key: old_api_secret_key ? old_api_secret_key : ShopifyAPI::Context.old_api_secret_key,
        )
      end
    end
  end
end
