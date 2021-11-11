# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Context
    extend T::Sig

    @api_key = T.let("", String)
    @api_secret_key = T.let("", String)
    @api_version = T.let("2021-01", String)
    @host_name = T.let("", String)
    @scope = T.let([], T::Array[String])
    @is_embedded = T.let(false, T::Boolean)
    @session_storage = T.let(ShopifyAPI::Auth::FileSessionStorage.new, ShopifyAPI::Auth::SessionStorage)
    @is_private = T.let(false, T::Boolean)
    @is_embedded = T.let(true, T::Boolean)

    class << self
      extend T::Sig

      sig do
        params(
          api_key: String,
          api_secret_key: String,
          api_version: String,
          host_name: String,
          scope: T::Array[String],
          is_private: T::Boolean,
          is_embedded: T::Boolean,
          session_storage: ShopifyAPI::Auth::SessionStorage
        ).void
      end
      def setup(api_key:, api_secret_key:, api_version:,
        host_name:, scope:, is_private:, is_embedded:, session_storage:)
        @api_key = api_key
        @api_secret_key = api_secret_key
        @api_version = api_version
        @host_name = host_name
        @is_private = is_private
        @scope = scope
        @is_embedded = is_embedded
        @session_storage = session_storage
      end

      sig { returns(String) }
      attr_reader :api_key, :api_secret_key, :api_version, :host_name

      sig { returns(T::Array[String]) }
      attr_reader :scope

      sig { returns(ShopifyAPI::Auth::SessionStorage) }
      attr_reader :session_storage

      sig { returns(T::Boolean) }
      def private?
        @is_private
      end

      sig { returns(T::Boolean) }
      def embedded?
        @is_embedded
      end

      sig { returns(T::Boolean) }
      def setup?
        !(api_key.empty? || api_secret_key.empty? || host_name.empty?)
      end
    end
  end
end
