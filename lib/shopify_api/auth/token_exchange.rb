# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    module TokenExchange
      extend T::Sig

      TOKEN_EXCHANGE_GRANT_TYPE = "urn:ietf:params:oauth:grant-type:token-exchange"
      ID_TOKEN_TYPE = "urn:ietf:params:oauth:token-type:id_token"

      class RequestedTokenType < T::Enum
        enums do
          ONLINE_ACCESS_TOKEN = new("urn:shopify:params:oauth:token-type:online-access-token")
          OFFLINE_ACCESS_TOKEN = new("urn:shopify:params:oauth:token-type:offline-access-token")
        end
      end

      class << self
        extend T::Sig

        sig do
          params(
            session_token: String,
            requested_token_type: RequestedTokenType,
            shop: T.nilable(String),
          ).returns(ShopifyAPI::Auth::Session)
        end
        def exchange_token(session_token:, requested_token_type:, shop: nil)
          unless ShopifyAPI::Context.setup?
            raise ShopifyAPI::Errors::ContextNotSetupError,
              "ShopifyAPI::Context not setup, please call ShopifyAPI::Context.setup"
          end
          raise ShopifyAPI::Errors::UnsupportedOauthError,
            "Cannot perform OAuth Token Exchange for private apps." if ShopifyAPI::Context.private?
          raise ShopifyAPI::Errors::UnsupportedOauthError,
            "Cannot perform OAuth Token Exchange for non embedded apps." unless ShopifyAPI::Context.embedded?

          # Validate the session token and use the shop from the token's `dest` claim
          jwt_payload = ShopifyAPI::Auth::JwtPayload.new(session_token)
          dest_shop = jwt_payload.shop

          if shop
            ShopifyAPI::Logger.deprecated(
              "The `shop` parameter for `exchange_token` is deprecated and will be removed in v17. " \
                "The shop is now always taken from the session token's `dest` claim.",
              "17.0.0",
            )
          end

          shop_session = ShopifyAPI::Auth::Session.new(shop: dest_shop)
          body = {
            client_id: ShopifyAPI::Context.api_key,
            client_secret: ShopifyAPI::Context.api_secret_key,
            grant_type: TOKEN_EXCHANGE_GRANT_TYPE,
            subject_token: session_token,
            subject_token_type: ID_TOKEN_TYPE,
            requested_token_type: requested_token_type.serialize,
          }

          if requested_token_type == RequestedTokenType::OFFLINE_ACCESS_TOKEN
            body.merge!({ expiring: ShopifyAPI::Context.expiring_offline_access_tokens ? 1 : 0 })
          end

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
            if error.code == 400 &&
                ["invalid_subject_token", "invalid_identity_session"].include?(error.response.body["error"])
              raise ShopifyAPI::Errors::InvalidJwtTokenError, "Session token was rejected by token exchange"
            end

            raise error
          end

          session_params = T.cast(response.body, T::Hash[String, T.untyped]).to_h

          Session.from(
            shop: dest_shop,
            access_token_response: Oauth::AccessTokenResponse.from_hash(session_params),
          )
        end

        sig do
          params(
            shop: String,
            non_expiring_offline_token: String,
          ).returns(ShopifyAPI::Auth::Session)
        end
        def migrate_to_expiring_token(shop:, non_expiring_offline_token:)
          unless ShopifyAPI::Context.setup?
            raise ShopifyAPI::Errors::ContextNotSetupError,
              "ShopifyAPI::Context not setup, please call ShopifyAPI::Context.setup"
          end

          validated_shop = Utils::ShopValidator.sanitize!(shop)
          shop_session = ShopifyAPI::Auth::Session.new(shop: validated_shop)
          body = {
            client_id: ShopifyAPI::Context.api_key,
            client_secret: ShopifyAPI::Context.api_secret_key,
            grant_type: TOKEN_EXCHANGE_GRANT_TYPE,
            subject_token: non_expiring_offline_token,
            subject_token_type: RequestedTokenType::OFFLINE_ACCESS_TOKEN.serialize,
            requested_token_type: RequestedTokenType::OFFLINE_ACCESS_TOKEN.serialize,
            expiring: "1",
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
            ShopifyAPI::Context.logger.debug("Failed to migrate to expiring offline token: #{error.message}")
            raise error
          end

          session_params = T.cast(response.body, T::Hash[String, T.untyped]).to_h

          Session.from(
            shop: validated_shop,
            access_token_response: Oauth::AccessTokenResponse.from_hash(session_params),
          )
        end
      end
    end
  end
end
