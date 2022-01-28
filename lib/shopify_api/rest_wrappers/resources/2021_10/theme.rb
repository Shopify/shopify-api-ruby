# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Theme < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "themes.json"},
      {http_method: :post, operation: :post, ids: [], path: "themes.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "themes/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "themes/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "themes/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :name
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :previewable
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :processing
    sig { returns(T.nilable(String)) }
    attr_reader :role
    sig { returns(T.nilable(Integer)) }
    attr_reader :theme_store_id
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          fields: T.untyped
        ).returns(T.nilable(Theme))
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
        T.cast(result[0], T.nilable(Theme))
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
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[Theme])
      end
      def all(
        session:,
        fields: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {fields: fields}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[Theme])
      end

    end

  end
end
