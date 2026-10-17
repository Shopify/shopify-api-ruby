# typed: strict
# frozen_string_literal: true

require "addressable/uri"

module ShopifyAPI
  module Auth
    extend T::Sig

    # Hostname characters, plus an optional port. Anything else before the first "/" is rejected.
    EMBEDDED_HOST_AUTHORITY_REGEX = T.let(/\A[a-zA-Z0-9._-]+(:\d{1,5})?\z/, Regexp)

    # Printable ASCII only: no whitespace, control bytes or non-ASCII bytes.
    EMBEDDED_HOST_ALLOWED_BYTES_REGEX = T.let(/\A[\x21-\x7e]+\z/n, Regexp)
    private_constant :EMBEDDED_HOST_AUTHORITY_REGEX, :EMBEDDED_HOST_ALLOWED_BYTES_REGEX

    class << self
      extend T::Sig

      sig { params(host: T.nilable(String)).returns(String) }
      def embedded_app_url(host)
        unless Context.setup?
          raise Errors::ContextNotSetupError, "ShopifyAPI::Context not setup, please call ShopifyAPI::Context.setup"
        end

        unless host
          raise Errors::MissingRequiredArgumentError, "host argument is required"
        end

        decoded_host = Base64.decode64(host)
        unless trusted_embedded_host?(decoded_host)
          raise Errors::InvalidShopError, "host must decode to a trusted Shopify Admin host"
        end

        "https://#{decoded_host}/apps/#{Context.api_key}"
      end

      private

      sig { params(decoded_host: String).returns(T::Boolean) }
      def trusted_embedded_host?(decoded_host)
        return false unless decoded_host.b.match?(EMBEDDED_HOST_ALLOWED_BYTES_REGEX)

        authority = T.must(decoded_host.split("/", 2).first)
        return false unless authority.match?(EMBEDDED_HOST_AUTHORITY_REGEX)

        uri = Addressable::URI.parse("https://#{decoded_host}")
        return false unless uri.userinfo.nil? && uri.authority == authority

        !Utils::ShopValidator.sanitize_shop_domain(uri.to_s).nil?
      rescue Addressable::URI::InvalidURIError
        false
      end
    end
  end
end
