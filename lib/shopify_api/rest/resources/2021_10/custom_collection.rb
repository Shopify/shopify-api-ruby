# typed: false
# frozen_string_literal: true

module ShopifyAPI
  class CustomCollection < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: nil)
      super(session: session)

      @title = T.let(nil, T.nilable(String))
      @body_html = T.let(nil, T.nilable(String))
      @handle = T.let(nil, T.nilable(String))
      @id = T.let(nil, T.nilable(Integer))
      @image = T.let(nil, T.nilable(T.any(String, T::Hash[T.untyped, T.untyped])))
      @published = T.let(nil, T.nilable(T::Boolean))
      @published_at = T.let(nil, T.nilable(String))
      @published_scope = T.let(nil, T.nilable(String))
      @sort_order = T.let(nil, T.nilable(String))
      @template_suffix = T.let(nil, T.nilable(String))
      @updated_at = T.let(nil, T.nilable(String))
    end

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "custom_collections.json"},
      {http_method: :post, operation: :post, ids: [], path: "custom_collections.json"},
      {http_method: :get, operation: :count, ids: [], path: "custom_collections/count.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "custom_collections/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "custom_collections/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "custom_collections/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :title
    sig { returns(T.nilable(String)) }
    attr_reader :body_html
    sig { returns(T.nilable(String)) }
    attr_reader :handle
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(T.any(String, T::Hash[T.untyped, T.untyped]))) }
    attr_reader :image
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :published
    sig { returns(T.nilable(String)) }
    attr_reader :published_at
    sig { returns(T.nilable(String)) }
    attr_reader :published_scope
    sig { returns(T.nilable(String)) }
    attr_reader :sort_order
    sig { returns(T.nilable(String)) }
    attr_reader :template_suffix
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          fields: T.untyped
        ).returns(T.nilable(CustomCollection))
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
        T.cast(result[0], T.nilable(CustomCollection))
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
          limit: T.untyped,
          ids: T.untyped,
          since_id: T.untyped,
          title: T.untyped,
          product_id: T.untyped,
          handle: T.untyped,
          updated_at_min: T.untyped,
          updated_at_max: T.untyped,
          published_at_min: T.untyped,
          published_at_max: T.untyped,
          published_status: T.untyped,
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[CustomCollection])
      end
      def all(
        session:,
        limit: nil,
        ids: nil,
        since_id: nil,
        title: nil,
        product_id: nil,
        handle: nil,
        updated_at_min: nil,
        updated_at_max: nil,
        published_at_min: nil,
        published_at_max: nil,
        published_status: nil,
        fields: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {limit: limit, ids: ids, since_id: since_id, title: title, product_id: product_id, handle: handle, updated_at_min: updated_at_min, updated_at_max: updated_at_max, published_at_min: published_at_min, published_at_max: published_at_max, published_status: published_status, fields: fields}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[CustomCollection])
      end

      sig do
        params(
          session: Auth::Session,
          title: T.untyped,
          product_id: T.untyped,
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
        title: nil,
        product_id: nil,
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
          params: {title: title, product_id: product_id, updated_at_min: updated_at_min, updated_at_max: updated_at_max, published_at_min: published_at_min, published_at_max: published_at_max, published_status: published_status}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

    end

  end
end
