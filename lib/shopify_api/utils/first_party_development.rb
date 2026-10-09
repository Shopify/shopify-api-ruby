# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Utils
    module FirstPartyDevelopment
      SHOP_DEV_DOMAIN = T.let(/\A[a-z0-9-]+\.my\.shop\.dev\z/i, Regexp)
      DEVNS_SHOP_DOMAIN = T.let(/\A[a-z0-9-]+\.my\.shop\.devns\.shop\z/i, Regexp)

      class << self
        extend T::Sig

        sig { returns(T.untyped) }
        def core
          return unless defined?(DevServer)

          dev_server = T.unsafe(Object.const_get("DevServer")) # rubocop:disable Sorbet/ConstantsFromStrings
          return dev_server.core if dev_server.respond_to?(:core)

          # Older dev_server versions only expose DevServer::Core.
          return unless Object.const_defined?("DevServer::Core")

          T.unsafe(Object.const_get("DevServer::Core")).new # rubocop:disable Sorbet/ConstantsFromStrings
        end

        sig { params(host: T.nilable(String)).returns(T::Boolean) }
        def shop_domain?(host)
          return false unless host && defined?(DevServer)
          # shop.dev hosts have always worked whenever DevServer is loaded. The
          # new development hosts are only accepted when running under `dev`.
          return SHOP_DEV_DOMAIN.match?(host) unless ENV.key?("USING_DEV")

          dev_core = core
          return dev_core.shop_domain?(host) if dev_core.respond_to?(:shop_domain?)

          # Older dev_server versions do not have the shared shop helpers.
          SHOP_DEV_DOMAIN.match?(host) || DEVNS_SHOP_DOMAIN.match?(host)
        end
      end
    end
  end
end
