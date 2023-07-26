# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Auth
    extend T::Sig

    class << self
      extend T::Sig

      sig do
        params(
          host: T.nilable(String),
          config: T.any(ShopifyAPI::Config, T.class_of(ShopifyAPI::Context)),
        ).returns(String)
      end
      def embedded_app_url(host, config = ShopifyAPI::Context)
        unless config.setup?
          raise Errors::ContextNotSetupError,
            "Config not setup, please pass a valid ShopifyAPI::Config instance or call ShopifyAPI::Context.setup"
        end

        unless host
          raise Errors::MissingRequiredArgumentError, "host argument is required"
        end

        decoded_host = Base64.decode64(host)
        "https://#{decoded_host}/apps/#{config.api_key}"
      end
    end
  end
end
