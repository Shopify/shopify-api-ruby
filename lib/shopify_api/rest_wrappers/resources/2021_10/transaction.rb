# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Transaction < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "shopify_payments/balance/transactions.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :amount
    sig { returns(T.nilable(String)) }
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
          since_id: T.untyped,
          last_id: T.untyped,
          test: T.untyped,
          payout_id: T.untyped,
          payout_status: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[Transaction])
      end
      def all(
        session:,
        since_id: nil,
        last_id: nil,
        test: nil,
        payout_id: nil,
        payout_status: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {since_id: since_id, last_id: last_id, test: test, payout_id: payout_id, payout_status: payout_status}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[Transaction])
      end

    end

  end
end
