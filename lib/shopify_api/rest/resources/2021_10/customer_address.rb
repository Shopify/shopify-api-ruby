# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class CustomerAddress < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [:customer_id], path: "customers/<customer_id>/addresses.json"},
      {http_method: :post, operation: :post, ids: [:customer_id], path: "customers/<customer_id>/addresses.json"},
      {http_method: :get, operation: :get, ids: [:customer_id, :id], path: "customers/<customer_id>/addresses/<id>.json"},
      {http_method: :put, operation: :put, ids: [:customer_id, :id], path: "customers/<customer_id>/addresses/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:customer_id, :id], path: "customers/<customer_id>/addresses/<id>.json"},
      {http_method: :put, operation: :set, ids: [:customer_id], path: "customers/<customer_id>/addresses/set.json"},
      {http_method: :put, operation: :default, ids: [:customer_id, :id], path: "customers/<customer_id>/addresses/<id>/default.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :address1
    sig { returns(T.nilable(String)) }
    attr_reader :address2
    sig { returns(T.nilable(String)) }
    attr_reader :city
    sig { returns(T.nilable(String)) }
    attr_reader :company
    sig { returns(T.nilable(String)) }
    attr_reader :country
    sig { returns(T.nilable(String)) }
    attr_reader :country_code
    sig { returns(T.nilable(String)) }
    attr_reader :country_name
    sig { returns(T.nilable(Integer)) }
    attr_reader :customer_id
    sig { returns(T.nilable(String)) }
    attr_reader :first_name
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :last_name
    sig { returns(T.nilable(String)) }
    attr_reader :name
    sig { returns(T.nilable(String)) }
    attr_reader :phone
    sig { returns(T.nilable(String)) }
    attr_reader :province
    sig { returns(T.nilable(String)) }
    attr_reader :province_code
    sig { returns(T.nilable(String)) }
    attr_reader :zip

    class << self
      sig do
        returns(String)
      end
      def json_body_name()
        "address"
      end

      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          customer_id: T.nilable(T.any(Integer, String))
        ).returns(T.nilable(CustomerAddress))
      end
      def find(
        session:,
        id:,
        customer_id: nil
      )
        result = base_find(
          session: session,
          ids: {id: id, customer_id: customer_id},
          params: {},
        )
        T.cast(result[0], T.nilable(CustomerAddress))
      end

      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          customer_id: T.nilable(T.any(Integer, String))
        ).returns(T.untyped)
      end
      def delete(
        session:,
        id:,
        customer_id: nil
      )
        request(
          http_method: :delete,
          operation: :delete,
          session: session,
          ids: {id: id, customer_id: customer_id},
          params: {},
        )
      end

      sig do
        params(
          session: Auth::Session,
          customer_id: T.nilable(T.any(Integer, String)),
          kwargs: T.untyped
        ).returns(T::Array[CustomerAddress])
      end
      def all(
        session:,
        customer_id: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {customer_id: customer_id},
          params: {}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[CustomerAddress])
      end

    end

    sig do
      params(
        address_ids: T.nilable(T.any(Array, Integer, String)),
        operation: T.untyped,
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def set(
      address_ids: nil,
      operation: nil,
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :put,
        operation: :set,
        session: @session,
        ids: {customer_id: @customer_id},
        params: {address_ids: address_ids, operation: operation}.merge(kwargs).compact,
        body: body,
        entity: self,
      )
    end

    sig do
      params(
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def default(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :put,
        operation: :default,
        session: @session,
        ids: {id: @id, customer_id: @customer_id},
        params: {}.merge(kwargs).compact,
        body: body,
        entity: self,
      )
    end

  end
end
