# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class FulfillmentService < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "fulfillment_services.json"},
      {http_method: :post, operation: :post, ids: [], path: "fulfillment_services.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "fulfillment_services/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "fulfillment_services/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "fulfillment_services/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :admin_graphql_api_id
    sig { returns(T.nilable(String)) }
    attr_reader :callback_url
    sig { returns(T.nilable(String)) }
    attr_reader :format
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :fulfillment_orders_opt_in
    sig { returns(T.nilable(String)) }
    attr_reader :handle
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :inventory_management
    sig { returns(T.nilable(Integer)) }
    attr_reader :location_id
    sig { returns(T.nilable(String)) }
    attr_reader :name
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :permits_sku_sharing
    sig { returns(T.nilable(String)) }
    attr_reader :provider_id
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :requires_shipping_method
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :tracking_support

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String)
        ).returns(T.nilable(FulfillmentService))
      end
      def find(
        session:,
        id:
      )
        result = base_find(
          session: session,
          ids: {id: id},
          params: {},
        )
        T.cast(result[0], T.nilable(FulfillmentService))
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
          scope: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[FulfillmentService])
      end
      def all(
        session:,
        scope: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {scope: scope}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[FulfillmentService])
      end

    end

  end
end
