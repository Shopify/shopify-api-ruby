# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Image < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [:product_id], path: "products/<product_id>/images.json"},
      {http_method: :post, operation: :post, ids: [:product_id], path: "products/<product_id>/images.json"},
      {http_method: :get, operation: :count, ids: [:product_id], path: "products/<product_id>/images/count.json"},
      {http_method: :get, operation: :get, ids: [:product_id, :id], path: "products/<product_id>/images/<id>.json"},
      {http_method: :put, operation: :put, ids: [:product_id, :id], path: "products/<product_id>/images/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:product_id, :id], path: "products/<product_id>/images/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :height
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(Integer)) }
    attr_reader :position
    sig { returns(T.nilable(Integer)) }
    attr_reader :product_id
    sig { returns(T.nilable(String)) }
    attr_reader :src
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at
    sig { returns(T.nilable(T::Array[Integer])) }
    attr_reader :variant_ids
    sig { returns(T.nilable(Integer)) }
    attr_reader :width

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          product_id: T.nilable(T.any(Integer, String)),
          fields: T.untyped
        ).returns(T.nilable(Image))
      end
      def find(
        session:,
        id:,
        product_id: nil,
        fields: nil
      )
        result = base_find(
          session: session,
          ids: {id: id, product_id: product_id},
          params: {fields: fields},
        )
        T.cast(result[0], T.nilable(Image))
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
          since_id: T.untyped,
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[Image])
      end
      def all(
        session:,
        product_id: nil,
        since_id: nil,
        fields: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {product_id: product_id},
          params: {since_id: since_id, fields: fields}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[Image])
      end

      sig do
        params(
          session: Auth::Session,
          product_id: T.nilable(T.any(Integer, String)),
          since_id: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        product_id: nil,
        since_id: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          ids: {product_id: product_id},
          params: {since_id: since_id}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

    end

  end
end
