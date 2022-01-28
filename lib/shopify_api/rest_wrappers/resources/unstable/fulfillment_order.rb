# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class FulfillmentOrder < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [:order_id], path: "orders/<order_id>/fulfillment_orders.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "fulfillment_orders/<id>.json"},
      {http_method: :post, operation: :cancel, ids: [:id], path: "fulfillment_orders/<id>/cancel.json"},
      {http_method: :post, operation: :close, ids: [:id], path: "fulfillment_orders/<id>/close.json"},
      {http_method: :post, operation: :move, ids: [:id], path: "fulfillment_orders/<id>/move.json"},
      {http_method: :post, operation: :open, ids: [:id], path: "fulfillment_orders/<id>/open.json"},
      {http_method: :post, operation: :reschedule, ids: [:id], path: "fulfillment_orders/<id>/reschedule.json"},
      {http_method: :post, operation: :hold, ids: [:id], path: "fulfillment_orders/<id>/hold.json"},
      {http_method: :post, operation: :release_hold, ids: [:id], path: "fulfillment_orders/<id>/release_hold.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(Hash)) }
    attr_reader :assigned_location
    sig { returns(T.nilable(Integer)) }
    attr_reader :assigned_location_id
    sig { returns(T.nilable(Hash)) }
    attr_reader :delivery_method
    sig { returns(T.nilable(Hash)) }
    attr_reader :destination
    sig { returns(T.nilable(String)) }
    attr_reader :fulfill_at
    sig { returns(T.nilable(T::Array[Hash])) }
    attr_reader :fulfillment_holds
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(Hash)) }
    attr_reader :international_duties
    sig { returns(T.nilable(T::Array[Hash])) }
    attr_reader :line_items
    sig { returns(T.nilable(T::Array[Hash])) }
    attr_reader :merchant_requests
    sig { returns(T.nilable(Integer)) }
    attr_reader :order_id
    sig { returns(T.nilable(String)) }
    attr_reader :request_status
    sig { returns(T.nilable(Integer)) }
    attr_reader :shop_id
    sig { returns(T.nilable(String)) }
    attr_reader :status
    sig { returns(T.nilable(T::Array[String])) }
    attr_reader :supported_actions

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String)
        ).returns(T.nilable(FulfillmentOrder))
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
        T.cast(result[0], T.nilable(FulfillmentOrder))
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
          kwargs: T.untyped
        ).returns(T::Array[FulfillmentOrder])
      end
      def all(
        session:,
        order_id: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {order_id: order_id},
          params: {}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[FulfillmentOrder])
      end

    end

    sig do
      params(
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def cancel(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :cancel,
        session: @session,
        path_ids: {id: @id},
        params: {}.merge(kwargs).compact,
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
    def close(
      message: nil,
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :close,
        session: @session,
        path_ids: {id: @id},
        params: {message: message}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

    sig do
      params(
        new_location_id: T.untyped,
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def move(
      new_location_id: nil,
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :move,
        session: @session,
        path_ids: {id: @id},
        params: {new_location_id: new_location_id}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

    sig do
      params(
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def open(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :open,
        session: @session,
        path_ids: {id: @id},
        params: {}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

    sig do
      params(
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def reschedule(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :reschedule,
        session: @session,
        path_ids: {id: @id},
        params: {}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

    sig do
      params(
        reason: T.untyped,
        reason_notes: T.untyped,
        notify_merchant: T.untyped,
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def hold(
      reason: nil,
      reason_notes: nil,
      notify_merchant: nil,
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :hold,
        session: @session,
        path_ids: {id: @id},
        params: {reason: reason, reason_notes: reason_notes, notify_merchant: notify_merchant}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

    sig do
      params(
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def release_hold(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :release_hold,
        session: @session,
        path_ids: {id: @id},
        params: {}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

  end
end
