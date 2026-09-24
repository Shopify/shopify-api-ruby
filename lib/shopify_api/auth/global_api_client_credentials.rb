# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    module GlobalApiClientCredentials
      extend T::Sig

      CLIENT_CREDENTIALS_GRANT_TYPE = "client_credentials"
      ACCESS_TOKEN_PATH = "auth/access_token"
      # Used only when the token is not a decodable JWT and the body has no `expires_in`.
      FALLBACK_TTL_SECONDS = 300
      # Bound time spent waiting for the token endpoint.
      TOKEN_REQUEST_TIMEOUT_SECONDS = 10

      class << self
        extend T::Sig

        sig { returns(GlobalApiToken) }
        def global_api_client_credentials
          unless ShopifyAPI::Context.setup?
            raise ShopifyAPI::Errors::ContextNotSetupError,
              "ShopifyAPI::Context not setup, please call ShopifyAPI::Context.setup"
          end

          mint_token
        end

        private

        sig { returns(GlobalApiToken) }
        def mint_token
          client = Clients::GlobalApiClient.new(base_path: "")
          response = client.request(
            Clients::HttpRequest.new(
              http_method: :post,
              path: ACCESS_TOKEN_PATH,
              body: {
                client_id: ShopifyAPI::Context.api_key,
                client_secret: ShopifyAPI::Context.api_secret_key,
                grant_type: CLIENT_CREDENTIALS_GRANT_TYPE,
              },
              body_type: "application/json",
              timeout: TOKEN_REQUEST_TIMEOUT_SECONDS,
            ),
          )
          body = T.cast(response.body, T::Hash[String, T.untyped])

          access_token = body["access_token"]
          unless access_token.is_a?(String) && !access_token.empty?
            raise ShopifyAPI::Errors::RequestAccessTokenError,
              "Global API token response did not include an access_token"
          end
          claims = decode_claims(access_token)

          GlobalApiToken.new(
            access_token: access_token,
            expires_at: expires_at_from(claims, body),
          )
        end

        sig { params(access_token: String).returns(T.nilable(T::Hash[String, T.untyped])) }
        def decode_claims(access_token)
          payload, _header = JWT.decode(access_token, nil, false)
          payload.is_a?(Hash) ? payload : nil
        rescue JWT::DecodeError
          nil
        end

        sig do
          params(
            claims: T.nilable(T::Hash[String, T.untyped]),
            body: T::Hash[String, T.untyped],
          ).returns(Time)
        end
        def expires_at_from(claims, body)
          expires_in = body["expires_in"]
          return Time.now.utc + expires_in if expires_in.is_a?(Numeric) && expires_in.to_f.finite?

          exp = claims && claims["exp"]
          return Time.at(exp).utc if exp.is_a?(Numeric) && exp.to_f.finite?

          Time.now.utc + FALLBACK_TTL_SECONDS
        end
      end
    end
  end
end
