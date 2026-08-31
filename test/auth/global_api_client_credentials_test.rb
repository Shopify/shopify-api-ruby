# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

module ShopifyAPITest
  module Auth
    class GlobalApiClientCredentialsTest < Test::Unit::TestCase
      def setup
        super()

        @token_url = "https://api.shopify.com/auth/access_token"
        @request_body = {
          client_id: "API_KEY",
          client_secret: "API_SECRET_KEY",
          grant_type: "client_credentials",
        }
      end

      def test_global_api_client_credentials_posts_credentials_and_returns_a_token
        expires_at = Time.now.to_i + 3600
        access_token = fake_jwt(exp: expires_at)
        stub = stub_token_request(access_token: access_token)

        token = ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials

        assert_equal(access_token, token.access_token)
        assert_in_delta(Time.at(expires_at).utc, token.expires_at, 1)
        assert_requested(stub, times: 1)
      end

      def test_global_api_client_credentials_uses_fallback_ttl_for_opaque_token
        started_at = Time.now
        stub_token_request(access_token: "opaque-token")

        token = ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials

        assert_in_delta(started_at + 300, token.expires_at, 2)
      end

      def test_global_api_client_credentials_uses_response_expiry_for_opaque_token
        started_at = Time.now
        stub_token_request(access_token: "opaque-token", expires_in: 900)

        token = ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials

        assert_in_delta(started_at + 900, token.expires_at, 2)
      end

      def test_global_api_client_credentials_prefers_response_expiry_over_jwt_claims
        started_at = Time.now
        access_token = fake_jwt(exp: started_at.to_i + 3600)
        stub_token_request(access_token: access_token, expires_in: 900)

        token = ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials

        assert_in_delta(started_at + 900, token.expires_at, 2)
      end

      def test_global_api_client_credentials_reuses_a_cached_token
        access_token = fake_jwt(exp: Time.now.to_i + 3600)
        stub = stub_token_request(access_token: access_token)

        first = ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials
        second = ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials

        assert_equal(access_token, first.access_token)
        assert_equal(access_token, second.access_token)
        assert_requested(stub, times: 1)
      end

      def test_global_api_client_credentials_reuses_a_replacement_for_a_late_rejected_token
        old_access_token = fake_jwt(exp: Time.now.to_i + 3600)
        replacement_access_token = fake_jwt(exp: Time.now.to_i + 7200)
        stub = stub_request(:post, @token_url)
          .with(body: @request_body)
          .to_return(status: 200, body: { access_token: old_access_token }.to_json)
          .then.to_return(status: 200, body: { access_token: replacement_access_token }.to_json)

        ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials
        first_replacement = ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials(
          rejected_access_token: old_access_token,
        )
        late_replacement = ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials(
          rejected_access_token: old_access_token,
        )

        assert_equal(replacement_access_token, first_replacement.access_token)
        assert_equal(replacement_access_token, late_replacement.access_token)
        assert_requested(stub, times: 2)
      end

      def test_global_api_client_credentials_clears_a_rejected_token_when_refresh_fails
        old_access_token = fake_jwt(exp: Time.now.to_i + 3600)
        fresh_access_token = fake_jwt(exp: Time.now.to_i + 7200)
        stub = stub_request(:post, @token_url)
          .with(body: @request_body)
          .to_return(status: 200, body: { access_token: old_access_token }.to_json)
          .then.to_return(status: 401, body: { error: "unauthorized" }.to_json)
          .then.to_return(status: 200, body: { access_token: fresh_access_token }.to_json)

        ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials
        assert_raises(ShopifyAPI::Errors::HttpResponseError) do
          ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials(
            rejected_access_token: old_access_token,
          )
        end
        token = ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials

        assert_equal(fresh_access_token, token.access_token)
        assert_requested(stub, times: 3)
      end

      def test_global_api_client_credentials_refreshes_a_token_inside_expiry_skew
        expiring_token = fake_jwt(exp: Time.now.to_i + 30)
        fresh_token = fake_jwt(exp: Time.now.to_i + 3600)
        stub = stub_request(:post, @token_url)
          .with(body: @request_body)
          .to_return(status: 200, body: { access_token: expiring_token }.to_json)
          .then.to_return(status: 200, body: { access_token: fresh_token }.to_json)

        first = ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials
        second = ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials

        assert_equal(expiring_token, first.access_token)
        assert_equal(fresh_token, second.access_token)
        assert_requested(stub, times: 2)
      end

      def test_global_api_client_credentials_propagates_token_endpoint_errors
        stub_request(:post, @token_url)
          .with(body: @request_body)
          .to_return(
            status: 400,
            body: {
              error: "application_cannot_be_found",
              error_description: "The application cannot be found",
            }.to_json,
          )

        error = assert_raises(ShopifyAPI::Errors::HttpResponseError) do
          ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials
        end

        assert_equal(400, error.code)
      end

      def test_global_api_client_credentials_rejects_a_response_without_an_access_token
        stub_request(:post, @token_url)
          .with(body: @request_body)
          .to_return(status: 200, body: { token_type: "Bearer" }.to_json)

        error = assert_raises(ShopifyAPI::Errors::RequestAccessTokenError) do
          ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials
        end

        assert_equal("Global API token response did not include an access_token", error.message)
      end

      def test_global_api_client_credentials_uses_the_configured_global_api_url
        modify_context(global_api_url: "https://api.my-spin.shopify.io")
        custom_url = "https://api.my-spin.shopify.io/auth/access_token"
        access_token = fake_jwt(exp: Time.now.to_i + 3600)
        stub = stub_request(:post, custom_url)
          .with(body: @request_body)
          .to_return(status: 200, body: { access_token: access_token }.to_json)

        token = ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials

        assert_equal(access_token, token.access_token)
        assert_requested(stub, times: 1)
      end

      def test_context_setup_clears_the_cached_global_api_token
        access_token = fake_jwt(exp: Time.now.to_i + 3600)
        stub = stub_token_request(access_token: access_token)
        ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials

        modify_context
        token = ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials

        assert_equal(access_token, token.access_token)
        assert_requested(stub, times: 2)
      end

      def test_global_api_client_credentials_requires_context_setup
        modify_context(api_key: "", api_secret_key: "", host: "")

        assert_raises(ShopifyAPI::Errors::ContextNotSetupError) do
          ShopifyAPI::Auth::GlobalApiClientCredentials.global_api_client_credentials
        end
      end

      private

      def stub_token_request(access_token:, expires_in: nil)
        body = { access_token: access_token }
        body[:expires_in] = expires_in unless expires_in.nil?
        stub_request(:post, @token_url)
          .with(body: @request_body)
          .to_return(status: 200, body: body.to_json)
      end

      def fake_jwt(claims)
        encode = ->(value) { Base64.urlsafe_encode64(value.to_json, padding: false) }
        "#{encode.call({ alg: "ES256", typ: "JWT" })}.#{encode.call(claims)}.signature"
      end
    end
  end
end
