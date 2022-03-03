# typed: false
# frozen_string_literal: true

module ShopifyAPI
  class ShippingZone < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: nil)
      super(session: session)

      @carrier_shipping_rate_providers = T.let(nil, T.untyped)
      @countries = T.let(nil, T.nilable(T::Array[T.untyped]))
      @id = T.let(nil, T.nilable(Integer))
      @location_group_id = T.let(nil, T.nilable(Integer))
      @name = T.let(nil, T.nilable(String))
      @price_based_shipping_rates = T.let(nil, T.nilable(T::Hash[T.untyped, T.untyped]))
      @profile_id = T.let(nil, T.nilable(Integer))
      @provinces = T.let(nil, T.nilable(T::Array[T.untyped]))
      @weight_based_shipping_rates = T.let(nil, T.nilable(T::Hash[T.untyped, T.untyped]))
    end

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({
      countries: Country,
      provinces: Province
    }, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "shipping_zones.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.untyped) }
    attr_reader :carrier_shipping_rate_providers
    sig { returns(T.nilable(T::Array[Country])) }
    attr_reader :countries
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(Integer)) }
    attr_reader :location_group_id
    sig { returns(T.nilable(String)) }
    attr_reader :name
    sig { returns(T.nilable(T::Hash[T.untyped, T.untyped])) }
    attr_reader :price_based_shipping_rates
    sig { returns(T.nilable(Integer)) }
    attr_reader :profile_id
    sig { returns(T.nilable(T::Array[Province])) }
    attr_reader :provinces
    sig { returns(T.nilable(T::Hash[T.untyped, T.untyped])) }
    attr_reader :weight_based_shipping_rates

    class << self
      sig do
        params(
          session: Auth::Session,
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[ShippingZone])
      end
      def all(
        session:,
        fields: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {fields: fields}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[ShippingZone])
      end

    end

  end
end
