# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Logger
    LOG_LEVELS = T.let({ debug: 0, info: 1, warn: 2, error: 3, off: 6 }, T::Hash[Symbol, Integer])
    DEFAULT_LOG_LEVEL = :info

    class << self
      extend T::Sig

      sig { params(message: String).void }
      def debug(message)
        send_to_logger(:debug, message)
      end

      sig { params(message: String).void }
      def info(message)
        send_to_logger(:info, message)
      end

      sig { params(message: String).void }
      def warn(message)
        send_to_logger(:warn, message)
      end

      sig { params(message: String).void }
      def error(message)
        send_to_logger(:error, message)
      end

      sig { params(message: String, version: String).void }
      def deprecated(message, version)
        return unless enabled_for_log_level?(:warn)

        raise Errors::FeatureDeprecatedError unless ShopifyAPI::VERSION < version

        send_to_logger(:warn, message)
      end

      sig { params(log_level: Symbol).returns(String) }
      def context(log_level)
        current_shop = ShopifyAPI::Context.active_session&.shop || "Shop Not Found"
        "[ ShopifyAPI | #{log_level.to_s.upcase} | #{current_shop} ]"
      end

      private

      sig { params(log_level: Symbol, message: String).void }
      def send_to_logger(log_level, message)
        return unless enabled_for_log_level?(log_level)

        full_message = "#{context(log_level)} #{message}"

        ShopifyAPI::Context.logger.send(log_level, full_message)
      end

      sig { params(log_level: Symbol).returns(T::Boolean) }
      def enabled_for_log_level?(log_level)
        raise(Errors::LogLevelNotFoundError,
          "Invalid Log Level - #{log_level}") unless LOG_LEVELS.keys.include?(log_level)
        T.must(LOG_LEVELS[log_level]) >= T.must(LOG_LEVELS[ShopifyAPI::Context.log_level] ||
          LOG_LEVELS[DEFAULT_LOG_LEVEL])
      end
    end
  end
end
