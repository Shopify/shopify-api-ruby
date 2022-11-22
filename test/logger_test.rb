# typed: true
# frozen_string_literal: true

require_relative "./test_helper"

module ShopifyAPITest
  class LoggerTest < Minitest::Test
    def test_call_warn
      ShopifyAPI::Logger.expects(:send_to_logger).with(:warn, "test")
      ShopifyAPI::Logger.warn("test")
    end

    def test_deprecated_should_raise_an_error_if_version_is_lower_or_equal_to_current
      parent_log_level = ShopifyAPI::Context.log_level
      ShopifyAPI::Context.log_level = :warn

      assert_raises(ShopifyAPI::Errors::FeatureDeprecatedError) do
        ShopifyAPI::Logger.deprecated("deprecated feature", ShopifyAPI::VERSION)
      end

      ShopifyAPI::Context.log_level = parent_log_level
    end

    def test_raise_an_error_if_log_level_is_invalid
      assert_raises(ShopifyAPI::Errors::LogLevelNotFoundError) do
        ShopifyAPI::Logger.enabled_for_log_level?(:not_a_log_level)
      end
    end

    def test_context_should_include_api_name
      assert(ShopifyAPI::Logger.context(:warn).match(/ShopifyAPI/))
    end
  end
end
