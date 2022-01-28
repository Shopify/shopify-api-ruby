# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class LocationsForMove < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [:fulfillment_order_id], path: "fulfillment_orders/<fulfillment_order_id>/locations_for_move.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(T::Array[Hash])) }
    attr_reader :locations_for_move

    class << self
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
          fulfillment_order_id: T.nilable(T.any(Integer, String)),
          kwargs: T.untyped
        ).returns(T::Array[LocationsForMove])
      end
      def all(
        session:,
        fulfillment_order_id: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {fulfillment_order_id: fulfillment_order_id},
          params: {}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[LocationsForMove])
      end

    end

  end
end
