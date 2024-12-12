# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

module ShopifyAPITest
  module Auth
    class AlwaysOnTokenTest < Test::Unit::TestCase
      def setup
        super()

        @shop = "test-shop.myshopify.com"
        @jwt_payload = {
          iss: "https://accounts.google.com",
          aud: @shop,
        }
        @id_token = JWT.encode(@jwt_payload, nil, "none")

        ShopifyAPI::Auth::IdToken::GoogleIdToken.stubs(:request).returns(@id_token)

        @token_exchange_request = {
          client_id: ShopifyAPI::Context.api_key,
          client_secret: ShopifyAPI::Context.api_secret_key,
          grant_type: "urn:ietf:params:oauth:grant-type:token-exchange",
          subject_token_type: "urn:ietf:params:oauth:token-type:id_token",
          subject_token: @id_token,
          requested_token_type: "urn:shopify:params:oauth:token-type:offline-access-token",
        }
        @token_response = {
          access_token: SecureRandom.alphanumeric(10),
          scope: "scope1,scope2",
          session: SecureRandom.alphanumeric(10),
        }
      end

      def test_exchange_token_context_not_setup
        modify_context(api_key: "", api_secret_key: "", host: "")

        assert_raises(ShopifyAPI::Errors::ContextNotSetupError) do
          ShopifyAPI::Auth::AlwaysOnToken.request(shop: @shop)
        end
      end

      def test_exchange_token_unable_to_get_id_token
        ShopifyAPI::Auth::IdToken::GoogleIdToken.stubs(:request).returns(nil)

        assert_raises(ShopifyAPI::Errors::InvalidJwtTokenError) do
          ShopifyAPI::Auth::AlwaysOnToken.request(shop: @shop)
        end
      end

      def test_exchange_token_rejected_id_token
        stub_request(:post, "https://#{@shop}/admin/oauth/access_token")
          .with(body: @token_exchange_request)
          .to_return(
            status: 400,
            body: { error: "invalid_subject_token" }.to_json,
            headers: { content_type: "application/json" },
          )

        assert_raises(ShopifyAPI::Errors::InvalidJwtTokenError) do
          ShopifyAPI::Auth::AlwaysOnToken.request(shop: @shop)
        end
      end

      def test_request_token_succeeds
        stub_request(:post, "https://#{@shop}/admin/oauth/access_token")
          .with(body: @token_exchange_request)
          .to_return(body: @token_response.to_json, headers: { content_type: "application/json" })
        expected_session = ShopifyAPI::Auth::Session.new(
          id: "offline_#{@shop}",
          shop: @shop,
          access_token: @token_response[:access_token],
          scope: @token_response[:scope],
          is_online: false,
          expires: nil,
          shopify_session_id: @token_response[:session],
        )

        session = ShopifyAPI::Auth::AlwaysOnToken.request(shop: @shop)

        assert_equal(expected_session, session)
      end
    end
  end
end
