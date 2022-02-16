# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class ScriptTag < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "script_tags.json"},
      {http_method: :post, operation: :post, ids: [], path: "script_tags.json"},
      {http_method: :get, operation: :count, ids: [], path: "script_tags/count.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "script_tags/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "script_tags/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "script_tags/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(String) }
    attr_reader :event
    sig { returns(String) }
    attr_reader :src
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :cache
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(String)) }
    attr_reader :display_scope
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          fields: T.untyped
        ).returns(T.nilable(ScriptTag))
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
        T.cast(result[0], T.nilable(ScriptTag))
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
          created_at_min: T.untyped,
          created_at_max: T.untyped,
          updated_at_min: T.untyped,
          updated_at_max: T.untyped,
          src: T.untyped,
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[ScriptTag])
      end
      def all(
        session:,
        limit: nil,
        since_id: nil,
        created_at_min: nil,
        created_at_max: nil,
        updated_at_min: nil,
        updated_at_max: nil,
        src: nil,
        fields: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {limit: limit, since_id: since_id, created_at_min: created_at_min, created_at_max: created_at_max, updated_at_min: updated_at_min, updated_at_max: updated_at_max, src: src, fields: fields}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[ScriptTag])
      end

      sig do
        params(
          session: Auth::Session,
          src: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        src: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          ids: {},
          params: {src: src}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

    end

  end
end
