# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Collection < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({
      image: Image
    }, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [:id], path: "collections/<id>.json"},
      {http_method: :get, operation: :products, ids: [:id], path: "collections/<id>/products.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(String) }
    attr_reader :title
    sig { returns(T.nilable(String)) }
    attr_reader :body_html
    sig { returns(T.nilable(String)) }
    attr_reader :handle
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(Image)) }
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
        ).returns(T.nilable(Collection))
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
        T.cast(result[0], T.nilable(Collection))
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
          kwargs: T.untyped
        ).returns(T::Array[Collection])
      end
      def all(
        session:,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[Collection])
      end

      sig do
        params(
          session: Auth::Session,
          id: T.nilable(T.any(Integer, String)),
          limit: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def products(
        session:,
        id: nil,
        limit: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :products,
          session: session,
          path_ids: {id: id},
          params: {limit: limit}.merge(kwargs).compact,
          entity: nil,
        )
      end

    end

  end
end
