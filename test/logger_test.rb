# typed: true
# frozen_string_literal: true

require_relative "./test_helper"

module ShopifyAPITest
  class LoggerTest < Minitest::Test
    def test_deprecated_should_raise_an_error_if_version_is_lower_or_equal_to_current
      ShopifyAPI::Context.stubs(:log_level).returns(:warn)

      error = assert_raises(ShopifyAPI::Errors::FeatureDeprecatedError) do
        ShopifyAPI::Logger.deprecated("deprecated feature", ShopifyAPI::VERSION)
      end

      assert_equal("deprecated feature", error.message)
    end

    def test_logging_with_log_levels
      expected_log_levels = [:debug, :info, :warn, :error]
      expected_log_levels.each do |log_level|
        test_when_expected_to_log_with_active_session(log_level)
        test_when_expected_to_log_without_active_session(log_level)
      end
    end

    def test_logging_is_ignored_if_below_log_level
      loggable_levels = ShopifyAPI::Logger::LOG_LEVELS.keys - [:off]
      log_level_mapping = {
        debug: [:debug, :info, :warn, :error],
        info: [:info, :warn, :error],
        warn: [:warn, :error],
        error: [:error],
        off: [],
      }
      stub_active_session(nil)
      message = "What kind of sushi does a lumberjack order? A log roll"

      log_level_mapping.each do |log_level, expected_loggable_levels|
        ignored_log_levels = loggable_levels - expected_loggable_levels

        expected_loggable_levels.each do |expected_to_log_level|
          stub_log_level(log_level)
          ShopifyAPI::Context.logger.expects(expected_to_log_level)
          ShopifyAPI::Logger.send(expected_to_log_level, message)
        end

        ignored_log_levels.each do |ignored_log_level|
          stub_log_level(log_level)
          ShopifyAPI::Context.logger.expects(ignored_log_level).never
          ShopifyAPI::Logger.send(ignored_log_level, message)
        end
      end
    end

    private

    def test_when_expected_to_log_with_active_session(log_level)
      stub_log_level(log_level)
      message = "What did the tree say to the lumberjack? Leaf me alone"
      shop_name = "Little shop of horrors"
      stub_active_session(shop_name)
      expected_log = "#{logging_context(log_level, shop_name)} #{message}"

      ShopifyAPI::Context.logger.expects(log_level).with(expected_log)
      ShopifyAPI::Logger.public_send(log_level, message)
    end

    def test_when_expected_to_log_without_active_session(log_level)
      stub_log_level(log_level)
      message = "What did the tree say to the lumberjack? Leaf me alone"
      stub_active_session(nil)
      expected_log = "#{logging_context(log_level)} #{message}"

      ShopifyAPI::Context.logger.expects(log_level).with(expected_log)
      ShopifyAPI::Logger.public_send(log_level, message)
    end

    def stub_log_level(log_level)
      ShopifyAPI::Context.expects(:log_level).returns(log_level)
    end

    def stub_active_session(shop_name)
      if shop_name
        session = ShopifyAPI::Auth::Session.new(shop: shop_name)
        ShopifyAPI::Context.stubs(:active_session).returns(session)
      else
        ShopifyAPI::Context.stubs(:active_session).returns(nil)
      end
    end

    def logging_context(log_level, shop_name = nil)
      if shop_name
        "[ ShopifyAPI | #{log_level.to_s.upcase} | #{shop_name} ]"
      else
        "[ ShopifyAPI | #{log_level.to_s.upcase} ]"
      end
    end
  end
end
