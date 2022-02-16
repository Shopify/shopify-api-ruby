# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Product < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({
      images: Image,
      variants: Variant
    }, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "products.json"},
      {http_method: :post, operation: :post, ids: [], path: "products.json"},
      {http_method: :get, operation: :count, ids: [], path: "products/count.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "products/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "products/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "products/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(String) }
    attr_reader :title
    sig { returns(T.nilable(String)) }
    attr_reader :body_html
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(String)) }
    attr_reader :handle
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(T::Array[Image])) }
    attr_reader :images
    sig { returns(T.nilable(Hash)) }
    attr_reader :options
    sig { returns(T.nilable(String)) }
    attr_reader :product_type
    sig { returns(T.nilable(String)) }
    attr_reader :published_at
    sig { returns(T.nilable(String)) }
    attr_reader :published_scope
    sig { returns(T.nilable(String)) }
    attr_reader :status
    sig { returns(T.nilable(String)) }
    attr_reader :tags
    sig { returns(T.nilable(String)) }
    attr_reader :template_suffix
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at
    sig { returns(T.nilable(T::Array[Variant])) }
    attr_reader :variants
    sig { returns(T.nilable(String)) }
    attr_reader :vendor

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          fields: T.untyped
        ).returns(T.nilable(Product))
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
        T.cast(result[0], T.nilable(Product))
      end

      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String)
        ).returns(T.untyped)
      end
      def delete(
        session:,
        id:
      )
        request(
          http_method: :delete,
          operation: :delete,
          session: session,
          ids: {id: id},
          params: {},
        )
      end

      sig do
        params(
          session: Auth::Session,
          ids: T.untyped,
          limit: T.untyped,
          since_id: T.untyped,
          title: T.untyped,
          vendor: T.untyped,
          handle: T.untyped,
          product_type: T.untyped,
          status: T.untyped,
          collection_id: T.untyped,
          created_at_min: T.untyped,
          created_at_max: T.untyped,
          updated_at_min: T.untyped,
          updated_at_max: T.untyped,
          published_at_min: T.untyped,
          published_at_max: T.untyped,
          published_status: T.untyped,
          fields: T.untyped,
          presentment_currencies: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[Product])
      end
      def all(
        session:,
        ids: nil,
        limit: nil,
        since_id: nil,
        title: nil,
        vendor: nil,
        handle: nil,
        product_type: nil,
        status: nil,
        collection_id: nil,
        created_at_min: nil,
        created_at_max: nil,
        updated_at_min: nil,
        updated_at_max: nil,
        published_at_min: nil,
        published_at_max: nil,
        published_status: nil,
        fields: nil,
        presentment_currencies: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {ids: ids, limit: limit, since_id: since_id, title: title, vendor: vendor, handle: handle, product_type: product_type, status: status, collection_id: collection_id, created_at_min: created_at_min, created_at_max: created_at_max, updated_at_min: updated_at_min, updated_at_max: updated_at_max, published_at_min: published_at_min, published_at_max: published_at_max, published_status: published_status, fields: fields, presentment_currencies: presentment_currencies}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[Product])
      end

      sig do
        params(
          session: Auth::Session,
          vendor: T.untyped,
          product_type: T.untyped,
          collection_id: T.untyped,
          created_at_min: T.untyped,
          created_at_max: T.untyped,
          updated_at_min: T.untyped,
          updated_at_max: T.untyped,
          published_at_min: T.untyped,
          published_at_max: T.untyped,
          published_status: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        vendor: nil,
        product_type: nil,
        collection_id: nil,
        created_at_min: nil,
        created_at_max: nil,
        updated_at_min: nil,
        updated_at_max: nil,
        published_at_min: nil,
        published_at_max: nil,
        published_status: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          ids: {},
          params: {vendor: vendor, product_type: product_type, collection_id: collection_id, created_at_min: created_at_min, created_at_max: created_at_max, updated_at_min: updated_at_min, updated_at_max: updated_at_max, published_at_min: published_at_min, published_at_max: published_at_max, published_status: published_status}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

    end

  end
end
