# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    module RefreshToken
      extend T::Sig

      REFRESH_TOKEN_GRANT_TYPE = "refresh_token"

      class << self
        extend T::Sig

        sig do
          params(
            shop: String,
            refresh_token: String,
          ).returns(ShopifyAPI::Auth::Session)
        end
        def refresh(shop:, refresh_token:)
          unless ShopifyAPI::Context.setup?
            raise ShopifyAPI::Errors::ContextNotSetupError,
              "ShopifyAPI::Context not setup, please call ShopifyAPI::Context.setup"
          end

          shop_session = ShopifyAPI::Auth::Session.new(shop: shop)
          body = {
            client_id: ShopifyAPI::Context.api_key,
            client_secret: ShopifyAPI::Context.api_secret_key,
            grant_type: REFRESH_TOKEN_GRANT_TYPE,
            refresh_token: refresh_token,
          }

          client = Clients::HttpClient.new(session: shop_session, base_path: "/admin/oauth")
          response = begin
            client.request(
              Clients::HttpRequest.new(
                http_method: :post,
                path: "access_token",
                body: body,
                body_type: "application/json",
              ),
            )
          rescue ShopifyAPI::Errors::HttpResponseError => error
            puts "👇" * 50
            puts error: error, code: error.code, response: error.response.inspect
            puts "👆" * 50
            # TODO: errors
            raise
          end

          session_params = T.cast(response.body, T::Hash[String, T.untyped]).to_h

          Session.from(
            shop: shop,
            access_token_response: Oauth::AccessTokenResponse.from_hash(session_params),
          )
        end
      end
    end
  end
end
