# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Payout < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({
      currency: Currency
    }, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "shopify_payments/payouts.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "shopify_payments/payouts/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :amount
    sig { returns(T.nilable(Currency)) }
    attr_reader :currency
    sig { returns(T.nilable(String)) }
    attr_reader :date
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :status

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String)
        ).returns(T.nilable(Payout))
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
        T.cast(result[0], T.nilable(Payout))
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
          since_id: T.untyped,
          last_id: T.untyped,
          date_min: T.untyped,
          date_max: T.untyped,
          date: T.untyped,
          status: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[Payout])
      end
      def all(
        session:,
        since_id: nil,
        last_id: nil,
        date_min: nil,
        date_max: nil,
        date: nil,
        status: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {since_id: since_id, last_id: last_id, date_min: date_min, date_max: date_max, date: date, status: status}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[Payout])
      end

    end

  end
end
