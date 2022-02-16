# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Variant < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [:product_id], path: "products/<product_id>/variants.json"},
      {http_method: :get, operation: :count, ids: [:product_id], path: "products/<product_id>/variants/count.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "variants/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "variants/<id>.json"},
      {http_method: :post, operation: :post, ids: [:product_id], path: "products/<product_id>/variants.json"},
      {http_method: :delete, operation: :delete, ids: [:product_id, :id], path: "products/<product_id>/variants/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :barcode
    sig { returns(T.nilable(String)) }
    attr_reader :compare_at_price
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(String)) }
    attr_reader :fulfillment_service
    sig { returns(T.nilable(Integer)) }
    attr_reader :grams
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(Integer)) }
    attr_reader :image_id
    sig { returns(T.nilable(Integer)) }
    attr_reader :inventory_item_id
    sig { returns(T.nilable(String)) }
    attr_reader :inventory_management
    sig { returns(T.nilable(String)) }
    attr_reader :inventory_policy
    sig { returns(T.nilable(Integer)) }
    attr_reader :inventory_quantity
    sig { returns(T.nilable(Integer)) }
    attr_reader :inventory_quantity_adjustment
    sig { returns(T.nilable(Integer)) }
    attr_reader :old_inventory_quantity
    sig { returns(T.nilable(Hash)) }
    attr_reader :option
    sig { returns(T.nilable(Integer)) }
    attr_reader :position
    sig { returns(T.nilable(T::Array[Hash])) }
    attr_reader :presentment_prices
    sig { returns(T.nilable(String)) }
    attr_reader :price
    sig { returns(T.nilable(Integer)) }
    attr_reader :product_id
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :requires_shipping
    sig { returns(T.nilable(String)) }
    attr_reader :sku
    sig { returns(T.nilable(String)) }
    attr_reader :tax_code
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :taxable
    sig { returns(T.nilable(String)) }
    attr_reader :title
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :weight
    sig { returns(T.nilable(String)) }
    attr_reader :weight_unit

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          fields: T.untyped
        ).returns(T.nilable(Variant))
      end
      def find(
        session:,
        id:,
        fields: nil
      )
        result = base_find(
          session: session,
          ids: {id: id},
          params: {fields: fields},
        )
        T.cast(result[0], T.nilable(Variant))
      end

      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          product_id: T.nilable(T.any(Integer, String))
        ).returns(T.untyped)
      end
      def delete(
        session:,
        id:,
        product_id: nil
      )
        request(
          http_method: :delete,
          operation: :delete,
          session: session,
          ids: {id: id, product_id: product_id},
          params: {},
        )
      end

      sig do
        params(
          session: Auth::Session,
          product_id: T.nilable(T.any(Integer, String)),
          limit: T.untyped,
          presentment_currencies: T.untyped,
          since_id: T.untyped,
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[Variant])
      end
      def all(
        session:,
        product_id: nil,
        limit: nil,
        presentment_currencies: nil,
        since_id: nil,
        fields: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {product_id: product_id},
          params: {limit: limit, presentment_currencies: presentment_currencies, since_id: since_id, fields: fields}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[Variant])
      end

      sig do
        params(
          session: Auth::Session,
          product_id: T.nilable(T.any(Integer, String)),
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        product_id: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          ids: {product_id: product_id},
          params: {}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

    end

  end
end
