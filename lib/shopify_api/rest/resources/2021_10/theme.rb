# typed: false
# frozen_string_literal: true

module ShopifyAPI
  class Theme < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: nil)
      super(session: session)

      @created_at = T.let(nil, T.nilable(String))
      @id = T.let(nil, T.nilable(Integer))
      @name = T.let(nil, T.nilable(String))
      @previewable = T.let(nil, T.nilable(T::Boolean))
      @processing = T.let(nil, T.nilable(T::Boolean))
      @role = T.let(nil, T.nilable(String))
      @theme_store_id = T.let(nil, T.nilable(Integer))
      @updated_at = T.let(nil, T.nilable(String))
    end

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
          session: session,
          ids: {id: id},
          params: {fields: fields},
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
          ids: {id: id},
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
        response = base_find(
          session: session,
          ids: {},
          params: {fields: fields}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[Theme])
      end

    end

  end
end
