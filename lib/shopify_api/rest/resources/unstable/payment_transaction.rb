# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class PaymentTransaction < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({
      currency: Currency
    }, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :transactions, ids: [], path: "shopify_payments/balance/transactions.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :amount
    sig { returns(T.nilable(Currency)) }
    attr_reader :currency
    sig { returns(T.nilable(String)) }
    attr_reader :fee
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :net
    sig { returns(T.nilable(Integer)) }
    attr_reader :payout_id
    sig { returns(T.nilable(String)) }
    attr_reader :payout_status
    sig { returns(T.nilable(String)) }
    attr_reader :processed_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :source_id
    sig { returns(T.nilable(Integer)) }
    attr_reader :source_order_id
    sig { returns(T.nilable(Integer)) }
    attr_reader :source_order_transaction_id
    sig { returns(T.nilable(String)) }
    attr_reader :source_type
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :test
    sig { returns(T.nilable(String)) }
    attr_reader :type

    class << self
      sig do
        params(
          session: Auth::Session,
          since_id: T.untyped,
          last_id: T.untyped,
          test: T.untyped,
          payout_id: T.untyped,
          payout_status: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def transactions(
        session:,
        since_id: nil,
        last_id: nil,
        test: nil,
        payout_id: nil,
        payout_status: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :transactions,
          session: session,
          ids: {},
          params: {since_id: since_id, last_id: last_id, test: test, payout_id: payout_id, payout_status: payout_status}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

    end

  end
end
