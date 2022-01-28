# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class AbandonedCheckout < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({
      currency: Currency,
      customer: Customer
    }, T::Hash[Symbol, Class])
    @has_many = T.let({
      discount_codes: DiscountCode
    }, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :count, ids: [], path: "checkouts/count.json"},
      {http_method: :get, operation: :checkouts, ids: [], path: "checkouts.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :abandoned_checkout_url
    sig { returns(T.nilable(Hash)) }
    attr_reader :billing_address
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :buyer_accepts_marketing
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :buyer_accepts_sms_marketing
    sig { returns(T.nilable(String)) }
    attr_reader :cart_token
    sig { returns(T.nilable(String)) }
    attr_reader :closed_at
    sig { returns(T.nilable(String)) }
    attr_reader :completed_at
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(Currency)) }
    attr_reader :currency
    sig { returns(T.nilable(Customer)) }
    attr_reader :customer
    sig { returns(T.nilable(String)) }
    attr_reader :customer_locale
    sig { returns(T.nilable(Integer)) }
    attr_reader :device_id
    sig { returns(T.nilable(T::Array[DiscountCode])) }
    attr_reader :discount_codes
    sig { returns(T.nilable(String)) }
    attr_reader :email
    sig { returns(T.nilable(String)) }
    attr_reader :gateway
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :landing_site
    sig { returns(T.nilable(Hash)) }
    attr_reader :line_items
    sig { returns(T.nilable(Integer)) }
    attr_reader :location_id
    sig { returns(T.nilable(String)) }
    attr_reader :note
    sig { returns(T.nilable(String)) }
    attr_reader :phone
    sig { returns(T.nilable(String)) }
    attr_reader :presentment_currency
    sig { returns(T.nilable(String)) }
    attr_reader :referring_site
    sig { returns(T.nilable(Hash)) }
    attr_reader :shipping_address
    sig { returns(T.nilable(Hash)) }
    attr_reader :shipping_lines
    sig { returns(T.nilable(String)) }
    attr_reader :sms_marketing_phone
    sig { returns(T.nilable(String)) }
    attr_reader :source_name
    sig { returns(T.nilable(String)) }
    attr_reader :subtotal_price
    sig { returns(T.nilable(Hash)) }
    attr_reader :tax_lines
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :taxes_included
    sig { returns(T.nilable(String)) }
    attr_reader :token
    sig { returns(T.nilable(String)) }
    attr_reader :total_discounts
    sig { returns(T.nilable(String)) }
    attr_reader :total_duties
    sig { returns(T.nilable(String)) }
    attr_reader :total_line_items_price
    sig { returns(T.nilable(String)) }
    attr_reader :total_price
    sig { returns(T.nilable(String)) }
    attr_reader :total_tax
    sig { returns(T.nilable(Integer)) }
    attr_reader :total_weight
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :user_id

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
          kwargs: T.untyped
        ).returns(T::Array[AbandonedCheckout])
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
        T.cast(result, T::Array[AbandonedCheckout])
      end

      sig do
        params(
          session: Auth::Session,
          since_id: T.untyped,
          created_at_min: T.untyped,
          created_at_max: T.untyped,
          updated_at_min: T.untyped,
          updated_at_max: T.untyped,
          status: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        since_id: nil,
        created_at_min: nil,
        created_at_max: nil,
        updated_at_min: nil,
        updated_at_max: nil,
        status: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          path_ids: {},
          params: {since_id: since_id, created_at_min: created_at_min, created_at_max: created_at_max, updated_at_min: updated_at_min, updated_at_max: updated_at_max, status: status}.merge(kwargs).compact,
          entity: nil,
        )
      end

      sig do
        params(
          session: Auth::Session,
          limit: T.untyped,
          since_id: T.untyped,
          created_at_min: T.untyped,
          created_at_max: T.untyped,
          updated_at_min: T.untyped,
          updated_at_max: T.untyped,
          status: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def checkouts(
        session:,
        limit: nil,
        since_id: nil,
        created_at_min: nil,
        created_at_max: nil,
        updated_at_min: nil,
        updated_at_max: nil,
        status: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :checkouts,
          session: session,
          path_ids: {},
          params: {limit: limit, since_id: since_id, created_at_min: created_at_min, created_at_max: created_at_max, updated_at_min: updated_at_min, updated_at_max: updated_at_max, status: status}.merge(kwargs).compact,
          entity: nil,
        )
      end

    end

  end
end
