# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class ProductListing < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({
      images: Image,
      variants: Variant
    }, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "product_listings.json"},
      {http_method: :get, operation: :product_ids, ids: [], path: "product_listings/product_ids.json"},
      {http_method: :get, operation: :count, ids: [], path: "product_listings/count.json"},
      {http_method: :get, operation: :get, ids: [:product_id], path: "product_listings/<product_id>.json"},
      {http_method: :put, operation: :put, ids: [:product_id], path: "product_listings/<product_id>.json"},
      {http_method: :delete, operation: :delete, ids: [:product_id], path: "product_listings/<product_id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :body_html
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(String)) }
    attr_reader :handle
    sig { returns(T.nilable(T::Array[Image])) }
    attr_reader :images
    sig { returns(T.nilable(T::Array[Hash])) }
    attr_reader :options
    sig { returns(T.nilable(Integer)) }
    attr_reader :product_id
    sig { returns(T.nilable(String)) }
    attr_reader :product_type
    sig { returns(T.nilable(String)) }
    attr_reader :published_at
    sig { returns(T.nilable(String)) }
    attr_reader :tags
    sig { returns(T.nilable(String)) }
    attr_reader :title
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at
    sig { returns(T.nilable(T::Array[Variant])) }
    attr_reader :variants
    sig { returns(T.nilable(String)) }
    attr_reader :vendor

    class << self
      sig do
        returns(String)
      end
      def primary_key()
        "product_id"
      end

      sig do
        params(
          session: Auth::Session,
          product_id: T.any(Integer, String)
        ).returns(T.nilable(ProductListing))
      end
      def find(
        session:,
        product_id:
      )
        result = base_find(
          ids: {product_id: product_id},
          params: {},
          session: session,
        )
        T.cast(result[0], T.nilable(ProductListing))
      end

      sig do
        params(
          session: Auth::Session,
          product_id: T.any(Integer, String)
        ).returns(T.untyped)
      end
      def delete(
        session:,
        product_id:
      )
        request(
          http_method: :delete,
          operation: :delete,
          session: session,
          path_ids: {product_id: product_id},
          params: {},
        )
      end

      sig do
        params(
          session: Auth::Session,
          product_ids: T.untyped,
          limit: T.untyped,
          collection_id: T.untyped,
          updated_at_min: T.untyped,
          handle: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[ProductListing])
      end
      def all(
        session:,
        product_ids: nil,
        limit: nil,
        collection_id: nil,
        updated_at_min: nil,
        handle: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {product_ids: product_ids, limit: limit, collection_id: collection_id, updated_at_min: updated_at_min, handle: handle}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[ProductListing])
      end

      sig do
        params(
          session: Auth::Session,
          limit: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def product_ids(
        session:,
        limit: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :product_ids,
          session: session,
          path_ids: {},
          params: {limit: limit}.merge(kwargs).compact,
          entity: nil,
        )
      end

      sig do
        params(
          session: Auth::Session,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          path_ids: {},
          params: {}.merge(kwargs).compact,
          entity: nil,
        )
      end

    end

  end
end
