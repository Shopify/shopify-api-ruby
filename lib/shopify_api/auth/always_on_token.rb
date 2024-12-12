# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    module AlwaysOnToken
      class << self
        extend T::Sig

        sig { params(shop: String).returns(ShopifyAPI::Auth::Session) }
        def request(shop:)
          unless ShopifyAPI::Context.setup?
            raise ShopifyAPI::Errors::ContextNotSetupError,
              "ShopifyAPI::Context not setup, please call ShopifyAPI::Context.setup"
          end

          id_token = ShopifyAPI::Auth::IdToken::GoogleIdToken.request(shop: shop)
          unless id_token
            raise ShopifyAPI::Errors::InvalidJwtTokenError, "Failed to get Google ID token"
          end

          ShopifyAPI::Auth::TokenExchange.call_token_exchange_endpoint(
            shop: shop,
            id_token: id_token,
            requested_token_type: ShopifyAPI::Auth::TokenExchange::RequestedTokenType::OFFLINE_ACCESS_TOKEN,
          )
        end
      end
    end
  end
end
