# typed: true
# frozen_string_literal: true

require_relative "./test_helper"

module ShopifyAPITest
  class LoggerTest < Minitest::Test
    def test_deprecated_should_raise_an_error_if_version_is_lower_or_equal_to_current
      ShopifyAPI::Context.stubs(:log_level).returns(:warn)

      assert_raises(ShopifyAPI::Errors::FeatureDeprecatedError) do
        ShopifyAPI::Logger.deprecated("deprecated feature", ShopifyAPI::VERSION)
      end
    end

    def test_context_should_include_api_name
      assert(ShopifyAPI::Logger.context(:warn).match(/ShopifyAPI/))
    end
  end
end
