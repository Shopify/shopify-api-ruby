# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

module ShopifyAPITest
  module Auth
    class TokenExchangeTest < Test::Unit::TestCase
      def setup
        super()

        @stubbed_time_now = Time.now
        @shop = "test-shop.myshopify.com"
        @jwt_payload = {
          iss: "https://#{@shop}/admin",
          dest: "https://#{@shop}",
          aud: ShopifyAPI::Context.api_key,
          sub: "1",
          exp: (Time.now + 10).to_i,
          nbf: 1234,
          iat: 1234,
          jti: "4321",
          sid: "abc123",
        }
        @session_token = JWT.encode(@jwt_payload, ShopifyAPI::Context.api_secret_key, "HS256")
        @token_exchange_request = {
          client_id: ShopifyAPI::Context.api_key,
          client_secret: ShopifyAPI::Context.api_secret_key,
          grant_type: "urn:ietf:params:oauth:grant-type:token-exchange",
          subject_token_type: "urn:ietf:params:oauth:token-type:id_token",
          subject_token: @session_token,
          requested_token_type: "urn:shopify:params:oauth:token-type:offline-access-token",
        }
        @offline_token_response = {
          access_token: SecureRandom.alphanumeric(10),
          scope: "scope1,scope2",
          session: SecureRandom.alphanumeric(10),
        }
        @online_token_response = {
          access_token: SecureRandom.alphanumeric(10),
          scope: "scope1,scope2",
          expires_in: 1000,
          associated_user_scope: "scope1",
          associated_user: {
            id: 902541635,
            first_name: "first",
            last_name: "last",
            email: "firstlast@example.com",
            email_verified: true,
            account_owner: true,
            locale: "en",
            collaborator: false,
          },
          session: SecureRandom.alphanumeric(10),
        }

        @expected_associated_user = ShopifyAPI::Auth::AssociatedUser.new(
          id: @online_token_response[:associated_user][:id],
          first_name: @online_token_response[:associated_user][:first_name],
          last_name: @online_token_response[:associated_user][:last_name],
          email: @online_token_response[:associated_user][:email],
          email_verified: @online_token_response[:associated_user][:email_verified],
          account_owner: @online_token_response[:associated_user][:account_owner],
          locale: @online_token_response[:associated_user][:locale],
          collaborator: @online_token_response[:associated_user][:collaborator],
        )
      end

      def test_exchange_token_context_not_setup
        modify_context(api_key: "", api_secret_key: "", host: "")

        assert_raises(ShopifyAPI::Errors::ContextNotSetupError) do
          ShopifyAPI::Auth::TokenExchange.exchange_token(
            shop: @shop,
            session_token: @session_token,
            requested_token_type: ShopifyAPI::Auth::TokenExchange::RequestedTokenType::OFFLINE_ACCESS_TOKEN,
          )
        end
      end

      def test_exchange_token_private_app
        modify_context(is_private: true)

        assert_raises(ShopifyAPI::Errors::UnsupportedOauthError) do
          ShopifyAPI::Auth::TokenExchange.exchange_token(
            shop: @shop,
            session_token: @session_token,
            requested_token_type: ShopifyAPI::Auth::TokenExchange::RequestedTokenType::OFFLINE_ACCESS_TOKEN,
          )
        end
      end

      def test_exchange_token_not_embedded_app
        modify_context(is_embedded: false)

        assert_raises(ShopifyAPI::Errors::UnsupportedOauthError) do
          ShopifyAPI::Auth::TokenExchange.exchange_token(
            shop: @shop,
            session_token: @session_token,
            requested_token_type: ShopifyAPI::Auth::TokenExchange::RequestedTokenType::OFFLINE_ACCESS_TOKEN,
          )
        end
      end

      def test_exchange_token_invalid_session_token
        modify_context(is_embedded: true)

        assert_raises(ShopifyAPI::Errors::InvalidJwtTokenError) do
          ShopifyAPI::Auth::TokenExchange.exchange_token(
            shop: @shop,
            session_token: "invalid",
            requested_token_type: ShopifyAPI::Auth::TokenExchange::RequestedTokenType::OFFLINE_ACCESS_TOKEN,
          )
        end
      end

      def test_exchange_token_rejected_session_token
        modify_context(is_embedded: true)
        stub_request(:post, "https://#{@shop}/admin/oauth/access_token")
          .with(body: @token_exchange_request)
          .to_return(
            status: 400,
            body: { error: "invalid_subject_token" }.to_json,
            headers: { content_type: "application/json" },
          )

        assert_raises(ShopifyAPI::Errors::InvalidJwtTokenError) do
          ShopifyAPI::Auth::TokenExchange.exchange_token(
            shop: @shop,
            session_token: @session_token,
            requested_token_type: ShopifyAPI::Auth::TokenExchange::RequestedTokenType::OFFLINE_ACCESS_TOKEN,
          )
        end
      end

      def test_exchange_token_offline_token
        modify_context(is_embedded: true)
        stub_request(:post, "https://#{@shop}/admin/oauth/access_token")
          .with(body: @token_exchange_request)
          .to_return(body: @offline_token_response.to_json, headers: { content_type: "application/json" })
        expected_session = ShopifyAPI::Auth::Session.new(
          id: "offline_#{@shop}",
          shop: @shop,
          access_token: @offline_token_response[:access_token],
          scope: @offline_token_response[:scope],
          is_online: false,
          expires: nil,
          shopify_session_id: @offline_token_response[:session],
        )

        session = ShopifyAPI::Auth::TokenExchange.exchange_token(
          shop: @shop,
          session_token: @session_token,
          requested_token_type: ShopifyAPI::Auth::TokenExchange::RequestedTokenType::OFFLINE_ACCESS_TOKEN,
        )

        assert_equal(expected_session, session)
      end

      def test_exchange_token_online_token
        modify_context(is_embedded: true)
        stub_request(:post, "https://#{@shop}/admin/oauth/access_token")
          .with(body: @token_exchange_request.dup.tap do |h|
                        h[:requested_token_type] = "urn:shopify:params:oauth:token-type:online-access-token"
                      end)
          .to_return(body: @online_token_response.to_json, headers: { content_type: "application/json" })
        expected_session = ShopifyAPI::Auth::Session.new(
          id: "#{@shop}_#{@online_token_response[:associated_user][:id]}",
          shop: @shop,
          access_token: @online_token_response[:access_token],
          scope: @online_token_response[:scope],
          associated_user_scope: @online_token_response[:associated_user_scope],
          expires: @stubbed_time_now + @online_token_response[:expires_in].to_i,
          associated_user: @expected_associated_user,
          shopify_session_id: @online_token_response[:session],
        )

        session = Time.stub(:now, @stubbed_time_now) do
          ShopifyAPI::Auth::TokenExchange.exchange_token(
            shop: @shop,
            session_token: @session_token,
            requested_token_type: ShopifyAPI::Auth::TokenExchange::RequestedTokenType::ONLINE_ACCESS_TOKEN,
          )
        end

        assert_equal(expected_session, session)
      end
    end
  end
end
