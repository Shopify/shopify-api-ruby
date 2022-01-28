# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Report < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "reports.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "reports/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "reports/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "reports/<id>.json"},
      {http_method: :post, operation: :post, ids: [], path: "reports.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :category
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :name
    sig { returns(T.nilable(String)) }
    attr_reader :shopify_ql
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          fields: T.untyped
        ).returns(T.nilable(Report))
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
        T.cast(result[0], T.nilable(Report))
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
          ids: T.untyped,
          limit: T.untyped,
          since_id: T.untyped,
          updated_at_min: T.untyped,
          updated_at_max: T.untyped,
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[Report])
      end
      def all(
        session:,
        ids: nil,
        limit: nil,
        since_id: nil,
        updated_at_min: nil,
        updated_at_max: nil,
        fields: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {ids: ids, limit: limit, since_id: since_id, updated_at_min: updated_at_min, updated_at_max: updated_at_max, fields: fields}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[Report])
      end

    end

  end
end
