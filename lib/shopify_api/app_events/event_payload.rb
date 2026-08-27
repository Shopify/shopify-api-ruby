# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module AppEvents
    module EventPayload
      extend T::Sig

      MAX_IDEMPOTENCY_KEY_LENGTH = 64
      MAX_ATTRIBUTE_KEYS = 15
      MAX_ATTRIBUTE_KEY_LENGTH = 64
      MAX_ATTRIBUTE_STRING_VALUE_LENGTH = 128
      MAX_FUTURE_TIMESTAMP_SECONDS = 300
      ATTRIBUTE_KEY_PATTERN = /\A[a-zA-Z0-9_.\-]+\z/
      SHOP_GID_PREFIX = "gid://shopify/Shop/"
      NUMERIC_ID_PATTERN = /\A\d+\z/
      ALLOWED_ATTRIBUTE_VALUE_TYPES = T.let(
        [String, Integer, Float, TrueClass, FalseClass],
        T::Array[Module],
      )

      class << self
        extend T::Sig

        sig do
          params(
            shop_id: T.any(String, Integer),
            event_handle: String,
            idempotency_key: String,
            attributes: T::Hash[T.any(String, Symbol), T.untyped],
            timestamp: T.nilable(Time),
          ).returns(T::Hash[Symbol, T.untyped])
        end
        def build(shop_id:, event_handle:, idempotency_key:, attributes:, timestamp: nil)
          normalized_shop_id = String(shop_id).delete_prefix(SHOP_GID_PREFIX)
          unless NUMERIC_ID_PATTERN.match?(normalized_shop_id)
            raise Errors::InvalidAppEventError, "shop_id must be a numeric ID or Shopify Shop GID"
          end

          if event_handle.strip.empty?
            raise Errors::InvalidAppEventError, "event_handle must not be blank"
          end

          if idempotency_key.strip.empty?
            raise Errors::InvalidAppEventError, "idempotency_key must not be blank"
          end

          if idempotency_key.length > MAX_IDEMPOTENCY_KEY_LENGTH
            raise Errors::InvalidAppEventError,
              "idempotency_key must be at most #{MAX_IDEMPOTENCY_KEY_LENGTH} characters"
          end

          event_timestamp = timestamp || Time.now
          if event_timestamp > Time.now + MAX_FUTURE_TIMESTAMP_SECONDS
            raise Errors::InvalidAppEventError,
              "timestamp must not be more than #{MAX_FUTURE_TIMESTAMP_SECONDS} seconds in the future"
          end

          payload = {
            shop_id: normalized_shop_id,
            event_handle: event_handle,
            timestamp: event_timestamp.utc.strftime("%FT%T.%LZ"),
            idempotency_key: idempotency_key,
          }

          payload[:attributes] = normalize_attributes(attributes)
          payload
        end

        private

        sig do
          params(
            attributes: T::Hash[T.any(String, Symbol), T.untyped],
          ).returns(T::Hash[String, T.untyped])
        end
        def normalize_attributes(attributes)
          normalized = T.let({}, T::Hash[String, T.untyped])
          attributes.each do |raw_key, value|
            key = raw_key.to_s
            if normalized.key?(key)
              raise Errors::InvalidAppEventError,
                "attributes contains duplicate key #{key.inspect} after key stringification"
            end

            normalized[key] = value
          end

          if normalized.length > MAX_ATTRIBUTE_KEYS
            raise Errors::InvalidAppEventError, "attributes must contain at most #{MAX_ATTRIBUTE_KEYS} keys"
          end

          normalized.each do |key, value|
            validate_attribute_key(key)
            validate_attribute_value(key, value)
          end

          normalized
        end

        sig { params(key: String).void }
        def validate_attribute_key(key)
          unless ATTRIBUTE_KEY_PATTERN.match?(key)
            raise Errors::InvalidAppEventError,
              "attributes key #{key.inspect} may contain only letters, numbers, underscores, periods, and hyphens"
          end
          if key.length > MAX_ATTRIBUTE_KEY_LENGTH
            raise Errors::InvalidAppEventError,
              "attributes key #{key.inspect} must be at most #{MAX_ATTRIBUTE_KEY_LENGTH} characters"
          end
        end

        sig { params(key: String, value: T.untyped).void }
        def validate_attribute_value(key, value)
          unless ALLOWED_ATTRIBUTE_VALUE_TYPES.include?(value.class)
            raise Errors::InvalidAppEventError,
              "attributes value for #{key.inspect} must be a String, Integer, Float, true, or false"
          end
          if value.is_a?(Float) && !value.finite?
            raise Errors::InvalidAppEventError, "attributes Float value for #{key.inspect} must be finite"
          end

          if value.is_a?(String) && value.length > MAX_ATTRIBUTE_STRING_VALUE_LENGTH
            raise Errors::InvalidAppEventError,
              "attributes String value for #{key.inspect} must be at most " \
                "#{MAX_ATTRIBUTE_STRING_VALUE_LENGTH} characters"
          end
        end
      end
    end
  end
end
