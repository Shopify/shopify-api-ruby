# typed: false
# frozen_string_literal: true

module ShopifyAPI
  class StorefrontAccessToken < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: nil)
      super(session: session)

      @title = T.let(nil, T.nilable(String))
      @access_scope = T.let(nil, T.nilable(AccessScope))
      @access_token = T.let(nil, T.nilable(String))
      @created_at = T.let(nil, T.nilable(String))
      @id = T.let(nil, T.nilable(Integer))
    end

    @has_one = T.let({
      access_scope: AccessScope
    }, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :post, operation: :post, ids: [], path: "storefront_access_tokens.json"},
      {http_method: :get, operation: :get, ids: [], path: "storefront_access_tokens.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "storefront_access_tokens/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :title
    sig { returns(T.nilable(AccessScope)) }
    attr_reader :access_scope
    sig { returns(T.nilable(String)) }
    attr_reader :access_token
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :id

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String)
        ).returns(T.untyped)
      end
      def delete(
        session:,
        id:
      )
        request(
          http_method: :delete,
          operation: :delete,
          session: session,
          ids: {id: id},
          params: {},
        )
      end

      sig do
        params(
          session: Auth::Session,
          kwargs: T.untyped
        ).returns(T::Array[StorefrontAccessToken])
      end
      def all(
        session:,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[StorefrontAccessToken])
      end

    end

  end
end
