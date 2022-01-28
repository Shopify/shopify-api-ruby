# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Event < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "events.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "events/<id>.json"},
      {http_method: :get, operation: :count, ids: [], path: "events/count.json"},
      {http_method: :get, operation: :get, ids: [:order_id], path: "orders/<order_id>/events.json"},
      {http_method: :get, operation: :get, ids: [:product_id], path: "products/<product_id>/events.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :arguments
    sig { returns(T.nilable(String)) }
    attr_reader :body
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(String)) }
    attr_reader :description
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :message
    sig { returns(T.nilable(String)) }
    attr_reader :path
    sig { returns(T.nilable(Integer)) }
    attr_reader :subject_id
    sig { returns(T.nilable(String)) }
    attr_reader :subject_type
    sig { returns(T.nilable(String)) }
    attr_reader :verb

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          fields: T.untyped
        ).returns(T.nilable(Event))
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
        T.cast(result[0], T.nilable(Event))
      end

      sig do
        params(
          session: Auth::Session
        ).returns(T.untyped)
      end
      def delete(session:)
        request(
          http_method: :delete,
          operation: :delete,
          session: session,
          path_ids: {},
          params: {},
        )
      end

      sig do
        params(
          session: Auth::Session,
          order_id: T.nilable(T.any(Integer, String)),
          product_id: T.nilable(T.any(Integer, String)),
          limit: T.untyped,
          since_id: T.untyped,
          created_at_min: T.untyped,
          created_at_max: T.untyped,
          filter: T.untyped,
          verb: T.untyped,
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[Event])
      end
      def all(
        session:,
        order_id: nil,
        product_id: nil,
        limit: nil,
        since_id: nil,
        created_at_min: nil,
        created_at_max: nil,
        filter: nil,
        verb: nil,
        fields: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {order_id: order_id, product_id: product_id},
          params: {limit: limit, since_id: since_id, created_at_min: created_at_min, created_at_max: created_at_max, filter: filter, verb: verb, fields: fields}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[Event])
      end

      sig do
        params(
          session: Auth::Session,
          created_at_min: T.untyped,
          created_at_max: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        created_at_min: nil,
        created_at_max: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          path_ids: {},
          params: {created_at_min: created_at_min, created_at_max: created_at_max}.merge(kwargs).compact,
          entity: nil,
        )
      end

    end

  end
end
