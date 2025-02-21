# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    module ClientCredentials
      extend T::Sig

      CLIENT_CREDENTIALS_GRANT_TYPE = "client_credentials"

      class << self
        extend T::Sig

        sig do
          params(
            shop: String,
          ).returns(ShopifyAPI::Auth::Session)
        end
        def client_credentials(shop:)
          unless ShopifyAPI::Context.setup?
            raise ShopifyAPI::Errors::ContextNotSetupError,
              "ShopifyAPI::Context not setup, please call ShopifyAPI::Context.setup"
          end

          shop_session = ShopifyAPI::Auth::Session.new(shop: shop)
          body = {
            client_id: ShopifyAPI::Context.api_key,
            client_secret: ShopifyAPI::Context.api_secret_key,
            grant_type: CLIENT_CREDENTIALS_GRANT_TYPE,
          }

          client = Clients::HttpClient.new(session: shop_session, base_path: "/admin/oauth")
          response =
            client.request(
              Clients::HttpRequest.new(
                http_method: :post,
                path: "access_token",
                body: body,
                body_type: "application/json",
              ),
            )
          response_hash = T.cast(response.body, T::Hash[String, T.untyped]).to_h

          Session.from(
            shop: shop,
            access_token_response: Oauth::AccessTokenResponse.from_hash(response_hash),
          )
        end
      end
    end
  end
end
