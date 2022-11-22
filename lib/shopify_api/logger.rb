# typed: false
# frozen_string_literal: true

module ShopifyAPI
  class Logger
    LOG_LEVELS = { debug: 0, info: 1, warn: 2, error: 3, off: 6 }
    DEFAULT_LOG_LEVEL = :info

    class << self
      def send_to_logger(log_level, message)
        return unless enabled_for_log_level?(log_level)

        full_message = "#{context(log_level)} #{message}"

        ShopifyAPI::Context.logger.send(log_level, full_message)
      end

      def debug(message)
        send_to_logger(:debug, message)
      end

      def info(message)
        send_to_logger(:info, message)
      end

      def warn(message)
        send_to_logger(:warn, message)
      end

      def error(message)
        send_to_logger(:error, message)
      end

      def deprecated(message, version)
        return unless enabled_for_log_level?(:warn)

        raise Errors::FeatureDeprecatedError unless ShopifyAPI::VERSION < version

        send_to_logger(:warn, message)
      end

      def context(log_level)
        current_shop = ShopifyAPI::Context.active_session&.shop || "Shop Not Found"
        "[ ShopifyAPI | #{log_level.to_s.upcase} | #{current_shop} ]"
      end

      def enabled_for_log_level?(log_level)
        raise(Errors::LogLevelNotFoundError,
          "Invalid Log Level - #{log_level}") unless LOG_LEVELS.keys.include?(log_level)
        LOG_LEVELS[log_level] >= LOG_LEVELS[ShopifyAPI::Context.log_level || DEFAULT_LOG_LEVEL]
      end
    end
  end
end
