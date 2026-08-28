# typed: false
# frozen_string_literal: true

require_relative "test_helper"

module ShopifyAPITest
  class AppEventsTest < Test::Unit::TestCase
    def setup
      super()

      @access_token = fake_jwt(exp: Time.now.to_i + 3600, scopes: "write_global_api_app_events")
      @token_url = "https://api.shopify.com/auth/access_token"
      @events_url = "https://api.shopify.com/app/2026-07/events"
    end

    def test_log_posts_the_app_event_contract_with_a_bearer_token
      token_stub = stub_token_request
      expected_body = {
        shop_id: "23423423",
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
        shop_id: "gid://shopify/Shop/23423423",
        event_handle: "onboarding_completed",
        idempotency_key: "onboard_23423423_v3",
        attributes: { onboarding_version: 3 },
        timestamp: Time.utc(2026, 1, 27, 14, 30),
      )

      refute(result.replayed)
      assert_requested(token_stub, times: 1)
      assert_requested(event_stub, times: 1)
    end

    def test_log_reuses_the_token_across_event_requests
      token_stub = stub_token_request
      event_stub = stub_successful_event_request

      ShopifyAPI.log(**event_attributes(idempotency_key: "first"))
      ShopifyAPI.log(**event_attributes(idempotency_key: "second"))

      assert_requested(token_stub, times: 1)
      assert_requested(event_stub, times: 2)
    end

    def test_log_refreshes_the_token_once_after_an_unauthorized_response
      token_stub = stub_token_request
      event_stub = stub_request(:post, @events_url)
        .to_return(status: 401, body: { error: "unauthorized" }.to_json)
        .then.to_return(status: 202, body: { success: true }.to_json)

      result = ShopifyAPI.log(**event_attributes)

      refute(result.replayed)
      assert_requested(token_stub, times: 2)
      assert_requested(event_stub, times: 2)
    end

    def test_log_propagates_a_second_unauthorized_response
      token_stub = stub_token_request
      event_stub = stub_request(:post, @events_url)
        .to_return(status: 401, body: { error: "unauthorized" }.to_json)

      error = assert_raises(ShopifyAPI::Errors::HttpResponseError) do
        ShopifyAPI.log(**event_attributes)
      end

      assert_equal(401, error.code)
      assert_requested(token_stub, times: 2)
      assert_requested(event_stub, times: 2)
    end

    def test_log_clears_the_replacement_after_the_retried_event_is_unauthorized
      old_access_token = fake_jwt(exp: Time.now.to_i + 3600)
      replacement_access_token = fake_jwt(exp: Time.now.to_i + 7200)
      fresh_access_token = fake_jwt(exp: Time.now.to_i + 10800)
      token_stub = stub_request(:post, @token_url)
        .to_return(status: 200, body: { access_token: old_access_token }.to_json)
        .then.to_return(status: 200, body: { access_token: replacement_access_token }.to_json)
        .then.to_return(status: 200, body: { access_token: fresh_access_token }.to_json)
      event_stub = stub_request(:post, @events_url)
        .to_return(status: 401, body: { error: "unauthorized" }.to_json)
        .then.to_return(status: 401, body: { error: "unauthorized" }.to_json)
        .then.to_return(status: 202, body: { success: true }.to_json)

      assert_raises(ShopifyAPI::Errors::HttpResponseError) do
        ShopifyAPI.log(**event_attributes)
      end
      result = ShopifyAPI.log(**event_attributes(idempotency_key: "retry"))

      refute(result.replayed)
      assert_requested(token_stub, times: 3)
      assert_requested(event_stub, times: 3)
    end

    def test_log_does_not_request_an_event_or_refresh_after_token_endpoint_unauthorized
      token_stub = stub_request(:post, @token_url)
        .to_return(status: 401, body: { error: "unauthorized" }.to_json)
      event_stub = stub_successful_event_request

      error = assert_raises(ShopifyAPI::Errors::HttpResponseError) do
        ShopifyAPI.log(**event_attributes)
      end

      assert_equal(401, error.code)
      assert_requested(token_stub, times: 1)
      assert_not_requested(event_stub)
    end

    def test_log_propagates_rate_limit_retry_metadata
      stub_token_request
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

    def test_log_retries_an_in_progress_idempotency_conflict
      stub_token_request
      event_stub = stub_request(:post, @events_url)
        .to_return(
          status: 409,
          headers: { "Retry-After" => "0" },
          body: { success: false, error: "duplicate_request" }.to_json,
        )
        .then.to_return(status: 202, body: { success: true }.to_json)

      result = ShopifyAPI.log(**event_attributes)

      refute(result.replayed)
      assert_requested(event_stub, times: 2)
    end

    def test_log_uses_a_one_second_default_wait_for_an_idempotency_conflict
      stub_token_request
      event_stub = stub_request(:post, @events_url)
        .to_return(status: 409, body: { success: false, error: "duplicate_request" }.to_json)
        .then.to_return(status: 202, body: { success: true }.to_json)
      ShopifyAPI::AppEvents.expects(:sleep).with(1).once

      result = ShopifyAPI.log(**event_attributes)

      refute(result.replayed)
      assert_requested(event_stub, times: 2)
    end

    def test_log_propagates_an_idempotency_conflict_after_retries
      stub_token_request
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
      assert_requested(event_stub, times: 3)
    end

    def test_log_raises_an_http_error_for_an_empty_forbidden_response
      stub_token_request
      stub_request(:post, @events_url).to_return(status: 403, body: "")

      error = assert_raises(ShopifyAPI::Errors::HttpResponseError) do
        ShopifyAPI.log(**event_attributes)
      end

      assert_equal(403, error.code)
    end

    def test_log_includes_structured_server_errors_in_the_exception_message
      stub_token_request
      stub_request(:post, @events_url)
        .to_return(
          status: 400,
          body: {
            success: false,
            error: "Invalid request",
            errors: [{ field: "shop_id", code: "missing", message: "shop_id is required" }],
          }.to_json,
        )

      error = assert_raises(ShopifyAPI::Errors::HttpResponseError) do
        ShopifyAPI.log(**event_attributes)
      end

      assert_equal(400, error.code)
      assert_includes(error.message, "shop_id")
    end

    def test_log_marks_the_actual_replay_header_as_replayed
      stub_token_request
      stub_successful_event_request(headers: { "Idempotent-Replayed" => "true" })

      result = ShopifyAPI.log(**event_attributes)

      assert(result.replayed)
    end

    def test_log_marks_the_documented_replay_header_as_replayed
      stub_token_request
      stub_successful_event_request(headers: { "Idempotent-Replay" => "true" })

      result = ShopifyAPI.log(**event_attributes)

      assert(result.replayed)
    end

    def test_log_does_not_mark_a_false_replay_header_as_replayed
      stub_token_request
      stub_successful_event_request(headers: { "Idempotent-Replayed" => "false" })

      result = ShopifyAPI.log(**event_attributes)

      refute(result.replayed)
    end

    def test_log_ignores_a_newer_context_api_version
      modify_context(api_version: "2026-10")
      stub_token_request
      event_stub = stub_successful_event_request

      ShopifyAPI.log(**event_attributes)

      assert_requested(event_stub, times: 1)
    end

    def test_log_ignores_the_unstable_context_api_version
      modify_context(api_version: "unstable")
      stub_token_request
      event_stub = stub_successful_event_request

      ShopifyAPI.log(**event_attributes)

      assert_requested(event_stub, times: 1)
    end

    def test_log_uses_configured_global_api_versions
      ["2026-10", "unstable"].each do |global_api_version|
        modify_context(global_api_version: global_api_version)
        stub_token_request
        event_stub = stub_successful_event_request(
          url: "https://api.shopify.com/app/#{global_api_version}/events",
        )

        ShopifyAPI.log(**event_attributes)

        assert_requested(event_stub, times: 1)
      end
    end

    def test_log_rejects_an_invalid_shop_id_without_an_http_request
      token_stub = stub_token_request
      event_stub = stub_successful_event_request

      assert_raises(ShopifyAPI::Errors::InvalidAppEventError) do
        ShopifyAPI.log(**event_attributes(shop_id: "shop.myshopify.com"))
      end

      assert_not_requested(token_stub)
      assert_not_requested(event_stub)
    end

    def test_log_rejects_an_invalid_idempotency_key_without_an_http_request
      token_stub = stub_token_request
      event_stub = stub_successful_event_request

      ["", " \t", "a" * 65].each do |idempotency_key|
        assert_raises(ShopifyAPI::Errors::InvalidAppEventError) do
          ShopifyAPI.log(**event_attributes(idempotency_key: idempotency_key))
        end
      end

      assert_not_requested(token_stub)
      assert_not_requested(event_stub)
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
        shop_id: "23423423",
        event_handle: "onboarding_completed",
        idempotency_key: "onboard_23423423_v3",
        attributes: {},
        timestamp: Time.utc(2026, 1, 27, 14, 30),
      }.merge(overrides)
    end

    def stub_token_request
      stub_request(:post, @token_url)
        .with(
          body: {
            client_id: "API_KEY",
            client_secret: "API_SECRET_KEY",
            grant_type: "client_credentials",
          },
        )
        .to_return(status: 200, body: { access_token: @access_token }.to_json)
    end

    def stub_successful_event_request(url: @events_url, headers: {})
      stub_request(:post, url)
        .to_return(status: 202, headers: headers, body: { success: true }.to_json)
    end

    def fake_jwt(claims)
      encode = ->(value) { Base64.urlsafe_encode64(value.to_json, padding: false) }
      "#{encode.call({ alg: "ES256", typ: "JWT" })}.#{encode.call(claims)}.signature"
    end
  end
end
