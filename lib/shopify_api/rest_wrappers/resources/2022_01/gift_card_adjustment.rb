# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class GiftCardAdjustment < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [:gift_card_id], path: "gift_cards/<gift_card_id>/adjustments.json"},
      {http_method: :post, operation: :post, ids: [:gift_card_id], path: "gift_cards/<gift_card_id>/adjustments.json"},
      {http_method: :get, operation: :get, ids: [:gift_card_id, :id], path: "gift_cards/<gift_card_id>/adjustments/3.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(Float)) }
    attr_reader :amount
    sig { returns(T.nilable(Integer)) }
    attr_reader :api_client_id
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :gift_card_id
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :note
    sig { returns(T.nilable(Integer)) }
    attr_reader :number
    sig { returns(T.nilable(Integer)) }
    attr_reader :order_transaction_id
    sig { returns(T.nilable(String)) }
    attr_reader :processed_at
    sig { returns(T.nilable(String)) }
    attr_reader :remote_transaction_ref
    sig { returns(T.nilable(String)) }
    attr_reader :remote_transaction_url
    sig { returns(T.nilable(Integer)) }
    attr_reader :user_id

    class << self
      sig do
        returns(String)
      end
      def json_body_name()
        "adjustment"
      end

      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          gift_card_id: T.nilable(T.any(Integer, String))
        ).returns(T.nilable(GiftCardAdjustment))
      end
      def find(
        session:,
        id:,
        gift_card_id: nil
      )
        result = base_find(
          ids: {gift_card_id: gift_card_id, id: id},
          params: {},
          session: session,
        )
        T.cast(result[0], T.nilable(GiftCardAdjustment))
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
          gift_card_id: T.nilable(T.any(Integer, String)),
          kwargs: T.untyped
        ).returns(T::Array[GiftCardAdjustment])
      end
      def all(
        session:,
        gift_card_id: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {gift_card_id: gift_card_id},
          params: {}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[GiftCardAdjustment])
      end

    end

  end
end
