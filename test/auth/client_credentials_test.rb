# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

module ShopifyAPITest
  module Auth
    class ClientCredentialsTest < Test::Unit::TestCase
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
      end

      def test_client_credentials_context_not_setup
        modify_context(api_key: "", api_secret_key: "", host: "")

        assert_raises(ShopifyAPI::Errors::ContextNotSetupError) do
          ShopifyAPI::Auth::ClientCredentials.client_credentials(shop: @shop)
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
    end
  end
end
