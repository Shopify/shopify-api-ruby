# typed: false
# frozen_string_literal: true

module ShopifyAPI
  class DiscountCode < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: nil)
      super(session: session)

      @code = T.let(nil, T.nilable(String))
      @created_at = T.let(nil, T.nilable(String))
      @id = T.let(nil, T.nilable(Integer))
      @price_rule_id = T.let(nil, T.nilable(Integer))
      @updated_at = T.let(nil, T.nilable(String))
      @usage_count = T.let(nil, T.nilable(Integer))
    end

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :post, operation: :post, ids: [:price_rule_id], path: "price_rules/<price_rule_id>/discount_codes.json"},
      {http_method: :get, operation: :get, ids: [:price_rule_id], path: "price_rules/<price_rule_id>/discount_codes.json"},
      {http_method: :put, operation: :put, ids: [:price_rule_id, :id], path: "price_rules/<price_rule_id>/discount_codes/<id>.json"},
      {http_method: :get, operation: :get, ids: [:price_rule_id, :id], path: "price_rules/<price_rule_id>/discount_codes/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:price_rule_id, :id], path: "price_rules/<price_rule_id>/discount_codes/<id>.json"},
      {http_method: :get, operation: :lookup, ids: [], path: "discount_codes/lookup.json"},
      {http_method: :get, operation: :count, ids: [], path: "discount_codes/count.json"},
      {http_method: :post, operation: :batch, ids: [:price_rule_id], path: "price_rules/<price_rule_id>/batch.json"},
      {http_method: :get, operation: :get_all, ids: [:price_rule_id, :batch_id], path: "price_rules/<price_rule_id>/batch/<batch_id>.json"},
      {http_method: :get, operation: :get, ids: [:price_rule_id, :batch_id], path: "price_rules/<price_rule_id>/batch/<batch_id>/discount_codes.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :code
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(Integer)) }
    attr_reader :price_rule_id
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :usage_count

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          price_rule_id: T.nilable(T.any(Integer, String))
        ).returns(T.nilable(DiscountCode))
      end
      def find(
        session:,
        id:,
        price_rule_id: nil
      )
        result = base_find(
          session: session,
          ids: {id: id, price_rule_id: price_rule_id},
          params: {},
        )
        T.cast(result[0], T.nilable(DiscountCode))
      end

      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          price_rule_id: T.nilable(T.any(Integer, String))
        ).returns(T.untyped)
      end
      def delete(
        session:,
        id:,
        price_rule_id: nil
      )
        request(
          http_method: :delete,
          operation: :delete,
          session: session,
          ids: {id: id, price_rule_id: price_rule_id},
          params: {},
        )
      end

      sig do
        params(
          session: Auth::Session,
          price_rule_id: T.nilable(T.any(Integer, String)),
          batch_id: T.nilable(T.any(Integer, String)),
          kwargs: T.untyped
        ).returns(T::Array[DiscountCode])
      end
      def all(
        session:,
        price_rule_id: nil,
        batch_id: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {price_rule_id: price_rule_id, batch_id: batch_id},
          params: {}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[DiscountCode])
      end

      sig do
        params(
          session: Auth::Session,
          code: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def lookup(
        session:,
        code: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :lookup,
          session: session,
          ids: {},
          params: {code: code}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

      sig do
        params(
          session: Auth::Session,
          times_used: T.untyped,
          times_used_min: T.untyped,
          times_used_max: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        times_used: nil,
        times_used_min: nil,
        times_used_max: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          ids: {},
          params: {times_used: times_used, times_used_min: times_used_min, times_used_max: times_used_max}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

      sig do
        params(
          session: Auth::Session,
          price_rule_id: T.nilable(T.any(Integer, String)),
          batch_id: T.nilable(T.any(Integer, String)),
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def get_all(
        session:,
        price_rule_id: nil,
        batch_id: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :get_all,
          session: session,
          ids: {price_rule_id: price_rule_id, batch_id: batch_id},
          params: {}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

    end

    sig do
      params(
        body: T.untyped,
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def batch(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :batch,
        session: @session,
        ids: {price_rule_id: @price_rule_id},
        params: {}.merge(kwargs).compact,
        body: body,
        entity: self,
      )
    end

  end
end
