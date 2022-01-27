# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class PriceRule < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :post, operation: :post, ids: [], path: "price_rules.json"},
      {http_method: :get, operation: :get, ids: [], path: "price_rules.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "price_rules/<id>.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "price_rules/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "price_rules/<id>.json"},
      {http_method: :get, operation: :count, ids: [], path: "price_rules/count.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(Integer)) }
    attr_reader :allocation_limit
    sig { returns(T.nilable(String)) }
    attr_reader :allocation_method
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(String)) }
    attr_reader :customer_selection
    sig { returns(T.nilable(String)) }
    attr_reader :ends_at
    sig { returns(T.nilable(T::Array[Integer])) }
    attr_reader :entitled_collection_ids
    sig { returns(T.nilable(T::Array[Integer])) }
    attr_reader :entitled_country_ids
    sig { returns(T.nilable(T::Array[Integer])) }
    attr_reader :entitled_product_ids
    sig { returns(T.nilable(T::Array[Integer])) }
    attr_reader :entitled_variant_ids
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :once_per_customer
    sig { returns(T.nilable(T::Array[Integer])) }
    attr_reader :prerequisite_collection_ids
    sig { returns(T.nilable(T::Array[Integer])) }
    attr_reader :prerequisite_customer_ids
    sig { returns(T.nilable(T::Array[Integer])) }
    attr_reader :prerequisite_product_ids
    sig { returns(T.nilable(Hash)) }
    attr_reader :prerequisite_quantity_range
    sig { returns(T.nilable(T::Array[Integer])) }
    attr_reader :prerequisite_saved_search_ids
    sig { returns(T.nilable(Hash)) }
    attr_reader :prerequisite_shipping_price_range
    sig { returns(T.nilable(Hash)) }
    attr_reader :prerequisite_subtotal_range
    sig { returns(T.nilable(Hash)) }
    attr_reader :prerequisite_to_entitlement_purchase
    sig { returns(T.nilable(Hash)) }
    attr_reader :prerequisite_to_entitlement_quantity_ratio
    sig { returns(T.nilable(T::Array[Integer])) }
    attr_reader :prerequisite_variant_ids
    sig { returns(T.nilable(String)) }
    attr_reader :starts_at
    sig { returns(T.nilable(String)) }
    attr_reader :target_selection
    sig { returns(T.nilable(String)) }
    attr_reader :target_type
    sig { returns(T.nilable(String)) }
    attr_reader :title
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :usage_limit
    sig { returns(T.nilable(String)) }
    attr_reader :value
    sig { returns(T.nilable(String)) }
    attr_reader :value_type

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String)
        ).returns(T.nilable(PriceRule))
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
        T.cast(result[0], T.nilable(PriceRule))
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
          limit: T.untyped,
          since_id: T.untyped,
          created_at_min: T.untyped,
          created_at_max: T.untyped,
          updated_at_min: T.untyped,
          updated_at_max: T.untyped,
          starts_at_min: T.untyped,
          starts_at_max: T.untyped,
          ends_at_min: T.untyped,
          ends_at_max: T.untyped,
          times_used: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[PriceRule])
      end
      def all(
        session:,
        limit: nil,
        since_id: nil,
        created_at_min: nil,
        created_at_max: nil,
        updated_at_min: nil,
        updated_at_max: nil,
        starts_at_min: nil,
        starts_at_max: nil,
        ends_at_min: nil,
        ends_at_max: nil,
        times_used: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {limit: limit, since_id: since_id, created_at_min: created_at_min, created_at_max: created_at_max, updated_at_min: updated_at_min, updated_at_max: updated_at_max, starts_at_min: starts_at_min, starts_at_max: starts_at_max, ends_at_min: ends_at_min, ends_at_max: ends_at_max, times_used: times_used}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[PriceRule])
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
