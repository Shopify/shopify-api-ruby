# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class ShippingZone < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({
      countries: Country,
      provinces: Province
    }, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "shipping_zones.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(T.untyped)) }
    attr_reader :carrier_shipping_rate_providers
    sig { returns(T.nilable(T::Array[Country])) }
    attr_reader :countries
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(Integer)) }
    attr_reader :location_group_id
    sig { returns(T.nilable(String)) }
    attr_reader :name
    sig { returns(T.nilable(Hash)) }
    attr_reader :price_based_shipping_rates
    sig { returns(T.nilable(Integer)) }
    attr_reader :profile_id
    sig { returns(T.nilable(T::Array[Province])) }
    attr_reader :provinces
    sig { returns(T.nilable(Hash)) }
    attr_reader :weight_based_shipping_rates

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
        ).returns(T::Array[ShippingZone])
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
        T.cast(result, T::Array[ShippingZone])
      end

    end

  end
end
