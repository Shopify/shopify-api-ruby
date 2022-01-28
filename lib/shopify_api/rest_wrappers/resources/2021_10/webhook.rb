# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Webhook < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "webhooks.json"},
      {http_method: :post, operation: :post, ids: [], path: "webhooks.json"},
      {http_method: :get, operation: :count, ids: [], path: "webhooks/count.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "webhooks/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "webhooks/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "webhooks/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(String) }
    attr_reader :address
    sig { returns(String) }
    attr_reader :topic
    sig { returns(T.nilable(String)) }
    attr_reader :api_version
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(T::Array[String])) }
    attr_reader :fields
    sig { returns(T.nilable(String)) }
    attr_reader :format
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(T::Array[String])) }
    attr_reader :metafield_namespaces
    sig { returns(T.nilable(T::Array[String])) }
    attr_reader :private_metafield_namespaces
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          fields: T.untyped
        ).returns(T.nilable(Webhook))
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
        T.cast(result[0], T.nilable(Webhook))
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
          address: T.untyped,
          created_at_max: T.untyped,
          created_at_min: T.untyped,
          fields: T.untyped,
          limit: T.untyped,
          since_id: T.untyped,
          topic: T.untyped,
          updated_at_min: T.untyped,
          updated_at_max: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[Webhook])
      end
      def all(
        session:,
        address: nil,
        created_at_max: nil,
        created_at_min: nil,
        fields: nil,
        limit: nil,
        since_id: nil,
        topic: nil,
        updated_at_min: nil,
        updated_at_max: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {address: address, created_at_max: created_at_max, created_at_min: created_at_min, fields: fields, limit: limit, since_id: since_id, topic: topic, updated_at_min: updated_at_min, updated_at_max: updated_at_max}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[Webhook])
      end

      sig do
        params(
          session: Auth::Session,
          address: T.untyped,
          topic: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        address: nil,
        topic: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          path_ids: {},
          params: {address: address, topic: topic}.merge(kwargs).compact,
          entity: nil,
        )
      end

    end

  end
end
