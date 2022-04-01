# typed: false
# frozen_string_literal: true

module ShopifyAPI
  class Payout < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: ShopifyAPI::Context.active_session)
      super(session: session)

      @amount = T.let(nil, T.nilable(String))
      @currency = T.let(nil, T.nilable(String))
      @date = T.let(nil, T.nilable(String))
      @id = T.let(nil, T.nilable(Integer))
      @status = T.let(nil, T.nilable(String))
    end

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "shopify_payments/payouts.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "shopify_payments/payouts/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :amount
    sig { returns(T.nilable(String)) }
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
          id: T.any(Integer, String),
          session: Auth::Session
        ).returns(T.nilable(Payout))
      end
      def find(
        id:,
        session: ShopifyAPI::Context.active_session
      )
        result = base_find(
          session: session,
          ids: {id: id},
          params: {},
        )
        T.cast(result[0], T.nilable(Payout))
      end

      sig do
        params(
          since_id: T.untyped,
          last_id: T.untyped,
          date_min: T.untyped,
          date_max: T.untyped,
          date: T.untyped,
          status: T.untyped,
          session: Auth::Session,
          kwargs: T.untyped
        ).returns(T::Array[Payout])
      end
      def all(
        since_id: nil,
        last_id: nil,
        date_min: nil,
        date_max: nil,
        date: nil,
        status: nil,
        session: ShopifyAPI::Context.active_session,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {since_id: since_id, last_id: last_id, date_min: date_min, date_max: date_max, date: date, status: status}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[Payout])
      end

    end

  end
end
