# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Metafield < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "metafields.json"},
      {http_method: :post, operation: :post, ids: [], path: "metafields.json"},
      {http_method: :get, operation: :get, ids: [], path: "metafields.json"},
      {http_method: :get, operation: :count, ids: [], path: "metafields/count.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "metafields/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "metafields/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "metafields/<id>.json"},
      {http_method: :get, operation: :get, ids: [:owner_id], path: "products/<owner_id>/metafields.json"},
      {http_method: :post, operation: :post, ids: [:owner_id], path: "products/<owner_id>/metafields.json"},
      {http_method: :get, operation: :count, ids: [:owner_id], path: "products/<owner_id>/metafields/count.json"},
      {http_method: :get, operation: :get, ids: [:owner_id, :id], path: "products/<owner_id>/metafields/<id>.json"},
      {http_method: :put, operation: :put, ids: [:owner_id, :id], path: "products/<owner_id>/metafields/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:owner_id, :id], path: "products/<owner_id>/metafields/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(String) }
    attr_reader :key
    sig { returns(String) }
    attr_reader :namespace
    sig { returns(T::Array[String, Integer, Float]) }
    attr_reader :value
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(String)) }
    attr_reader :description
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(Integer)) }
    attr_reader :owner_id
    sig { returns(T.nilable(String)) }
    attr_reader :owner_resource
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at
    sig { returns(T.nilable(String)) }
    attr_reader :value_type

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          owner_id: T.nilable(T.any(Integer, String)),
          fields: T.untyped
        ).returns(T.nilable(Metafield))
      end
      def find(
        session:,
        id:,
        owner_id: nil,
        fields: nil
      )
        result = base_find(
          ids: {id: id, owner_id: owner_id},
          params: {fields: fields},
          session: session,
        )
        T.cast(result[0], T.nilable(Metafield))
      end

      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          owner_id: T.nilable(T.any(Integer, String))
        ).returns(T.untyped)
      end
      def delete(
        session:,
        id:,
        owner_id: nil
      )
        request(
          http_method: :delete,
          operation: :delete,
          session: session,
          path_ids: {id: id, owner_id: owner_id},
          params: {},
        )
      end

      sig do
        params(
          session: Auth::Session,
          owner_id: T.nilable(T.any(Integer, String)),
          limit: T.untyped,
          since_id: T.untyped,
          created_at_min: T.untyped,
          created_at_max: T.untyped,
          updated_at_min: T.untyped,
          updated_at_max: T.untyped,
          namespace: T.untyped,
          key: T.untyped,
          value_type: T.untyped,
          fields: T.untyped,
          metafield: T.nilable(Hash),
          kwargs: T.untyped
        ).returns(T::Array[Metafield])
      end
      def all(
        session:,
        owner_id: nil,
        limit: nil,
        since_id: nil,
        created_at_min: nil,
        created_at_max: nil,
        updated_at_min: nil,
        updated_at_max: nil,
        namespace: nil,
        key: nil,
        value_type: nil,
        fields: nil,
        metafield: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {owner_id: owner_id},
          params: {limit: limit, since_id: since_id, created_at_min: created_at_min, created_at_max: created_at_max, updated_at_min: updated_at_min, updated_at_max: updated_at_max, namespace: namespace, key: key, value_type: value_type, fields: fields, metafield: metafield}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[Metafield])
      end

      sig do
        params(
          session: Auth::Session,
          owner_id: T.nilable(T.any(Integer, String)),
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        owner_id: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          path_ids: {owner_id: owner_id},
          params: {}.merge(kwargs).compact,
          entity: nil,
        )
      end

    end

  end
end
