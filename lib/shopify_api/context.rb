# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Context
    extend T::Sig

    @api_key = T.let("", String)
    @api_secret_key = T.let("", String)
    @api_version = T.let("2021-01", String)
    @host_name = T.let("", String)
    @scope = T.let(Auth::AuthScopes.new, Auth::AuthScopes)
    @is_embedded = T.let(false, T::Boolean)
    @session_storage = T.let(ShopifyAPI::Auth::FileSessionStorage.new, ShopifyAPI::Auth::SessionStorage)
    @is_private = T.let(false, T::Boolean)
    @is_embedded = T.let(true, T::Boolean)
    @logger = T.let(Logger.new(STDOUT), Logger)

    class << self
      extend T::Sig

      sig do
        params(
          api_key: String,
          api_secret_key: String,
          api_version: String,
          host_name: String,
          scope: T.any(T::Array[String], String),
          is_private: T::Boolean,
          is_embedded: T::Boolean,
          session_storage: ShopifyAPI::Auth::SessionStorage,
          logger: Logger
        ).void
      end
      def setup(api_key:, api_secret_key:, api_version:,
        host_name:, scope:, is_private:, is_embedded:, session_storage:, logger: Logger.new(STDOUT))
        @api_key = api_key
        @api_secret_key = api_secret_key
        @api_version = api_version
        @host_name = host_name
        @is_private = is_private
        @scope = Auth::AuthScopes.new(scope)
        @is_embedded = is_embedded
        @session_storage = session_storage
        @logger = logger
      end

      sig { returns(String) }
      attr_reader :api_key, :api_secret_key, :api_version, :host_name

      sig { returns(Auth::AuthScopes) }
      attr_reader :scope

      sig { returns(ShopifyAPI::Auth::SessionStorage) }
      attr_reader :session_storage

      sig { returns(Logger) }
      attr_reader :logger

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
