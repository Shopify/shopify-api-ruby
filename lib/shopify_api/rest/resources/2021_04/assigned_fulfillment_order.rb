# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class AssignedFulfillmentOrder < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "assigned_fulfillment_orders.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(Integer)) }
    attr_reader :assigned_location_id
    sig { returns(T.nilable(Hash)) }
    attr_reader :destination
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(T::Array[Hash])) }
    attr_reader :line_items
    sig { returns(T.nilable(Integer)) }
    attr_reader :order_id
    sig { returns(T.nilable(String)) }
    attr_reader :request_status
    sig { returns(T.nilable(Integer)) }
    attr_reader :shop_id
    sig { returns(T.nilable(String)) }
    attr_reader :status

    class << self
      sig do
        params(
          session: Auth::Session,
          assignment_status: T.untyped,
          location_ids: T.nilable(T.any(Array, Integer, String)),
          kwargs: T.untyped
        ).returns(T::Array[AssignedFulfillmentOrder])
      end
      def all(
        session:,
        assignment_status: nil,
        location_ids: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {assignment_status: assignment_status, location_ids: location_ids}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[AssignedFulfillmentOrder])
      end

    end

  end
end
