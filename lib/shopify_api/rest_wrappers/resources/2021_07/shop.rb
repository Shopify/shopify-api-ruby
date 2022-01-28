# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Shop < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({
      country: Country,
      currency: Currency,
      province: Province
    }, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "shop.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :address1
    sig { returns(T.nilable(String)) }
    attr_reader :address2
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :checkout_api_supported
    sig { returns(T.nilable(String)) }
    attr_reader :city
    sig { returns(T.nilable(String)) }
    attr_reader :cookie_consent_level
    sig { returns(T.nilable(Country)) }
    attr_reader :country
    sig { returns(T.nilable(String)) }
    attr_reader :country_code
    sig { returns(T.nilable(String)) }
    attr_reader :country_name
    sig { returns(T.nilable(String)) }
    attr_reader :county_taxes
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(Currency)) }
    attr_reader :currency
    sig { returns(T.nilable(String)) }
    attr_reader :customer_email
    sig { returns(T.nilable(String)) }
    attr_reader :domain
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :eligible_for_card_reader_giveaway
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :eligible_for_payments
    sig { returns(T.nilable(String)) }
    attr_reader :email
    sig { returns(T.nilable(T::Array[String])) }
    attr_reader :enabled_presentment_currencies
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :finances
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :force_ssl
    sig { returns(T.nilable(String)) }
    attr_reader :google_apps_domain
    sig { returns(T.nilable(String)) }
    attr_reader :google_apps_login_enabled
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :has_discounts
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :has_gift_cards
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :has_storefront
    sig { returns(T.nilable(String)) }
    attr_reader :iana_timezone
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(Float)) }
    attr_reader :latitude
    sig { returns(T.nilable(Float)) }
    attr_reader :longitude
    sig { returns(T.nilable(String)) }
    attr_reader :money_format
    sig { returns(T.nilable(String)) }
    attr_reader :money_in_emails_format
    sig { returns(T.nilable(String)) }
    attr_reader :money_with_currency_format
    sig { returns(T.nilable(String)) }
    attr_reader :money_with_currency_in_emails_format
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :multi_location_enabled
    sig { returns(T.nilable(String)) }
    attr_reader :myshopify_domain
    sig { returns(T.nilable(String)) }
    attr_reader :name
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :password_enabled
    sig { returns(T.nilable(String)) }
    attr_reader :phone
    sig { returns(T.nilable(String)) }
    attr_reader :plan_display_name
    sig { returns(T.nilable(String)) }
    attr_reader :plan_name
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :pre_launch_enabled
    sig { returns(T.nilable(String)) }
    attr_reader :primary_locale
    sig { returns(T.nilable(Integer)) }
    attr_reader :primary_location_id
    sig { returns(T.nilable(Province)) }
    attr_reader :province
    sig { returns(T.nilable(String)) }
    attr_reader :province_code
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :requires_extra_payments_agreement
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :setup_required
    sig { returns(T.nilable(String)) }
    attr_reader :shop_owner
    sig { returns(T.nilable(String)) }
    attr_reader :source
    sig { returns(T.nilable(String)) }
    attr_reader :tax_shipping
    sig { returns(T.nilable(String)) }
    attr_reader :taxes_included
    sig { returns(T.nilable(String)) }
    attr_reader :timezone
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at
    sig { returns(T.nilable(String)) }
    attr_reader :weight_unit
    sig { returns(T.nilable(String)) }
    attr_reader :zip

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
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[Shop])
      end
      def all(
        session:,
        fields: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {fields: fields}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[Shop])
      end

    end

  end
end
