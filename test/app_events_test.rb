# typed: false
# frozen_string_literal: true

require_relative "test_helper"

module ShopifyAPITest
  class AppEventsTest < Test::Unit::TestCase
    def setup
      super()

      @access_token = "global-api-token"
      @token_url = "https://api.shopify.com/auth/access_token"
      @events_url = "https://api.shopify.com/app/2026-10/events"
    end

    def test_log_posts_the_app_event_contract_with_a_bearer_token
      expected_body = {
        myshopify_domain: "example.myshopify.com",
        event_handle: "onboarding_completed",
        timestamp: "2026-01-27T14:30:00.000Z",
        idempotency_key: "onboard_23423423_v3",
        attributes: { onboarding_version: 3 },
      }.to_json
      event_stub = stub_request(:post, @events_url)
        .with(
          body: expected_body,
          headers: {
            "Authorization" => "Bearer #{@access_token}",
            "Content-Type" => "application/json",
          },
        )
        .to_return(status: 202, body: { success: true }.to_json)

      result = ShopifyAPI.log(
        myshopify_domain: "https://admin.shopify.com/store/example",
        event_handle: "onboarding_completed",
        idempotency_key: "onboard_23423423_v3",
        attributes: { onboarding_version: 3 },
        access_token: @access_token,
        timestamp: Time.utc(2026, 1, 27, 14, 30),
      )

      refute(result.replayed)
      assert_requested(event_stub, times: 1)
      assert_not_requested(:post, @token_url)
    end

    def test_log_propagates_rate_limit_retry_metadata
      stub_request(:post, @events_url)
        .to_return(
          status: 429,
          headers: { "Retry-After" => "30" },
          body: { success: false, error: "Rate limit exceeded" }.to_json,
        )

      error = assert_raises(ShopifyAPI::Errors::HttpResponseError) do
        ShopifyAPI.log(**event_attributes)
      end

      assert_equal(429, error.code)
      assert_equal(30.0, error.response.retry_request_after)
    end

    def test_log_surfaces_unauthorized_without_minting_or_retrying
      event_stub = stub_request(:post, @events_url)
        .to_return(status: 401, body: { error: "unauthorized" }.to_json)

      error = assert_raises(ShopifyAPI::Errors::HttpResponseError) do
        ShopifyAPI.log(**event_attributes)
      end

      assert_equal(401, error.code)
      assert_requested(event_stub, times: 1)
      assert_not_requested(:post, @token_url)
    end

    def test_log_surfaces_an_idempotency_conflict_without_retrying
      event_stub = stub_request(:post, @events_url)
        .to_return(
          status: 409,
          headers: { "Retry-After" => "0" },
          body: { success: false, error: "duplicate_request" }.to_json,
        )

      error = assert_raises(ShopifyAPI::Errors::HttpResponseError) do
        ShopifyAPI.log(**event_attributes)
      end

      assert_equal(409, error.code)
      assert_requested(event_stub, times: 1)
    end

    def test_log_raises_an_http_error_for_an_empty_forbidden_response
      stub_request(:post, @events_url).to_return(status: 403, body: "")

      error = assert_raises(ShopifyAPI::Errors::HttpResponseError) do
        ShopifyAPI.log(**event_attributes)
      end

      assert_equal(403, error.code)
    end

    def test_log_includes_structured_server_errors_in_the_exception_message
      stub_request(:post, @events_url)
        .to_return(
          status: 400,
          body: {
            success: false,
            error: "Invalid request",
            errors: [{ field: "myshopify_domain", code: "missing", message: "myshopify_domain is required" }],
          }.to_json,
        )

      error = assert_raises(ShopifyAPI::Errors::HttpResponseError) do
        ShopifyAPI.log(**event_attributes)
      end

      assert_equal(400, error.code)
      assert_includes(error.message, "myshopify_domain")
    end

    def test_log_marks_the_actual_replay_header_as_replayed
      stub_successful_event_request(headers: { "Idempotent-Replayed" => "true" })

      result = ShopifyAPI.log(**event_attributes)

      assert(result.replayed)
    end

    def test_log_marks_the_documented_replay_header_as_replayed
      stub_successful_event_request(headers: { "Idempotent-Replay" => "true" })

      result = ShopifyAPI.log(**event_attributes)

      assert(result.replayed)
    end

    def test_log_does_not_mark_a_false_replay_header_as_replayed
      stub_successful_event_request(headers: { "Idempotent-Replayed" => "false" })

      result = ShopifyAPI.log(**event_attributes)

      refute(result.replayed)
    end

    def test_log_ignores_a_newer_context_api_version
      modify_context(api_version: "2026-10")
      event_stub = stub_successful_event_request

      ShopifyAPI.log(**event_attributes)

      assert_requested(event_stub, times: 1)
    end

    def test_log_ignores_the_unstable_context_api_version
      modify_context(api_version: "unstable")
      event_stub = stub_successful_event_request

      ShopifyAPI.log(**event_attributes)

      assert_requested(event_stub, times: 1)
    end

    def test_log_uses_configured_global_api_versions
      ["2026-10", "unstable"].each do |global_api_version|
        modify_context(global_api_version: global_api_version)
        event_stub = stub_successful_event_request(
          url: "https://api.shopify.com/app/#{global_api_version}/events",
        )

        ShopifyAPI.log(**event_attributes)

        assert_requested(event_stub, times: 1)
      end
    end

    def test_log_rejects_a_blank_access_token_without_an_http_request
      event_stub = stub_successful_event_request

      ["", " \t"].each do |access_token|
        assert_raises(ShopifyAPI::Errors::MissingRequiredArgumentError) do
          ShopifyAPI.log(**event_attributes(access_token: access_token))
        end
      end

      assert_not_requested(event_stub)
    end

    def test_log_rejects_an_invalid_myshopify_domain_without_an_http_request
      event_stub = stub_successful_event_request

      ["23423423", "gid://shopify/Shop/23423423", "attacker.example", ""].each do |myshopify_domain|
        assert_raises(ShopifyAPI::Errors::InvalidShopError) do
          ShopifyAPI.log(**event_attributes(myshopify_domain: myshopify_domain))
        end
      end

      assert_raises(TypeError) do
        ShopifyAPI.log(**event_attributes(myshopify_domain: 23423423))
      end

      assert_not_requested(event_stub)
    end

    def test_log_rejects_blank_but_accepts_a_long_idempotency_key
      event_stub = stub_successful_event_request

      ["", " \t"].each do |idempotency_key|
        assert_raises(ShopifyAPI::Errors::InvalidAppEventError) do
          ShopifyAPI.log(**event_attributes(idempotency_key: idempotency_key))
        end
      end

      assert_not_requested(event_stub)

      ShopifyAPI.log(**event_attributes(idempotency_key: "a" * 65))

      assert_requested(event_stub)
    end

    def test_log_requires_context_setup
      modify_context(api_key: "", api_secret_key: "", host: "")

      assert_raises(ShopifyAPI::Errors::ContextNotSetupError) do
        ShopifyAPI.log(**event_attributes)
      end
    end

    private

    def event_attributes(**overrides)
      {
        myshopify_domain: "example.myshopify.com",
        access_token: @access_token,
        event_handle: "onboarding_completed",
        idempotency_key: "onboard_23423423_v3",
        attributes: {},
        timestamp: Time.utc(2026, 1, 27, 14, 30),
      }.merge(overrides)
    end

    def stub_successful_event_request(url: @events_url, headers: {})
      stub_request(:post, url)
        .to_return(status: 202, headers: headers, body: { success: true }.to_json)
    end
  end
end
