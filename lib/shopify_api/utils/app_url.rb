# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Utils
    module AppUrl
      extend T::Sig

      class << self
        extend T::Sig

        sig { params(host: T.nilable(String)).returns(String) }
        def get_embedded(host)
          unless Context.setup?
            raise Errors::ContextNotSetupError, "ShopifyAPI::Context not setup, please call ShopifyAPI::Context.setup"
          end

          unless host
            raise Errors::MissingRequiredArgumentError, "host argument is required"
          end

          decoded_host = Base64.strict_decode64(host)
          "https://#{decoded_host}/apps/#{Context.api_key}"
        end
      end
    end
  end
end
