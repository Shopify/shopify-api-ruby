# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

module ShopifyAPITest
  module Auth
    class ClientCredentialsTest < Test::Unit::TestCase
      # Generated once per process: key generation is slow and no expected value depends on which key it is.
      EC_PRIVATE_KEY = OpenSSL::PKey::EC.generate("prime256v1")

      def setup
        super()

        @shop = "test-shop.myshopify.com"
        @client_credentials_request = {
          client_id: ShopifyAPI::Context.api_key,
          client_secret: ShopifyAPI::Context.api_secret_key,
          grant_type: "client_credentials",
        }
        @offline_token_response = {
          access_token: SecureRandom.alphanumeric(10),
          scope: "scope1,scope2",
          expires_in: 1000,
        }
        @assertion = "header.payload.signature"
        @client_assertion_request = {
          client_id: ShopifyAPI::Context.api_key,
          grant_type: "client_credentials",
          client_assertion_type: "urn:ietf:params:oauth:client-assertion-type:jwt-bearer",
          client_assertion: @assertion,
        }
        @token_url = "https://#{@shop}/admin/oauth/access_token"
      end

      def test_client_credentials_context_not_setup
        modify_context(api_key: "", api_secret_key: "", host: "")

        assert_raises(ShopifyAPI::Errors::ContextNotSetupError) do
          ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop)
        end
      end

      def test_client_credentials_rejects_non_shopify_domain
        assert_raises(ShopifyAPI::Errors::InvalidShopError) do
          ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: "attacker.example")
        end
      end

      def test_client_credentials_offline_token
        stub_request(:post, "https://#{@shop}/admin/oauth/access_token")
          .with(body: @client_credentials_request)
          .to_return(body: @offline_token_response.to_json, headers: { content_type: "application/json" })
        expected_session = ShopifyAPI::Auth::Session.new(
          id: "offline_#{@shop}",
          shop: @shop,
          access_token: @offline_token_response[:access_token],
          scope: @offline_token_response[:scope],
          is_online: false,
          expires: Time.now + @offline_token_response[:expires_in].to_i,
        )

        session = ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop)

        assert_equal(expected_session, session)
      end

      def test_client_credentials_with_nil_assertion_sends_the_existing_client_secret_body
        stub_token_request(body: @client_credentials_request)

        ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop, client_assertion: nil)

        assert_requested(:post, @token_url, times: 1)
      end

      def test_client_credentials_with_assertion_sends_only_the_four_assertion_fields
        captured_request = capture_token_request

        ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop, client_assertion: @assertion)

        assert_equal(
          {
            "client_id" => ShopifyAPI::Context.api_key,
            "grant_type" => "client_credentials",
            "client_assertion_type" => "urn:ietf:params:oauth:client-assertion-type:jwt-bearer",
            "client_assertion" => @assertion,
          },
          JSON.parse(captured_request.last.body),
        )
      end

      # Deliberately literal-free on both sides: the audience comes out of the signed assertion and the stub
      # is built from it, so a divergence between the signer's `aud` and the posted URL fails here.
      def test_client_credentials_posts_to_the_url_the_signed_assertion_names_as_its_audience
        assertion = ShopifyAPI::Auth::ClientAssertion.create(
          shop: @shop,
          client_id: ShopifyAPI::Context.api_key,
          kid: "test-key-2026-10",
          private_key: EC_PRIVATE_KEY,
        )
        audience = JWT.decode(assertion, nil, false).first["aud"]
        stub_request(:post, audience)
          .to_return(body: @offline_token_response.to_json, headers: { content_type: "application/json" })

        session = ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop, client_assertion: assertion)

        assert_requested(:post, audience, times: 1)
        assert_equal(@offline_token_response[:access_token], session.access_token)
      end

      def test_client_credentials_with_assertion_sends_no_credential_headers
        captured_request = capture_token_request

        ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop, client_assertion: @assertion)

        header_names = captured_request.last.headers.keys.map(&:downcase)

        refute_includes(header_names, "x-shopify-access-token")
        refute_includes(header_names, "authorization")
      end

      # The exact-body assertion above covers the body alone; this covers the whole serialized request, so a
      # later change to the body shape cannot quietly reintroduce the secret somewhere else.
      def test_client_credentials_with_assertion_sends_the_configured_secret_nowhere
        sentinel = "SENTINEL-SECRET-DO-NOT-SEND"
        modify_context(api_secret_key: sentinel)
        assertion = ShopifyAPI::Auth::ClientAssertion.create(
          shop: @shop,
          kid: "test-key-2026-10",
          private_key: EC_PRIVATE_KEY,
        )
        captured_request = capture_token_request

        ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop, client_assertion: assertion)

        request = captured_request.fetch(0)
        claims, header = JWT.decode(assertion, nil, false)

        refute_includes(assertion, sentinel)
        refute_includes(claims.to_json, sentinel)
        refute_includes(header.to_json, sentinel)
        refute_includes(request.body.to_s, sentinel)
        refute_includes(request.headers.to_s, sentinel)
        refute_includes(request.uri.to_s, sentinel)
      end

      def test_client_credentials_with_assertion_returns_a_session_with_scopes_and_expiry
        stub_token_request(
          body: @client_assertion_request,
          response: @offline_token_response.merge(expires_in: 3600),
        )

        session = ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop, client_assertion: @assertion)

        assert_equal("offline_#{@shop}", session.id)
        assert_equal(@offline_token_response[:access_token], session.access_token)
        assert_equal("scope1,scope2", session.scope.to_s)
        assert_nil(session.refresh_token)
        assert_in_delta(Time.now.to_i + 3600, session.expires.to_i, 5)
      end

      def test_client_credentials_with_assertion_uses_the_response_expiry_for_a_custom_app_lifetime
        stub_token_request(
          body: @client_assertion_request,
          response: @offline_token_response.merge(expires_in: 86_400),
        )

        session = ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop, client_assertion: @assertion)

        assert_in_delta(Time.now.to_i + 86_400, session.expires.to_i, 5)
      end

      def test_client_credentials_rejects_a_blank_assertion_without_falling_back_to_the_secret
        ["", "   "].each do |client_assertion|
          assert_raises(ShopifyAPI::Errors::InvalidClientAssertionError) do
            ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop, client_assertion:)
          end
        end

        assert_not_requested(:post, @token_url)
      end

      # A value read from a file or pasted from a terminal arrives with a newline, and the server compares
      # the assertion byte for byte, so sending it would fail with an opaque `invalid_client`.
      def test_client_credentials_rejects_an_assertion_with_surrounding_whitespace
        [" #{@assertion}", "#{@assertion}\n"].each do |client_assertion|
          error = assert_raises(ShopifyAPI::Errors::InvalidClientAssertionError) do
            ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop, client_assertion:)
          end

          assert_match(/must not have leading or trailing whitespace/, error.message)
        end

        assert_not_requested(:post, @token_url)
      end

      def test_client_credentials_rejects_a_non_string_assertion_without_echoing_the_supplied_value
        error = assert_raises(ShopifyAPI::Errors::InvalidClientAssertionError) do
          ShopifyAPI::Auth::ClientCredentials.client_credentials(
            shop: @shop,
            client_assertion: { assertion: "SUPER-SECRET-ASSERTION" },
          )
        end

        assert_equal("client_assertion must be a String, got: Hash", error.message)
        refute_includes(error.message, "SECRET")
        assert_not_requested(:post, @token_url)
      end

      def test_client_credentials_with_assertion_makes_one_attempt_on_server_error_statuses
        [429, 500, 503].each do |status|
          WebMock.reset!
          stub_request(:post, @token_url).to_return(status: status, body: "{}")

          assert_raises(ShopifyAPI::Errors::HttpResponseError) do
            ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop, client_assertion: @assertion)
          end

          assert_requested(:post, @token_url, times: 1)
        end
      end

      def test_client_credentials_with_assertion_makes_one_attempt_when_the_connection_times_out
        stub_request(:post, @token_url).to_timeout

        assert_raises(Net::OpenTimeout) do
          ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop, client_assertion: @assertion)
        end

        assert_requested(:post, @token_url, times: 1)
      end

      def test_client_credentials_with_assertion_raises_without_retrying_on_an_invalid_client_response
        stub_request(:post, @token_url)
          .to_return(status: 401, body: { error: "invalid_client" }.to_json)

        error = assert_raises(ShopifyAPI::Errors::HttpResponseError) do
          ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop, client_assertion: @assertion)
        end

        assert_equal(401, error.code)
        assert_requested(:post, @token_url, times: 1)
      end

      def test_client_credentials_rejects_redirects_with_either_authentication_method
        [nil, @assertion].each do |assertion|
          [301, 302, 303, 307, 308].each do |status|
            ["", "<html>redirect</html>", @offline_token_response.to_json].each do |body|
              WebMock.reset!
              redirect_url = "https://other-shop.myshopify.com/admin/oauth/access_token"
              expected_body = assertion.nil? ? @client_credentials_request : @client_assertion_request
              stub_request(:post, @token_url).with(body: expected_body)
                .to_return(status: status, headers: { "Location" => redirect_url }, body: body)
              stub_request(:post, redirect_url).to_return(body: @offline_token_response.to_json)
              stub_request(:get, redirect_url).to_return(body: @offline_token_response.to_json)

              error = assert_raises(ShopifyAPI::Errors::HttpResponseError) do
                ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop, client_assertion: assertion)
              end

              assert_equal(status, error.code)
              assert_match(/Refused to follow the #{status} redirect to #{Regexp.escape(redirect_url)}/, error.message)
              assert_requested(:post, @token_url, times: 1)
              assert_not_requested(:post, redirect_url)
              assert_not_requested(:get, redirect_url)
            end
          end
        end
      end

      def test_client_credentials_overrides_enabled_redirect_defaults_without_changing_them
        inherited_options = HTTParty::Basement.default_options.merge(follow_redirects: true)
        HTTParty::Basement.stubs(:default_options).returns(inherited_options)
        redirect_url = "https://#{@shop}/admin/oauth/access_token_redirected"
        stub_request(:post, @token_url).with(body: @client_credentials_request)
          .to_return(status: 302, headers: { "Location" => redirect_url }, body: "")
        stub_request(:get, redirect_url).to_return(body: @offline_token_response.to_json)

        assert_raises(ShopifyAPI::Errors::HttpResponseError) do
          ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop)
        end

        assert_requested(:post, @token_url, times: 1)
        assert_not_requested(:get, redirect_url)
        assert_equal(true, inherited_options[:follow_redirects])
      end

      def test_client_credentials_with_assertion_disables_inherited_basic_auth_and_keeps_other_headers
        inherited_options = HTTParty::Basement.default_options.merge(
          basic_auth: { username: "inherited-user", password: "inherited-password" },
          headers: { "X-Global" => "1" },
        )
        HTTParty::Basement.stubs(:default_options).returns(inherited_options)
        captured_request = capture_token_request

        ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop, client_assertion: @assertion)

        header_names = captured_request.last.headers.keys.map(&:downcase)

        refute_includes(header_names, "authorization")
        refute_includes(header_names, "x-shopify-access-token")
        assert_equal("1", captured_request.last.headers["X-Global"])
      end

      def test_client_credentials_with_assertion_disables_digest_auth_without_a_challenge_retry
        inherited_options = HTTParty::Basement.default_options.merge(
          digest_auth: { username: "inherited-user", password: "inherited-password" },
        )
        HTTParty::Basement.stubs(:default_options).returns(inherited_options)
        stub_request(:post, @token_url).to_return(
          status: 401,
          body: { error: "invalid_client" }.to_json,
          headers: { "WWW-Authenticate" => 'Digest realm="shop", nonce="nonce", qop="auth"' },
        )

        assert_raises(ShopifyAPI::Errors::HttpResponseError) do
          ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop, client_assertion: @assertion)
        end

        assert_requested(:post, @token_url, times: 1)
        assert_equal("inherited-user", inherited_options.dig(:digest_auth, :username))
      end

      def test_client_credentials_without_assertion_still_inherits_httparty_credentials
        stub_inherited_httparty_credentials
        captured_request = capture_token_request

        ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop)

        header_names = captured_request.last.headers.keys.map(&:downcase)

        assert_includes(header_names, "authorization")
        assert_includes(header_names, "x-global")
      end

      def test_client_credentials_with_assertion_fails_before_io_when_api_host_carries_credentials
        modify_context(api_host: "user:password@internal.example.com")

        error = assert_raises(ShopifyAPI::Errors::InvalidHttpRequestError) do
          ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop, client_assertion: @assertion)
        end

        assert_match(/URL containing credentials/, error.message)
        assert_not_requested(:post, @token_url)
      end

      def test_client_credentials_without_assertion_honours_an_inherited_disabled_redirect_policy
        inherited_options = HTTParty::Basement.default_options.merge(follow_redirects: false)
        HTTParty::Basement.stubs(:default_options).returns(inherited_options)
        redirect_url = "https://#{@shop}/admin/oauth/access_token_redirected"
        stub_request(:post, @token_url).to_return(status: 302, headers: { "Location" => redirect_url }, body: "")
        stub_request(:get, redirect_url)
          .to_return(body: @offline_token_response.to_json, headers: { content_type: "application/json" })

        assert_raises(ShopifyAPI::Errors::HttpResponseError) do
          ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop)
        end

        assert_not_requested(:get, redirect_url)
      end

      def test_client_credentials_with_assertion_does_not_log_the_assertion
        log_output = StringIO.new
        modify_context(logger: ::Logger.new(log_output))
        stub_request(:post, @token_url).to_return(status: 401, body: { error: "invalid_client" }.to_json)

        error = assert_raises(ShopifyAPI::Errors::HttpResponseError) do
          ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop, client_assertion: @assertion)
        end

        refute_includes(log_output.string, @assertion)
        refute_includes(error.message, @assertion)
      end

      private

      def stub_token_request(body:, response: @offline_token_response)
        stub_request(:post, @token_url)
          .with(body: body)
          .to_return(body: response.to_json, headers: { content_type: "application/json" })
      end

      def capture_token_request
        captured_request = []
        stub_request(:post, @token_url)
          .with { |request| captured_request << request }
          .to_return(body: @offline_token_response.to_json, headers: { content_type: "application/json" })
        captured_request
      end

      def stub_inherited_httparty_credentials
        inherited_options = HTTParty::Basement.default_options.merge(
          basic_auth: { username: "inherited-user", password: "inherited-password" },
          headers: { "Authorization" => "Bearer INHERITED", "X-Global" => "1" },
        )
        HTTParty::Basement.stubs(:default_options).returns(inherited_options)
      end
    end
  end
end
