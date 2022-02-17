# typed: false
# frozen_string_literal: true

module ShopifyAPI
  class Collect < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: nil)
      super(session: session)

      @collection_id = T.let(nil, T.nilable(Integer))
      @created_at = T.let(nil, T.nilable(String))
      @id = T.let(nil, T.nilable(Integer))
      @position = T.let(nil, T.nilable(Integer))
      @product_id = T.let(nil, T.nilable(Integer))
      @sort_value = T.let(nil, T.nilable(String))
      @updated_at = T.let(nil, T.nilable(String))
    end

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :post, operation: :post, ids: [], path: "collects.json"},
      {http_method: :get, operation: :get, ids: [], path: "collects.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "collects/<id>.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "collects/<id>.json"},
      {http_method: :get, operation: :count, ids: [], path: "collects/count.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(Integer)) }
    attr_reader :collection_id
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(Integer)) }
    attr_reader :position
    sig { returns(T.nilable(Integer)) }
    attr_reader :product_id
    sig { returns(T.nilable(String)) }
    attr_reader :sort_value
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          fields: T.untyped
        ).returns(T.nilable(Collect))
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
        T.cast(result[0], T.nilable(Collect))
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
        ).returns(T::Array[Collect])
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

        T.cast(response, T::Array[Collect])
      end

      sig do
        params(
          session: Auth::Session,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          ids: {},
          params: {}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

    end

  end
end
