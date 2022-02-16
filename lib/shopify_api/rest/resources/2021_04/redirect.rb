# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Redirect < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "redirects.json"},
      {http_method: :post, operation: :post, ids: [], path: "redirects.json"},
      {http_method: :get, operation: :count, ids: [], path: "redirects/count.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "redirects/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "redirects/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "redirects/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :path
    sig { returns(T.nilable(String)) }
    attr_reader :target

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          fields: T.untyped
        ).returns(T.nilable(Redirect))
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
        T.cast(result[0], T.nilable(Redirect))
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
          path: T.untyped,
          target: T.untyped,
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[Redirect])
      end
      def all(
        session:,
        limit: nil,
        since_id: nil,
        path: nil,
        target: nil,
        fields: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {limit: limit, since_id: since_id, path: path, target: target, fields: fields}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[Redirect])
      end

      sig do
        params(
          session: Auth::Session,
          path: T.untyped,
          target: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        path: nil,
        target: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          ids: {},
          params: {path: path, target: target}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

    end

  end
end
