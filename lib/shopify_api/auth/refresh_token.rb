# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    module RefreshToken
      extend T::Sig

      class << self
        extend T::Sig

        sig do
          params(
            shop: String,
            refresh_token: String,
          ).returns(ShopifyAPI::Auth::Session)
        end
        def refresh_access_token(shop:, refresh_token:)
          unless ShopifyAPI::Context.setup?
            raise ShopifyAPI::Errors::ContextNotSetupError,
              "ShopifyAPI::Context not setup, please call ShopifyAPI::Context.setup"
          end

          shop_session = ShopifyAPI::Auth::Session.new(shop:)
          body = {
            client_id: ShopifyAPI::Context.api_key,
            client_secret: ShopifyAPI::Context.api_secret_key,
            grant_type: "refresh_token",
            refresh_token:,
          }

          client = Clients::HttpClient.new(session: shop_session, base_path: "/admin/oauth")
          response = begin
            client.request(
              Clients::HttpRequest.new(
                http_method: :post,
                path: "access_token",
                body:,
                body_type: "application/json",
              ),
            )
          rescue ShopifyAPI::Errors::HttpResponseError => error
            ShopifyAPI::Context.logger.debug("Failed to refresh access token: #{error.message}")
            raise error
          end

          session_params = T.cast(response.body, T::Hash[String, T.untyped]).to_h

          Session.from(
            shop:,
            access_token_response: Oauth::AccessTokenResponse.from_hash(session_params),
          )
        end
      end
    end
  end
end
