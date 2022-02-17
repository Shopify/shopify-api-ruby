# typed: false
# frozen_string_literal: true

module ShopifyAPI
  class OrderRisk < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: nil)
      super(session: session)

      @cause_cancel = T.let(nil, T.nilable(T::Boolean))
      @checkout_id = T.let(nil, T.nilable(Integer))
      @display = T.let(nil, T.nilable(T::Boolean))
      @id = T.let(nil, T.nilable(Integer))
      @merchant_message = T.let(nil, T.nilable(String))
      @message = T.let(nil, T.nilable(String))
      @order_id = T.let(nil, T.nilable(Integer))
      @recommendation = T.let(nil, T.nilable(String))
      @score = T.let(nil, T.nilable(Float))
      @source = T.let(nil, T.nilable(String))
    end

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :post, operation: :post, ids: [:order_id], path: "orders/<order_id>/risks.json"},
      {http_method: :get, operation: :get, ids: [:order_id], path: "orders/<order_id>/risks.json"},
      {http_method: :get, operation: :get, ids: [:order_id, :id], path: "orders/<order_id>/risks/<id>.json"},
      {http_method: :put, operation: :put, ids: [:order_id, :id], path: "orders/<order_id>/risks/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:order_id, :id], path: "orders/<order_id>/risks/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :cause_cancel
    sig { returns(T.nilable(Integer)) }
    attr_reader :checkout_id
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :display
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :merchant_message
    sig { returns(T.nilable(String)) }
    attr_reader :message
    sig { returns(T.nilable(Integer)) }
    attr_reader :order_id
    sig { returns(T.nilable(String)) }
    attr_reader :recommendation
    sig { returns(T.nilable(Float)) }
    attr_reader :score
    sig { returns(T.nilable(String)) }
    attr_reader :source

    class << self
      sig do
        returns(String)
      end
      def json_body_name()
        "risk"
      end

      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          order_id: T.nilable(T.any(Integer, String))
        ).returns(T.nilable(OrderRisk))
      end
      def find(
        session:,
        id:,
        order_id: nil
      )
        result = base_find(
          session: session,
          ids: {id: id, order_id: order_id},
          params: {},
        )
        T.cast(result[0], T.nilable(OrderRisk))
      end

      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          order_id: T.nilable(T.any(Integer, String))
        ).returns(T.untyped)
      end
      def delete(
        session:,
        id:,
        order_id: nil
      )
        request(
          http_method: :delete,
          operation: :delete,
          session: session,
          ids: {id: id, order_id: order_id},
          params: {},
        )
      end

      sig do
        params(
          session: Auth::Session,
          order_id: T.nilable(T.any(Integer, String)),
          kwargs: T.untyped
        ).returns(T::Array[OrderRisk])
      end
      def all(
        session:,
        order_id: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {order_id: order_id},
          params: {}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[OrderRisk])
      end

    end

  end
end
