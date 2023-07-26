# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Logger
    LOG_LEVELS = T.let({ debug: 0, info: 1, warn: 2, error: 3, off: 6 }, T::Hash[Symbol, Integer])
    DEFAULT_LOG_LEVEL = :info

    class << self
      extend T::Sig

      sig do
        params(
          message: String,
          config: T.any(ShopifyAPI::Config, T.class_of(ShopifyAPI::Context)),
        ).void
      end
      def debug(message, config = ShopifyAPI::Context)
        send_to_logger(:debug, message, config)
      end

      sig do
        params(
          message: String,
          config: T.any(ShopifyAPI::Config, T.class_of(ShopifyAPI::Context)),
        ).void
      end
      def info(message, config = ShopifyAPI::Context)
        send_to_logger(:info, message, config)
      end

      sig do
        params(
          message: String,
          config: T.any(ShopifyAPI::Config, T.class_of(ShopifyAPI::Context)),
        ).void
      end
      def warn(message, config = ShopifyAPI::Context)
        send_to_logger(:warn, message, config)
      end

      sig do
        params(
          message: String,
          config: T.any(ShopifyAPI::Config, T.class_of(ShopifyAPI::Context)),
        ).void
      end
      def error(message, config = ShopifyAPI::Context)
        send_to_logger(:error, message, config)
      end

      sig do
        params(
          message: String,
          version: String,
          config: T.any(ShopifyAPI::Config, T.class_of(ShopifyAPI::Context)),
        ).void
      end
      def deprecated(message, version, config = ShopifyAPI::Context)
        return unless enabled_for_log_level?(:warn)

        raise Errors::FeatureDeprecatedError unless valid_version(version)

        send_to_logger(:warn, message, config)
      end

      sig { returns(T::Array[Symbol]) }
      def levels
        LOG_LEVELS.keys
      end

      private

      sig do
        params(
          log_level: Symbol,
          config: T.any(ShopifyAPI::Config, T.class_of(ShopifyAPI::Context)),
        ).returns(String)
      end
      def context(log_level, config = ShopifyAPI::Context)
        current_shop = config.active_session&.shop

        context = if current_shop.nil?
          "[ ShopifyAPI | #{log_level.to_s.upcase} ]"
        else
          "[ ShopifyAPI | #{log_level.to_s.upcase} | #{current_shop} ]"
        end
        context
      end

      sig do
        params(
          log_level: Symbol,
          message: String,
          config: T.any(ShopifyAPI::Config, T.class_of(ShopifyAPI::Context)),
        ).void
      end
      def send_to_logger(log_level, message, config = ShopifyAPI::Context)
        return unless enabled_for_log_level?(log_level)

        full_message = "#{context(log_level)} #{message}"

        config.logger.public_send(log_level, full_message)
      end

      sig do
        params(
          log_level: Symbol,
          config: T.any(ShopifyAPI::Config, T.class_of(ShopifyAPI::Context)),
        ).returns(T::Boolean)
      end
      def enabled_for_log_level?(log_level, config = ShopifyAPI::Context)
        T.must(LOG_LEVELS[log_level]) >= T.must(LOG_LEVELS[config.log_level] ||
          LOG_LEVELS[DEFAULT_LOG_LEVEL])
      end

      sig { params(version: String).returns(T::Boolean) }
      def valid_version(version)
        current_version = Gem::Version.create(ShopifyAPI::VERSION)
        deprecate_version = Gem::Version.create(version)
        current_version < deprecate_version
      end
    end
  end
end
