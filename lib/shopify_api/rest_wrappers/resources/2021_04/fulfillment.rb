# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Fulfillment < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [:order_id], path: "orders/<order_id>/fulfillments.json"},
      {http_method: :post, operation: :post, ids: [:order_id], path: "orders/<order_id>/fulfillments.json"},
      {http_method: :get, operation: :get, ids: [:fulfillment_order_id], path: "fulfillment_orders/<fulfillment_order_id>/fulfillments.json"},
      {http_method: :get, operation: :count, ids: [:order_id], path: "orders/<order_id>/fulfillments/count.json"},
      {http_method: :get, operation: :get, ids: [:order_id, :id], path: "orders/<order_id>/fulfillments/<id>.json"},
      {http_method: :put, operation: :put, ids: [:order_id, :id], path: "orders/<order_id>/fulfillments/<id>.json"},
      {http_method: :post, operation: :post, ids: [], path: "fulfillments.json"},
      {http_method: :post, operation: :update_tracking, ids: [:id], path: "fulfillments/<id>/update_tracking.json"},
      {http_method: :post, operation: :complete, ids: [:order_id, :id], path: "orders/<order_id>/fulfillments/<id>/complete.json"},
      {http_method: :post, operation: :open, ids: [:order_id, :id], path: "orders/<order_id>/fulfillments/<id>/open.json"},
      {http_method: :post, operation: :cancel, ids: [:order_id, :id], path: "orders/<order_id>/fulfillments/<id>/cancel.json"},
      {http_method: :post, operation: :cancel, ids: [:id], path: "fulfillments/<id>/cancel.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(T::Array[Hash])) }
    attr_reader :line_items
    sig { returns(T.nilable(Integer)) }
    attr_reader :location_id
    sig { returns(T.nilable(String)) }
    attr_reader :name
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :notify_customer
    sig { returns(T.nilable(Integer)) }
    attr_reader :order_id
    sig { returns(T.nilable(Hash)) }
    attr_reader :receipt
    sig { returns(T.nilable(String)) }
    attr_reader :service
    sig { returns(T.nilable(String)) }
    attr_reader :shipment_status
    sig { returns(T.nilable(String)) }
    attr_reader :status
    sig { returns(T.nilable(String)) }
    attr_reader :tracking_company
    sig { returns(T.nilable(T::Array[String])) }
    attr_reader :tracking_numbers
    sig { returns(T.nilable(T::Array[String])) }
    attr_reader :tracking_urls
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at
    sig { returns(T.nilable(String)) }
    attr_reader :variant_inventory_management

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          order_id: T.nilable(T.any(Integer, String)),
          fields: T.untyped
        ).returns(T.nilable(Fulfillment))
      end
      def find(
        session:,
        id:,
        order_id: nil,
        fields: nil
      )
        result = base_find(
          ids: {order_id: order_id, id: id},
          params: {fields: fields},
          session: session,
        )
        T.cast(result[0], T.nilable(Fulfillment))
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
          fulfillment_order_id: T.nilable(T.any(Integer, String)),
          created_at_max: T.untyped,
          created_at_min: T.untyped,
          fields: T.untyped,
          limit: T.untyped,
          since_id: T.untyped,
          updated_at_max: T.untyped,
          updated_at_min: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[Fulfillment])
      end
      def all(
        session:,
        order_id: nil,
        fulfillment_order_id: nil,
        created_at_max: nil,
        created_at_min: nil,
        fields: nil,
        limit: nil,
        since_id: nil,
        updated_at_max: nil,
        updated_at_min: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {order_id: order_id, fulfillment_order_id: fulfillment_order_id},
          params: {created_at_max: created_at_max, created_at_min: created_at_min, fields: fields, limit: limit, since_id: since_id, updated_at_max: updated_at_max, updated_at_min: updated_at_min}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[Fulfillment])
      end

      sig do
        params(
          session: Auth::Session,
          order_id: T.nilable(T.any(Integer, String)),
          created_at_min: T.untyped,
          created_at_max: T.untyped,
          updated_at_min: T.untyped,
          updated_at_max: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        order_id: nil,
        created_at_min: nil,
        created_at_max: nil,
        updated_at_min: nil,
        updated_at_max: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          path_ids: {order_id: order_id},
          params: {created_at_min: created_at_min, created_at_max: created_at_max, updated_at_min: updated_at_min, updated_at_max: updated_at_max}.merge(kwargs).compact,
          entity: nil,
        )
      end

    end

    sig do
      params(
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def update_tracking(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :update_tracking,
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
    def complete(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :complete,
        session: @session,
        path_ids: {order_id: @order_id, id: @id},
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
    def open(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :open,
        session: @session,
        path_ids: {order_id: @order_id, id: @id},
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
    def cancel(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :cancel,
        session: @session,
        path_ids: {order_id: @order_id, id: @id},
        params: {}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

  end
end
