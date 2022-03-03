# typed: false
# frozen_string_literal: true

module ShopifyAPI
  class CollectionListing < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: nil)
      super(session: session)

      @body_html = T.let(nil, T.nilable(String))
      @collection_id = T.let(nil, T.nilable(Integer))
      @default_product_image = T.let(nil, T.nilable(T::Array[T.untyped]))
      @handle = T.let(nil, T.nilable(String))
      @image = T.let(nil, T.nilable(Image))
      @published_at = T.let(nil, T.nilable(String))
      @sort_order = T.let(nil, T.nilable(String))
      @title = T.let(nil, T.nilable(String))
      @updated_at = T.let(nil, T.nilable(String))
    end

    @has_one = T.let({
      image: Image
    }, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "collection_listings.json"},
      {http_method: :get, operation: :product_ids, ids: [:collection_id], path: "collection_listings/<collection_id>/product_ids.json"},
      {http_method: :get, operation: :get, ids: [:collection_id], path: "collection_listings/<collection_id>.json"},
      {http_method: :put, operation: :put, ids: [:collection_id], path: "collection_listings/<collection_id>.json"},
      {http_method: :delete, operation: :delete, ids: [:collection_id], path: "collection_listings/<collection_id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :body_html
    sig { returns(T.nilable(Integer)) }
    attr_reader :collection_id
    sig { returns(T.nilable(T::Array[T::Hash[T.untyped, T.untyped]])) }
    attr_reader :default_product_image
    sig { returns(T.nilable(String)) }
    attr_reader :handle
    sig { returns(T.nilable(Image)) }
    attr_reader :image
    sig { returns(T.nilable(String)) }
    attr_reader :published_at
    sig { returns(T.nilable(String)) }
    attr_reader :sort_order
    sig { returns(T.nilable(String)) }
    attr_reader :title
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at

    class << self
      sig do
        returns(String)
      end
      def primary_key()
        "collection_id"
      end

      sig do
        params(
          session: Auth::Session,
          collection_id: T.any(Integer, String)
        ).returns(T.nilable(CollectionListing))
      end
      def find(
        session:,
        collection_id:
      )
        result = base_find(
          session: session,
          ids: {collection_id: collection_id},
          params: {},
        )
        T.cast(result[0], T.nilable(CollectionListing))
      end

      sig do
        params(
          session: Auth::Session,
          collection_id: T.any(Integer, String)
        ).returns(T.untyped)
      end
      def delete(
        session:,
        collection_id:
      )
        request(
          http_method: :delete,
          operation: :delete,
          session: session,
          ids: {collection_id: collection_id},
          params: {},
        )
      end

      sig do
        params(
          session: Auth::Session,
          limit: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[CollectionListing])
      end
      def all(
        session:,
        limit: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {limit: limit}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[CollectionListing])
      end

      sig do
        params(
          session: Auth::Session,
          collection_id: T.any(Integer, String),
          limit: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def product_ids(
        session:,
        collection_id:,
        limit: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :product_ids,
          session: session,
          ids: {collection_id: collection_id},
          params: {limit: limit}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

    end

  end
end
