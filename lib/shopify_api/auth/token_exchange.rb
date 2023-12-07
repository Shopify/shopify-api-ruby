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
            shop: String,
            session_token: String,
            requested_token_type: RequestedTokenType,
          ).returns(ShopifyAPI::Auth::Session)
        end
        def exchange_token(shop:, session_token:, requested_token_type:)
          unless ShopifyAPI::Context.setup?
            raise ShopifyAPI::Errors::ContextNotSetupError,
              "ShopifyAPI::Context not setup, please call ShopifyAPI::Context.setup"
          end
          raise ShopifyAPI::Errors::UnsupportedOauthError,
            "Cannot perform OAuth Token Exchange for private apps." if ShopifyAPI::Context.private?
          raise ShopifyAPI::Errors::UnsupportedOauthError,
            "Cannot perform OAuth Token Exchange for non embedded apps." unless ShopifyAPI::Context.embedded?

          # Validate the session token content
          ShopifyAPI::Auth::JwtPayload.new(session_token)

          shop_session = ShopifyAPI::Auth::Session.new(shop: shop)
          body = {
            client_id: ShopifyAPI::Context.api_key,
            client_secret: ShopifyAPI::Context.api_secret_key,
            grant_type: TOKEN_EXCHANGE_GRANT_TYPE,
            subject_token: session_token,
            subject_token_type: ID_TOKEN_TYPE,
            requested_token_type: requested_token_type.serialize,
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
            if error.code == 400 && error.response.body["error"] == "invalid_subject_token"
              raise ShopifyAPI::Errors::InvalidJwtTokenError, "Session token was rejected by token exchange"
            end

            raise error
          end

          session_params = T.cast(response.body, T::Hash[String, T.untyped]).to_h
          session = create_new_session(session_params, shop)

          session
        end

        private

        sig { params(session_params: T::Hash[String, T.untyped], shop: String).returns(Session) }
        def create_new_session(session_params, shop)
          session_params = session_params.to_h { |k, v| [k.to_sym, v] }

          scope = session_params[:scope]

          is_online = !session_params[:associated_user].nil?

          if is_online
            associated_user = AssociatedUser.new(session_params[:associated_user].to_h { |k, v| [k.to_sym, v] })
            expires = Time.now + session_params[:expires_in].to_i
            associated_user_scope = session_params[:associated_user_scope]
            id = "#{shop}_#{associated_user.id}"
          else
            id = "offline_#{shop}"
          end

          Session.new(
            id: id,
            shop: shop,
            access_token: session_params[:access_token],
            scope: scope,
            is_online: is_online,
            associated_user_scope: associated_user_scope,
            associated_user: associated_user,
            expires: expires,
            shopify_session_id: session_params[:session],
          )
        end
      end
    end
  end
end
