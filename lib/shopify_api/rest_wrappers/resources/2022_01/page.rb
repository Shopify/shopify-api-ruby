# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Page < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({
      metafield: Metafield
    }, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "pages.json"},
      {http_method: :post, operation: :post, ids: [], path: "pages.json"},
      {http_method: :get, operation: :count, ids: [], path: "pages/count.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "pages/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "pages/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "pages/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :author
    sig { returns(T.nilable(String)) }
    attr_reader :body_html
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(String)) }
    attr_reader :handle
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(Metafield)) }
    attr_reader :metafield
    sig { returns(T.nilable(String)) }
    attr_reader :published_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :shop_id
    sig { returns(T.nilable(String)) }
    attr_reader :template_suffix
    sig { returns(T.nilable(String)) }
    attr_reader :title
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          fields: T.untyped
        ).returns(T.nilable(Page))
      end
      def find(
        session:,
        id:,
        fields: nil
      )
        result = base_find(
          ids: {id: id},
          params: {fields: fields},
          session: session,
        )
        T.cast(result[0], T.nilable(Page))
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
          path_ids: {id: id},
          params: {},
        )
      end

      sig do
        params(
          session: Auth::Session,
          limit: T.untyped,
          since_id: T.untyped,
          title: T.untyped,
          handle: T.untyped,
          created_at_min: T.untyped,
          created_at_max: T.untyped,
          updated_at_min: T.untyped,
          updated_at_max: T.untyped,
          published_at_min: T.untyped,
          published_at_max: T.untyped,
          fields: T.untyped,
          published_status: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[Page])
      end
      def all(
        session:,
        limit: nil,
        since_id: nil,
        title: nil,
        handle: nil,
        created_at_min: nil,
        created_at_max: nil,
        updated_at_min: nil,
        updated_at_max: nil,
        published_at_min: nil,
        published_at_max: nil,
        fields: nil,
        published_status: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {limit: limit, since_id: since_id, title: title, handle: handle, created_at_min: created_at_min, created_at_max: created_at_max, updated_at_min: updated_at_min, updated_at_max: updated_at_max, published_at_min: published_at_min, published_at_max: published_at_max, fields: fields, published_status: published_status}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[Page])
      end

      sig do
        params(
          session: Auth::Session,
          title: T.untyped,
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
        title: nil,
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
          path_ids: {},
          params: {title: title, created_at_min: created_at_min, created_at_max: created_at_max, updated_at_min: updated_at_min, updated_at_max: updated_at_max, published_at_min: published_at_min, published_at_max: published_at_max, published_status: published_status}.merge(kwargs).compact,
          entity: nil,
        )
      end

    end

  end
end
