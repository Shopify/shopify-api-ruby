# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class SmartCollection < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "smart_collections.json"},
      {http_method: :post, operation: :post, ids: [], path: "smart_collections.json"},
      {http_method: :get, operation: :count, ids: [], path: "smart_collections/count.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "smart_collections/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "smart_collections/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "smart_collections/<id>.json"},
      {http_method: :put, operation: :order, ids: [:id], path: "smart_collections/<id>/order.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(Hash) }
    attr_reader :rules
    sig { returns(String) }
    attr_reader :title
    sig { returns(T.nilable(String)) }
    attr_reader :body_html
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :disjunctive
    sig { returns(T.nilable(String)) }
    attr_reader :handle
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(T::Array[String, Hash])) }
    attr_reader :image
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
        ).returns(T.nilable(SmartCollection))
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
        T.cast(result[0], T.nilable(SmartCollection))
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
        ).returns(T::Array[SmartCollection])
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
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {limit: limit, ids: ids, since_id: since_id, title: title, product_id: product_id, handle: handle, updated_at_min: updated_at_min, updated_at_max: updated_at_max, published_at_min: published_at_min, published_at_max: published_at_max, published_status: published_status, fields: fields}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[SmartCollection])
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
          path_ids: {},
          params: {title: title, product_id: product_id, updated_at_min: updated_at_min, updated_at_max: updated_at_max, published_at_min: published_at_min, published_at_max: published_at_max, published_status: published_status}.merge(kwargs).compact,
          entity: nil,
        )
      end

    end

    sig do
      params(
        products: T.untyped,
        sort_order: T.untyped,
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def order(
      products: nil,
      sort_order: nil,
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :put,
        operation: :order,
        session: @session,
        path_ids: {id: @id},
        params: {products: products, sort_order: sort_order}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

  end
end
