# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class FulfillmentEvent < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({
      country: Country,
      province: Province
    }, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [:order_id, :fulfillment_id], path: "orders/<order_id>/fulfillments/<fulfillment_id>/events.json"},
      {http_method: :post, operation: :post, ids: [:order_id, :fulfillment_id], path: "orders/<order_id>/fulfillments/<fulfillment_id>/events.json"},
      {http_method: :get, operation: :get, ids: [:order_id, :fulfillment_id, :id], path: "orders/<order_id>/fulfillments/<fulfillment_id>/events/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:order_id, :fulfillment_id, :id], path: "orders/<order_id>/fulfillments/<fulfillment_id>/events/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :address1
    sig { returns(T.nilable(String)) }
    attr_reader :city
    sig { returns(T.nilable(Country)) }
    attr_reader :country
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(String)) }
    attr_reader :estimated_delivery_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :fulfillment_id
    sig { returns(T.nilable(String)) }
    attr_reader :happened_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(Float)) }
    attr_reader :latitude
    sig { returns(T.nilable(Float)) }
    attr_reader :longitude
    sig { returns(T.nilable(String)) }
    attr_reader :message
    sig { returns(T.nilable(Integer)) }
    attr_reader :order_id
    sig { returns(T.nilable(Province)) }
    attr_reader :province
    sig { returns(T.nilable(Integer)) }
    attr_reader :shop_id
    sig { returns(T.nilable(String)) }
    attr_reader :status
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at
    sig { returns(T.nilable(String)) }
    attr_reader :zip

    class << self
      sig do
        returns(String)
      end
      def json_body_name()
        "event"
      end

      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          order_id: T.nilable(T.any(Integer, String)),
          fulfillment_id: T.nilable(T.any(Integer, String)),
          event_id: T.untyped
        ).returns(T.nilable(FulfillmentEvent))
      end
      def find(
        session:,
        id:,
        order_id: nil,
        fulfillment_id: nil,
        event_id: nil
      )
        result = base_find(
          session: session,
          ids: {id: id, order_id: order_id, fulfillment_id: fulfillment_id},
          params: {event_id: event_id},
        )
        T.cast(result[0], T.nilable(FulfillmentEvent))
      end

      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          order_id: T.nilable(T.any(Integer, String)),
          fulfillment_id: T.nilable(T.any(Integer, String))
        ).returns(T.untyped)
      end
      def delete(
        session:,
        id:,
        order_id: nil,
        fulfillment_id: nil
      )
        request(
          http_method: :delete,
          operation: :delete,
          session: session,
          ids: {id: id, order_id: order_id, fulfillment_id: fulfillment_id},
          params: {},
        )
      end

      sig do
        params(
          session: Auth::Session,
          order_id: T.nilable(T.any(Integer, String)),
          fulfillment_id: T.nilable(T.any(Integer, String)),
          kwargs: T.untyped
        ).returns(T::Array[FulfillmentEvent])
      end
      def all(
        session:,
        order_id: nil,
        fulfillment_id: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {order_id: order_id, fulfillment_id: fulfillment_id},
          params: {}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[FulfillmentEvent])
      end

    end

  end
end
