# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    module ClientCredentials
      extend T::Sig

      CLIENT_CREDENTIALS_GRANT_TYPE = "client_credentials"
      CLIENT_ASSERTION_TYPE = "urn:ietf:params:oauth:client-assertion-type:jwt-bearer"
      TOKEN_ENDPOINT_BASE_PATH = "/admin/oauth"
      TOKEN_ENDPOINT_PATH = "access_token"

      class << self
        extend T::Sig

        # The URL this grant posts to. `ClientAssertion.create` derives the assertion's `aud` claim from
        # here rather than spelling the URL out again: Shopify rejects an assertion whose `aud` is not the
        # endpoint the request arrives at, and reports it as an indistinguishable `invalid_client`.
        sig { params(shop: String).returns(String) }
        def token_endpoint_url(shop)
          "https://#{shop}#{TOKEN_ENDPOINT_BASE_PATH}/#{TOKEN_ENDPOINT_PATH}"
        end

        # `client_assertion` is typed `T.untyped` so that a wrong type reaches the validation below:
        # sorbet-runtime's TypeError message embeds the offending argument, and a JWT is short enough that
        # the truncated message shows a usable part of a live credential.
        sig do
          params(
            shop: String,
            client_assertion: T.untyped,
          ).returns(ShopifyAPI::Auth::Session)
        end
        def client_credentials(shop:, client_assertion: nil)
          unless ShopifyAPI::Context.setup?
            raise ShopifyAPI::Errors::ContextNotSetupError,
              "ShopifyAPI::Context not setup, please call ShopifyAPI::Context.setup"
          end

          validated_shop = Utils::ShopValidator.sanitize!(shop)
          shop_session = ShopifyAPI::Auth::Session.new(shop: validated_shop)
          body = if client_assertion.nil?
            {
              client_id: ShopifyAPI::Context.api_key,
              client_secret: ShopifyAPI::Context.api_secret_key,
              grant_type: CLIENT_CREDENTIALS_GRANT_TYPE,
            }
          else
            {
              client_id: ShopifyAPI::Context.api_key,
              grant_type: CLIENT_CREDENTIALS_GRANT_TYPE,
              client_assertion_type: CLIENT_ASSERTION_TYPE,
              client_assertion: validated_assertion(client_assertion),
            }
          end

          client = Clients::HttpClient.new(session: shop_session, base_path: TOKEN_ENDPOINT_BASE_PATH)
          response =
            client.request(
              Clients::HttpRequest.new(
                http_method: :post,
                path: TOKEN_ENDPOINT_PATH,
                body: body,
                body_type: "application/json",
                tries: 1,
                follow_redirects: false,
                suppress_inherited_http_auth: !client_assertion.nil?,
              ),
            )
          response_hash = T.cast(response.body, T::Hash[String, T.untyped]).to_h

          Session.from(
            shop: validated_shop,
            access_token_response: Oauth::AccessTokenResponse.from_hash(response_hash),
          )
        end

        private

        sig { params(client_assertion: Object).returns(String) }
        def validated_assertion(client_assertion)
          unless client_assertion.is_a?(String)
            raise ShopifyAPI::Errors::InvalidClientAssertionError,
              "client_assertion must be a String, got: #{client_assertion.class}"
          end
          if client_assertion.strip.empty?
            raise ShopifyAPI::Errors::InvalidClientAssertionError, "client_assertion must not be blank"
          end

          # Rejected rather than trimmed: a JWT that arrived with whitespace around it means the caller's
          # plumbing is wrong, and the server compares the assertion byte for byte.
          unless client_assertion == client_assertion.strip
            raise ShopifyAPI::Errors::InvalidClientAssertionError,
              "client_assertion must not have leading or trailing whitespace"
          end

          client_assertion
        end
      end
    end
  end
end
