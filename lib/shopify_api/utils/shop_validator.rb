# typed: strict
# frozen_string_literal: true

require "addressable/uri"

module ShopifyAPI
  module Utils
    module ShopValidator
      TRUSTED_SHOPIFY_DOMAINS = T.let(
        [
          "shopify.com",
          "myshopify.io",
          "myshopify.com",
          "spin.dev",
          "shop.dev",
        ].freeze,
        T::Array[String],
      )

      HOSTNAME_REGEX = T.let(/\A[a-z0-9_-]+(\.[a-z0-9_-]+)*\.?\z/, Regexp)
      STORE_HANDLE_REGEX = T.let(/\A[a-z0-9][a-z0-9-]*\z/, Regexp)
      private_constant :HOSTNAME_REGEX, :STORE_HANDLE_REGEX

      class << self
        extend T::Sig

        sig do
          params(
            shop_domain: String,
            myshopify_domain: T.nilable(String),
          ).returns(T.nilable(String))
        end
        def sanitize_shop_domain(shop_domain, myshopify_domain: nil)
          uri = uri_from_shop_domain(shop_domain, myshopify_domain)
          return nil if uri.nil? || uri.host.nil? || uri.host.empty?
          return nil unless T.cast(uri.host, String).match?(HOSTNAME_REGEX)

          trusted_domains(myshopify_domain).each do |trusted_domain|
            host = T.cast(uri.host, String)
            uri_domain = uri.domain
            next if uri_domain.nil?

            no_shop_name_in_subdomain = host == trusted_domain
            from_trusted_domain = trusted_domain == uri_domain

            if unified_admin?(uri) && from_trusted_domain
              return myshopify_domain_from_unified_admin(uri)
            end
            return nil if no_shop_name_in_subdomain || host.empty?
            return host if from_trusted_domain
          end
          nil
        end

        sig do
          params(
            shop: String,
            myshopify_domain: T.nilable(String),
          ).returns(String)
        end
        def sanitize!(shop, myshopify_domain: nil)
          host = sanitize_shop_domain(shop, myshopify_domain: myshopify_domain)
          if host.nil? || host.empty?
            raise Errors::InvalidShopError,
              "shop must be a trusted Shopify domain (see ShopValidator::TRUSTED_SHOPIFY_DOMAINS), got: #{shop.inspect}"
          end

          host
        end

        private

        sig { params(myshopify_domain: T.nilable(String)).returns(T::Array[String]) }
        def trusted_domains(myshopify_domain)
          trusted = TRUSTED_SHOPIFY_DOMAINS.dup
          if myshopify_domain && !myshopify_domain.to_s.empty?
            trusted << myshopify_domain
            trusted.uniq!
          end
          trusted
        end

        sig do
          params(
            shop_domain: String,
            myshopify_domain: T.nilable(String),
          ).returns(T.nilable(Addressable::URI))
        end
        def uri_from_shop_domain(shop_domain, myshopify_domain)
          name = shop_domain.to_s.downcase.strip
          return nil if name.empty?
          return nil if name.include?("@")

          if myshopify_domain && !myshopify_domain.to_s.empty? &&
              !name.include?(myshopify_domain.to_s) && !name.include?(".")
            name += ".#{myshopify_domain}"
          end

          uri = Addressable::URI.parse(name)
          if uri.scheme.nil?
            name = "https://#{name}"
            uri = Addressable::URI.parse(name)
          end

          uri
        rescue Addressable::URI::InvalidURIError
          nil
        end

        sig { params(uri: Addressable::URI).returns(T::Boolean) }
        def unified_admin?(uri)
          T.cast(uri.host, String).split(".").first == "admin"
        end

        sig { params(uri: Addressable::URI).returns(T.nilable(String)) }
        def myshopify_domain_from_unified_admin(uri)
          segments = uri.path.to_s.split("/")
          store_index = segments.index("store")
          shop = store_index && segments[store_index + 1]
          return unless shop&.match?(STORE_HANDLE_REGEX)

          "#{shop}.myshopify.com"
        end
      end
    end
  end
end
