# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class TenderTransaction < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({
      currency: Currency
    }, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "tender_transactions.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :amount
    sig { returns(T.nilable(Currency)) }
    attr_reader :currency
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(Integer)) }
    attr_reader :order_id
    sig { returns(T.nilable(Hash)) }
    attr_reader :payment_details
    sig { returns(T.nilable(String)) }
    attr_reader :payment_method
    sig { returns(T.nilable(String)) }
    attr_reader :processed_at
    sig { returns(T.nilable(String)) }
    attr_reader :remote_reference
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :test
    sig { returns(T.nilable(Integer)) }
    attr_reader :user_id

    class << self
      sig do
        params(
          session: Auth::Session,
          limit: T.untyped,
          since_id: T.untyped,
          processed_at_min: T.untyped,
          processed_at_max: T.untyped,
          processed_at: T.untyped,
          order: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[TenderTransaction])
      end
      def all(
        session:,
        limit: nil,
        since_id: nil,
        processed_at_min: nil,
        processed_at_max: nil,
        processed_at: nil,
        order: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {limit: limit, since_id: since_id, processed_at_min: processed_at_min, processed_at_max: processed_at_max, processed_at: processed_at, order: order}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[TenderTransaction])
      end

    end

  end
end
