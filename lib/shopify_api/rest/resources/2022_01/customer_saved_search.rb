# typed: false
# frozen_string_literal: true

module ShopifyAPI
  class CustomerSavedSearch < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: nil)
      super(session: session)

      @created_at = T.let(nil, T.nilable(String))
      @id = T.let(nil, T.nilable(Integer))
      @name = T.let(nil, T.nilable(String))
      @query = T.let(nil, T.nilable(String))
      @updated_at = T.let(nil, T.nilable(String))
    end

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "customer_saved_searches.json"},
      {http_method: :post, operation: :post, ids: [], path: "customer_saved_searches.json"},
      {http_method: :get, operation: :count, ids: [], path: "customer_saved_searches/count.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "customer_saved_searches/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "customer_saved_searches/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "customer_saved_searches/<id>.json"},
      {http_method: :get, operation: :customers, ids: [:id], path: "customer_saved_searches/<id>/customers.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :name
    sig { returns(T.nilable(String)) }
    attr_reader :query
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          fields: T.untyped
        ).returns(T.nilable(CustomerSavedSearch))
      end
      def find(
        session:,
        id:,
        fields: nil
      )
        result = base_find(
          session: session,
          ids: {id: id},
          params: {fields: fields},
        )
        T.cast(result[0], T.nilable(CustomerSavedSearch))
      end

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
          limit: T.untyped,
          since_id: T.untyped,
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[CustomerSavedSearch])
      end
      def all(
        session:,
        limit: nil,
        since_id: nil,
        fields: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {limit: limit, since_id: since_id, fields: fields}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[CustomerSavedSearch])
      end

      sig do
        params(
          session: Auth::Session,
          since_id: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        since_id: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          ids: {},
          params: {since_id: since_id}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          order: T.untyped,
          limit: T.untyped,
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def customers(
        session:,
        id:,
        order: nil,
        limit: nil,
        fields: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :customers,
          session: session,
          ids: {id: id},
          params: {order: order, limit: limit, fields: fields}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

    end

  end
end
