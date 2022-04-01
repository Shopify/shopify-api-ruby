# typed: false
# frozen_string_literal: true

module ShopifyAPI
  class Refund < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: ShopifyAPI::Context.active_session)
      super(session: session)

      @created_at = T.let(nil, T.nilable(String))
      @duties = T.let(nil, T.nilable(T::Array[T.untyped]))
      @id = T.let(nil, T.nilable(Integer))
      @note = T.let(nil, T.nilable(String))
      @order_adjustments = T.let(nil, T.nilable(T::Array[T.untyped]))
      @order_id = T.let(nil, T.nilable(Integer))
      @processed_at = T.let(nil, T.nilable(String))
      @refund_duties = T.let(nil, T.nilable(T::Array[T.untyped]))
      @refund_line_items = T.let(nil, T.nilable(T::Array[T.untyped]))
      @restock = T.let(nil, T.nilable(T::Boolean))
      @transactions = T.let(nil, T.nilable(T::Array[T.untyped]))
      @user_id = T.let(nil, T.nilable(Integer))
    end

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({
      transactions: Transaction
    }, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [:order_id], path: "orders/<order_id>/refunds.json"},
      {http_method: :get, operation: :get, ids: [:order_id, :id], path: "orders/<order_id>/refunds/<id>.json"},
      {http_method: :post, operation: :calculate, ids: [:order_id], path: "orders/<order_id>/refunds/calculate.json"},
      {http_method: :post, operation: :post, ids: [:order_id], path: "orders/<order_id>/refunds.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(T::Array[T::Hash[T.untyped, T.untyped]])) }
    attr_reader :duties
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :note
    sig { returns(T.nilable(T::Array[T::Hash[T.untyped, T.untyped]])) }
    attr_reader :order_adjustments
    sig { returns(T.nilable(Integer)) }
    attr_reader :order_id
    sig { returns(T.nilable(String)) }
    attr_reader :processed_at
    sig { returns(T.nilable(T::Array[T::Hash[T.untyped, T.untyped]])) }
    attr_reader :refund_duties
    sig { returns(T.nilable(T::Array[T::Hash[T.untyped, T.untyped]])) }
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
          id: T.any(Integer, String),
          order_id: T.nilable(T.any(Integer, String)),
          fields: T.untyped,
          in_shop_currency: T.untyped,
          session: Auth::Session
        ).returns(T.nilable(Refund))
      end
      def find(
        id:,
        order_id: nil,
        fields: nil,
        in_shop_currency: nil,
        session: ShopifyAPI::Context.active_session
      )
        result = base_find(
          session: session,
          ids: {id: id, order_id: order_id},
          params: {fields: fields, in_shop_currency: in_shop_currency},
        )
        T.cast(result[0], T.nilable(Refund))
      end

      sig do
        params(
          order_id: T.nilable(T.any(Integer, String)),
          limit: T.untyped,
          fields: T.untyped,
          in_shop_currency: T.untyped,
          session: Auth::Session,
          kwargs: T.untyped
        ).returns(T::Array[Refund])
      end
      def all(
        order_id: nil,
        limit: nil,
        fields: nil,
        in_shop_currency: nil,
        session: ShopifyAPI::Context.active_session,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {order_id: order_id},
          params: {limit: limit, fields: fields, in_shop_currency: in_shop_currency}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[Refund])
      end

    end

    sig do
      params(
        shipping: T.untyped,
        refund_line_items: T.untyped,
        currency: T.untyped,
        body: T.untyped,
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
        ids: {order_id: @order_id},
        params: {shipping: shipping, refund_line_items: refund_line_items, currency: currency}.merge(kwargs).compact,
        body: body,
        entity: self,
      )
    end

  end
end
