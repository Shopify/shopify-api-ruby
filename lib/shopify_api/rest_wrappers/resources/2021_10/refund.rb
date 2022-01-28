# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Refund < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({
      transactions: Transaction
    }, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [:order_id], path: "orders/<order_id>/refunds.json"},
      {http_method: :post, operation: :post, ids: [:order_id], path: "orders/<order_id>/refunds.json"},
      {http_method: :get, operation: :get, ids: [:order_id, :id], path: "orders/<order_id>/refunds/<id>.json"},
      {http_method: :post, operation: :calculate, ids: [:order_id], path: "orders/<order_id>/refunds/calculate.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(T::Array[Hash])) }
    attr_reader :duties
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :note
    sig { returns(T.nilable(T::Array[Hash])) }
    attr_reader :order_adjustments
    sig { returns(T.nilable(Integer)) }
    attr_reader :order_id
    sig { returns(T.nilable(String)) }
    attr_reader :processed_at
    sig { returns(T.nilable(T::Array[Hash])) }
    attr_reader :refund_duties
    sig { returns(T.nilable(T::Array[Hash])) }
    attr_reader :refund_line_items
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :restock
    sig { returns(T.nilable(T::Array[Transaction])) }
    attr_reader :transactions
    sig { returns(T.nilable(Integer)) }
    attr_reader :user_id

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          order_id: T.nilable(T.any(Integer, String)),
          fields: T.untyped,
          in_shop_currency: T.untyped
        ).returns(T.nilable(Refund))
      end
      def find(
        session:,
        id:,
        order_id: nil,
        fields: nil,
        in_shop_currency: nil
      )
        result = base_find(
          ids: {order_id: order_id, id: id},
          params: {fields: fields, in_shop_currency: in_shop_currency},
          session: session,
        )
        T.cast(result[0], T.nilable(Refund))
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
          limit: T.untyped,
          fields: T.untyped,
          in_shop_currency: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[Refund])
      end
      def all(
        session:,
        order_id: nil,
        limit: nil,
        fields: nil,
        in_shop_currency: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {order_id: order_id},
          params: {limit: limit, fields: fields, in_shop_currency: in_shop_currency}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[Refund])
      end

    end

    sig do
      params(
        shipping: T.untyped,
        refund_line_items: T.untyped,
        currency: T.untyped,
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def calculate(
      shipping: nil,
      refund_line_items: nil,
      currency: nil,
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :calculate,
        session: @session,
        path_ids: {order_id: @order_id},
        params: {shipping: shipping, refund_line_items: refund_line_items, currency: currency}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

  end
end
