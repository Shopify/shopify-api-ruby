# typed: false
# frozen_string_literal: true

module ShopifyAPI
  class CancellationRequest < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: ShopifyAPI::Context.active_session)
      super(session: session)

      @fulfillment_order_id = T.let(nil, T.nilable(Integer))
    end

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :post, operation: :post, ids: [:fulfillment_order_id], path: "fulfillment_orders/<fulfillment_order_id>/cancellation_request.json"},
      {http_method: :post, operation: :accept, ids: [:fulfillment_order_id], path: "fulfillment_orders/<fulfillment_order_id>/cancellation_request/accept.json"},
      {http_method: :post, operation: :reject, ids: [:fulfillment_order_id], path: "fulfillment_orders/<fulfillment_order_id>/cancellation_request/reject.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(Integer)) }
    attr_reader :fulfillment_order_id

    class << self
    end

    sig do
      params(
        message: T.untyped,
        body: T.untyped,
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def accept(
      message: nil,
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :accept,
        session: @session,
        ids: {fulfillment_order_id: @fulfillment_order_id},
        params: {message: message}.merge(kwargs).compact,
        body: body,
        entity: self,
      )
    end

    sig do
      params(
        message: T.untyped,
        body: T.untyped,
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def reject(
      message: nil,
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :reject,
        session: @session,
        ids: {fulfillment_order_id: @fulfillment_order_id},
        params: {message: message}.merge(kwargs).compact,
        body: body,
        entity: self,
      )
    end

  end
end
