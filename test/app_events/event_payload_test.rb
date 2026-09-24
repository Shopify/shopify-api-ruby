# typed: false
# frozen_string_literal: true

require "time"
require_relative "../test_helper"

module ShopifyAPITest
  module AppEvents
    class EventPayloadTest < Test::Unit::TestCase
      def test_build_normalizes_admin_urls_to_the_myshopify_domain
        [
          "example.myshopify.com",
          "Example.MyShopify.com",
          "https://example.myshopify.com",
          "https://example.myshopify.com/admin",
          "https://admin.shopify.com/store/example",
        ].each do |myshopify_domain|
          payload = build_payload(myshopify_domain: myshopify_domain)

          assert_equal("example.myshopify.com", payload[:myshopify_domain])
        end
      end

      def test_build_rejects_ids_and_untrusted_domains
        ["23423423", "gid://shopify/Shop/23423423", "attacker.example", "", "myshopify.com"].each do |myshopify_domain|
          assert_raises(ShopifyAPI::Errors::InvalidShopError) do
            build_payload(myshopify_domain: myshopify_domain)
          end
        end
      end

      def test_build_rejects_a_non_string_myshopify_domain_at_the_typed_boundary
        assert_raises(TypeError) do
          build_payload(myshopify_domain: 23423423)
        end
      end

      def test_build_rejects_a_blank_event_handle
        ["", " \t"].each do |event_handle|
          assert_raises(ShopifyAPI::Errors::InvalidAppEventError) do
            build_payload(event_handle: event_handle)
          end
        end
      end

      def test_build_rejects_a_blank_idempotency_key
        ["", " \t"].each do |idempotency_key|
          assert_raises(ShopifyAPI::Errors::InvalidAppEventError) do
            build_payload(idempotency_key: idempotency_key)
          end
        end
      end

      def test_build_accepts_an_idempotency_key_longer_than_the_previous_limit
        idempotency_key = "a" * 65
        payload = build_payload(idempotency_key: idempotency_key)

        assert_equal(idempotency_key, payload[:idempotency_key])
      end

      def test_build_uses_the_current_time_when_timestamp_is_omitted
        started_at = Time.now

        payload = build_payload
        timestamp = Time.iso8601(payload[:timestamp])

        assert_match(/\A\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z\z/, payload[:timestamp])
        assert_in_delta(started_at, timestamp, 2)
      end

      def test_build_serializes_timestamps_as_utc_with_milliseconds
        utc_payload = build_payload(timestamp: Time.utc(2026, 1, 27, 14, 30))
        offset_payload = build_payload(timestamp: Time.new(2026, 1, 27, 9, 30, 0, "-05:00"))

        assert_equal("2026-01-27T14:30:00.000Z", utc_payload[:timestamp])
        assert_equal("2026-01-27T14:30:00.000Z", offset_payload[:timestamp])
      end

      def test_build_accepts_a_timestamp_beyond_the_previous_limit
        timestamp = Time.now + 301

        payload = build_payload(timestamp: timestamp)

        assert_equal(timestamp.utc.strftime("%FT%T.%LZ"), payload[:timestamp])
      end

      def test_build_accepts_a_timestamp_within_the_previous_limit
        timestamp = Time.now + 299

        payload = build_payload(timestamp: timestamp)

        assert_equal(timestamp.utc.strftime("%FT%T.%LZ"), payload[:timestamp])
      end

      def test_build_accepts_more_than_the_previous_attribute_count_limit
        attributes = 16.times.to_h { |index| ["key_#{index}", index] }

        payload = build_payload(attributes: attributes)

        assert_equal(attributes, payload[:attributes])
      end

      def test_build_stringifies_symbol_attribute_keys
        payload = build_payload(attributes: { onboarding_version: 3 })

        assert_equal({ "onboarding_version" => 3 }, payload[:attributes])
      end

      def test_build_rejects_attribute_keys_that_collide_after_stringification
        assert_raises(ShopifyAPI::Errors::InvalidAppEventError) do
          build_payload(attributes: { "a" => 1, a: 2 })
        end
      end

      def test_build_rejects_attribute_keys_with_invalid_characters
        assert_raises(ShopifyAPI::Errors::InvalidAppEventError) do
          build_payload(attributes: { "bad key" => 1 })
        end
      end

      def test_build_accepts_an_attribute_key_longer_than_the_previous_limit
        key = "a" * 65
        payload = build_payload(attributes: { key => 1 })

        assert_equal({ key => 1 }, payload[:attributes])
      end

      def test_build_accepts_an_attribute_string_value_longer_than_the_previous_limit
        value = "a" * 129
        payload = build_payload(attributes: { value: value })

        assert_equal({ "value" => value }, payload[:attributes])
      end

      def test_build_rejects_unsupported_and_non_finite_attribute_values
        [nil, :sym, Float::INFINITY, {}, []].each do |value|
          assert_raises(ShopifyAPI::Errors::InvalidAppEventError) do
            build_payload(attributes: { value: value })
          end
        end
      end

      def test_build_accepts_float_and_boolean_attribute_values
        payload = build_payload(attributes: { ratio: 1.5, complete: true })
        assert_equal({ "ratio" => 1.5, "complete" => true }, payload[:attributes])
      end

      def test_build_always_sends_attributes_because_the_api_requires_them
        payload = build_payload(attributes: {})

        assert_equal({}, payload[:attributes])
      end

      def test_build_rejects_a_non_time_timestamp_at_the_typed_boundary
        assert_raises(TypeError) do
          build_payload(timestamp: "2026-01-27")
        end
      end

      private

      def build_payload(**overrides)
        ShopifyAPI::AppEvents::EventPayload.build(
          myshopify_domain: "example.myshopify.com",
          event_handle: "onboarding_completed",
          idempotency_key: "onboard_23423423_v3",
          attributes: {},
          **overrides,
        )
      end
    end
  end
end
