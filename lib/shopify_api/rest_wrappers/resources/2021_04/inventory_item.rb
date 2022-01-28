# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class InventoryItem < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "inventory_items.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "inventory_items/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "inventory_items/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :cost
    sig { returns(T.nilable(String)) }
    attr_reader :country_code_of_origin
    sig { returns(T.nilable(T::Array[Hash])) }
    attr_reader :country_harmonized_system_codes
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :harmonized_system_code
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :province_code_of_origin
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :requires_shipping
    sig { returns(T.nilable(String)) }
    attr_reader :sku
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :tracked
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String)
        ).returns(T.nilable(InventoryItem))
      end
      def find(
        session:,
        id:
      )
        result = base_find(
          ids: {id: id},
          params: {},
          session: session,
        )
        T.cast(result[0], T.nilable(InventoryItem))
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
          ids: T.untyped,
          limit: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[InventoryItem])
      end
      def all(
        session:,
        ids: nil,
        limit: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {ids: ids, limit: limit}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[InventoryItem])
      end

    end

  end
end
