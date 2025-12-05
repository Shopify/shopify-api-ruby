# typed: false
# frozen_string_literal: true

require_relative "../test_helper"

module ShopifyAPITest
  module Auth
    class RefreshTokenTest < Test::Unit::TestCase
      def setup
        super()

        @stubbed_time_now = Time.now
        @shop = "test-shop.myshopify.com"
        @refresh_token = "refresh_token_#{SecureRandom.alphanumeric(10)}"

        @refresh_token_request = {
          client_id: ShopifyAPI::Context.api_key,
          client_secret: ShopifyAPI::Context.api_secret_key,
          grant_type: "refresh_token",
          refresh_token: @refresh_token,
        }

        @refresh_token_response = {
          access_token: "access_token_#{SecureRandom.alphanumeric(10)}",
          expires_in: 1000,
          refresh_token: "refresh_token_#{SecureRandom.alphanumeric(10)}",
          refresh_token_expires_in: 3000,
          scope: "write_products,read_orders",
        }
      end

      def test_refresh_access_token_success
        stub_request(:post, "https://#{@shop}/admin/oauth/access_token")
          .with(body: @refresh_token_request)
          .to_return(
            body: @refresh_token_response.to_json,
            headers: { "Content-Type" => "application/json" },
          )

        expected_session = ShopifyAPI::Auth::Session.new(
          id: "offline_#{@shop}",
          shop: @shop,
          access_token: @refresh_token_response[:access_token],
          scope: @refresh_token_response[:scope],
          is_online: false,
          expires: @stubbed_time_now + @refresh_token_response[:expires_in].to_i,
          refresh_token: @refresh_token_response[:refresh_token],
          refresh_token_expires: @stubbed_time_now + @refresh_token_response[:refresh_token_expires_in].to_i,
        )

        session = Time.stub(:now, @stubbed_time_now) do
          ShopifyAPI::Auth::RefreshToken.refresh_access_token(
            shop: @shop,
            refresh_token: @refresh_token,
          )
        end

        assert_equal(expected_session, session)
      end

      def test_refresh_access_token_context_not_setup
        modify_context(api_key: "", api_secret_key: "", host: "")

        assert_raises(ShopifyAPI::Errors::ContextNotSetupError) do
          ShopifyAPI::Auth::RefreshToken.refresh_access_token(
            shop: @shop,
            refresh_token: @refresh_token,
          )
        end
      end

      def test_refresh_access_token_unauthorized
        stub_request(:post, "https://#{@shop}/admin/oauth/access_token")
          .with(body: @refresh_token_request)
          .to_return(
            status: 401,
            body: { error: "unauthorized" }.to_json,
            headers: { "Content-Type" => "application/json" },
          )

        ShopifyAPI::Context.logger.expects(:debug).with(regexp_matches(/Failed to refresh access token/))

        assert_raises(ShopifyAPI::Errors::HttpResponseError) do
          ShopifyAPI::Auth::RefreshToken.refresh_access_token(
            shop: @shop,
            refresh_token: @refresh_token,
          )
        end
      end
    end
  end
end
