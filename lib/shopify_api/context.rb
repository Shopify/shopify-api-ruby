# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Context
    extend T::Sig

    @api_key = T.let("", String)
    @api_secret_key = T.let("", String)
    @host_name = T.let("", String)
    @scope = T.let([], T::Array[String])
    @session_storage = T.let(ShopifyAPI::Auth::FileSessionStorage.new, ShopifyAPI::Auth::SessionStorage)

    class << self
      extend T::Sig

      sig do
        params(
          api_key: String,
          api_secret_key: String,
          host_name: String,
          scope: T::Array[String],
          session_storage: ShopifyAPI::Auth::SessionStorage
        ).void
      end
      def setup(api_key:, api_secret_key:, host_name:, scope:, session_storage:)
        @api_key = api_key
        @api_secret_key = api_secret_key
        @host_name = host_name
        @session_storage = session_storage
        @scope = scope
      end

      sig { returns(String) }
      attr_reader :api_key, :api_secret_key, :host_name

      sig { returns(T::Array[String]) }
      attr_reader :scope

      sig { returns(ShopifyAPI::Auth::SessionStorage) }
      attr_reader :session_storage
    end
  end
end
