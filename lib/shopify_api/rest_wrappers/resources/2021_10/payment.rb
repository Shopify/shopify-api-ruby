# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Payment < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({
      transaction: Transaction,
      checkout: Checkout
    }, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :post, operation: :post, ids: [:checkout_id], path: "checkouts/<checkout_id>/payments.json"},
      {http_method: :get, operation: :get, ids: [:checkout_id], path: "checkouts/<checkout_id>/payments.json"},
      {http_method: :get, operation: :get, ids: [:checkout_id, :id], path: "checkouts/<checkout_id>/payments/<id>.json"},
      {http_method: :get, operation: :count, ids: [:checkout_id], path: "checkouts/<checkout_id>/payments/count.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(Checkout)) }
    attr_reader :checkout
    sig { returns(T.nilable(Hash)) }
    attr_reader :credit_card
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(Hash)) }
    attr_reader :next_action
    sig { returns(T.nilable(String)) }
    attr_reader :payment_processing_error_message
    sig { returns(T.nilable(Transaction)) }
    attr_reader :transaction
    sig { returns(T.nilable(String)) }
    attr_reader :unique_token

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          checkout_id: T.nilable(T.any(Integer, String))
        ).returns(T.nilable(Payment))
      end
      def find(
        session:,
        id:,
        checkout_id: nil
      )
        result = base_find(
          ids: {checkout_id: checkout_id, id: id},
          params: {},
          session: session,
        )
        T.cast(result[0], T.nilable(Payment))
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
          checkout_id: T.nilable(T.any(Integer, String)),
          kwargs: T.untyped
        ).returns(T::Array[Payment])
      end
      def all(
        session:,
        checkout_id: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {checkout_id: checkout_id},
          params: {}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[Payment])
      end

      sig do
        params(
          session: Auth::Session,
          checkout_id: T.nilable(T.any(Integer, String)),
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        checkout_id: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          path_ids: {checkout_id: checkout_id},
          params: {}.merge(kwargs).compact,
          entity: nil,
        )
      end

    end

    sig do
      returns(T.untyped)
    end
    def checkout_id()
      @checkout&.token
    end

    sig do
      params(
        val: T.untyped
      ).void
    end
    def checkout_id=(val)
      @checkout = @checkout || Checkout.new(session: @session)
      @checkout.token = val
    end

  end
end
