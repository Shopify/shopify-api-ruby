# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Checkout < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({
      currency: Currency,
      discount_code: DiscountCode,
      order: Order
    }, T::Hash[Symbol, Class])
    @has_many = T.let({
      gift_cards: GiftCard
    }, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :post, operation: :post, ids: [], path: "checkouts.json"},
      {http_method: :post, operation: :complete, ids: [:token], path: "checkouts/<token>/complete.json"},
      {http_method: :get, operation: :get, ids: [:token], path: "checkouts/<token>.json"},
      {http_method: :put, operation: :put, ids: [:token], path: "checkouts/<token>.json"},
      {http_method: :get, operation: :shipping_rates, ids: [:token], path: "checkouts/<token>/shipping_rates.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(Hash) }
    attr_reader :billing_address
    sig { returns(T::Array[Hash]) }
    attr_reader :line_items
    sig { returns(T.nilable(Hash)) }
    attr_reader :applied_discount
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :buyer_accepts_marketing
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(Currency)) }
    attr_reader :currency
    sig { returns(T.nilable(Integer)) }
    attr_reader :customer_id
    sig { returns(T.nilable(DiscountCode)) }
    attr_reader :discount_code
    sig { returns(T.nilable(String)) }
    attr_reader :email
    sig { returns(T.nilable(T::Array[GiftCard])) }
    attr_reader :gift_cards
    sig { returns(T.nilable(Order)) }
    attr_reader :order
    sig { returns(T.nilable(String)) }
    attr_reader :payment_due
    sig { returns(T.nilable(String)) }
    attr_reader :payment_url
    sig { returns(T.nilable(String)) }
    attr_reader :phone
    sig { returns(T.nilable(String)) }
    attr_reader :presentment_currency
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :requires_shipping
    sig { returns(T.nilable(String)) }
    attr_reader :reservation_time
    sig { returns(T.nilable(Integer)) }
    attr_reader :reservation_time_left
    sig { returns(T.nilable(Hash)) }
    attr_reader :shipping_address
    sig { returns(T.nilable(Hash)) }
    attr_reader :shipping_line
    sig { returns(T.nilable(Hash)) }
    attr_reader :shipping_rate
    sig { returns(T.nilable(String)) }
    attr_reader :source_name
    sig { returns(T.nilable(String)) }
    attr_reader :subtotal_price
    sig { returns(T.nilable(T::Array[Hash])) }
    attr_reader :tax_lines
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :taxes_included
    sig { returns(T.nilable(String)) }
    attr_reader :token
    sig { returns(T.nilable(String)) }
    attr_reader :total_price
    sig { returns(T.nilable(String)) }
    attr_reader :total_tax
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :user_id
    sig { returns(T.nilable(String)) }
    attr_reader :web_url

    class << self
      sig do
        returns(String)
      end
      def primary_key()
        "token"
      end

      sig do
        params(
          session: Auth::Session,
          token: T.any(Integer, String)
        ).returns(T.nilable(Checkout))
      end
      def find(
        session:,
        token:
      )
        result = base_find(
          ids: {token: token},
          params: {},
          session: session,
        )
        T.cast(result[0], T.nilable(Checkout))
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
          kwargs: T.untyped
        ).returns(T::Array[Checkout])
      end
      def all(
        session:,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[Checkout])
      end

      sig do
        params(
          session: Auth::Session,
          token: T.nilable(T.any(Integer, String)),
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def shipping_rates(
        session:,
        token: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :shipping_rates,
          session: session,
          path_ids: {token: token},
          params: {}.merge(kwargs).compact,
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
    def complete(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :complete,
        session: @session,
        path_ids: {token: @token},
        params: {}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

  end
end
