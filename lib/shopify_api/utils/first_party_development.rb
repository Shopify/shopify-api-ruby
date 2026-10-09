# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Utils
    module FirstPartyDevelopment
      class << self
        extend T::Sig

        sig { returns(T.untyped) }
        def core
          return unless ENV.key?("USING_DEV") && defined?(DevServer)

          T.unsafe(Object.const_get("DevServer")).core # rubocop:disable Sorbet/ConstantsFromStrings
        end

        sig { params(host: T.nilable(String)).returns(T::Boolean) }
        def shop_domain?(host)
          return false unless host && (dev_core = core)
          return dev_core.shop_domain?(host) if dev_core.respond_to?(:shop_domain?)

          # Older dev_server versions do not have the shared shop helpers.
          /\A[a-z0-9-]+\.my\.shop\.dev(?:ns\.shop)?\z/i.match?(host)
        end
      end
    end
  end
end
