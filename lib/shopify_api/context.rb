# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Context
    extend T::Sig

    @api_key = T.let(nil, T.nilable(String))
    @api_secret_key = T.let(nil, T.nilable(String))
    @host_name = T.let(nil, T.nilable(String))
    @session_storage = T.let(nil, T.nilable(ShopifyAPI::Auth::SessionStorage))

    class << self
      extend T::Sig

      sig do
        params(
          api_key: String,
          api_secret_key: String,
          host_name: T.nilable(String),
          session_storage: T.nilable(ShopifyAPI::Auth::SessionStorage)
        ).void
      end
      def setup(api_key:, api_secret_key:, host_name: nil, session_storage: nil)
        @api_key = api_key
        @api_secret_key = api_secret_key
        @host_name = host_name
        @session_storage = session_storage
      end

      sig { returns(T.any(T.nilable(String), ShopifyAPI::Auth::SessionStorage)) }
      attr_reader :api_key, :api_secret_key, :host_name, :session_storage
    end
  end
end
