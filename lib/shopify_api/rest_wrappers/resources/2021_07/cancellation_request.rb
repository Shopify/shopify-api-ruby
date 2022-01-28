# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class CancellationRequest < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

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
          kwargs: T.untyped
        ).returns(T::Array[CancellationRequest])
      end
      def all(
        session:,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[CancellationRequest])
      end

    end

    sig do
      params(
        message: T.untyped,
        body: T.nilable(T.untyped),
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
        path_ids: {fulfillment_order_id: @fulfillment_order_id},
        params: {message: message}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

    sig do
      params(
        message: T.untyped,
        body: T.nilable(T.untyped),
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
        path_ids: {fulfillment_order_id: @fulfillment_order_id},
        params: {message: message}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

  end
end
