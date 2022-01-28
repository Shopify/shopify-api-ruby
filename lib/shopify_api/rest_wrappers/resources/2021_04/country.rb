# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Country < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({
      provinces: Province
    }, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "countries.json"},
      {http_method: :post, operation: :post, ids: [], path: "countries.json"},
      {http_method: :get, operation: :count, ids: [], path: "countries/count.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "countries/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "countries/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "countries/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :code
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :name
    sig { returns(T.nilable(T::Array[Province])) }
    attr_reader :provinces
    sig { returns(T.nilable(Float)) }
    attr_reader :tax

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          fields: T.untyped
        ).returns(T.nilable(Country))
      end
      def find(
        session:,
        id:,
        fields: nil
      )
        result = base_find(
          ids: {id: id},
          params: {fields: fields},
          session: session,
        )
        T.cast(result[0], T.nilable(Country))
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
          path_ids: {id: id},
          params: {},
        )
      end

      sig do
        params(
          session: Auth::Session,
          since_id: T.untyped,
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[Country])
      end
      def all(
        session:,
        since_id: nil,
        fields: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {since_id: since_id, fields: fields}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[Country])
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
          path_ids: {},
          params: {}.merge(kwargs).compact,
          entity: nil,
        )
      end

    end

  end
end
