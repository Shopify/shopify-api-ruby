# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Province < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [:country_id], path: "countries/<country_id>/provinces.json"},
      {http_method: :get, operation: :count, ids: [:country_id], path: "countries/<country_id>/provinces/count.json"},
      {http_method: :get, operation: :get, ids: [:country_id, :id], path: "countries/<country_id>/provinces/<id>.json"},
      {http_method: :put, operation: :put, ids: [:country_id, :id], path: "countries/<country_id>/provinces/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :code
    sig { returns(T.nilable(Integer)) }
    attr_reader :country_id
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :name
    sig { returns(T.nilable(Integer)) }
    attr_reader :shipping_zone_id
    sig { returns(T.nilable(Float)) }
    attr_reader :tax
    sig { returns(T.nilable(String)) }
    attr_reader :tax_name
    sig { returns(T.nilable(Float)) }
    attr_reader :tax_percentage
    sig { returns(T.nilable(String)) }
    attr_reader :tax_type

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          country_id: T.nilable(T.any(Integer, String)),
          fields: T.untyped
        ).returns(T.nilable(Province))
      end
      def find(
        session:,
        id:,
        country_id: nil,
        fields: nil
      )
        result = base_find(
          ids: {country_id: country_id, id: id},
          params: {fields: fields},
          session: session,
        )
        T.cast(result[0], T.nilable(Province))
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
          country_id: T.nilable(T.any(Integer, String)),
          since_id: T.untyped,
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[Province])
      end
      def all(
        session:,
        country_id: nil,
        since_id: nil,
        fields: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {country_id: country_id},
          params: {since_id: since_id, fields: fields}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[Province])
      end

      sig do
        params(
          session: Auth::Session,
          country_id: T.nilable(T.any(Integer, String)),
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        country_id: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          path_ids: {country_id: country_id},
          params: {}.merge(kwargs).compact,
          entity: nil,
        )
      end

    end

  end
end
