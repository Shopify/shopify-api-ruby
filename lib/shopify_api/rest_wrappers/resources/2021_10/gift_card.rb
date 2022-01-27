# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class GiftCard < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({
      balance: Balance,
      currency: Currency
    }, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "gift_cards.json"},
      {http_method: :post, operation: :post, ids: [], path: "gift_cards.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "gift_cards/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "gift_cards/<id>.json"},
      {http_method: :get, operation: :count, ids: [], path: "gift_cards/count.json"},
      {http_method: :post, operation: :disable, ids: [:id], path: "gift_cards/<id>/disable.json"},
      {http_method: :get, operation: :search, ids: [], path: "gift_cards/search.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(Integer)) }
    attr_reader :api_client_id
    sig { returns(T.nilable(Balance)) }
    attr_reader :balance
    sig { returns(T.nilable(String)) }
    attr_reader :code
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(Currency)) }
    attr_reader :currency
    sig { returns(T.nilable(Integer)) }
    attr_reader :customer_id
    sig { returns(T.nilable(String)) }
    attr_reader :disabled_at
    sig { returns(T.nilable(String)) }
    attr_reader :expires_on
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(Float)) }
    attr_reader :initial_value
    sig { returns(T.nilable(String)) }
    attr_reader :last_characters
    sig { returns(T.nilable(Integer)) }
    attr_reader :line_item_id
    sig { returns(T.nilable(String)) }
    attr_reader :note
    sig { returns(T.nilable(Integer)) }
    attr_reader :order_id
    sig { returns(T.nilable(String)) }
    attr_reader :template_suffix
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :user_id

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String)
        ).returns(T.nilable(GiftCard))
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
        T.cast(result[0], T.nilable(GiftCard))
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
          status: T.untyped,
          limit: T.untyped,
          since_id: T.untyped,
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[GiftCard])
      end
      def all(
        session:,
        status: nil,
        limit: nil,
        since_id: nil,
        fields: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {status: status, limit: limit, since_id: since_id, fields: fields}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[GiftCard])
      end

      sig do
        params(
          session: Auth::Session,
          status: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        status: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          path_ids: {},
          params: {status: status}.merge(kwargs).compact,
          entity: nil,
        )
      end

      sig do
        params(
          session: Auth::Session,
          order: T.untyped,
          query: T.untyped,
          limit: T.untyped,
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def search(
        session:,
        order: nil,
        query: nil,
        limit: nil,
        fields: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :search,
          session: session,
          path_ids: {},
          params: {order: order, query: query, limit: limit, fields: fields}.merge(kwargs).compact,
          entity: nil,
        )
      end

    end

    sig do
      params(
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def disable(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :disable,
        session: @session,
        path_ids: {id: @id},
        params: {}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

  end
end
