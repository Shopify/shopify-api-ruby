# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Asset < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [:theme_id], path: "themes/<theme_id>/assets.json"},
      {http_method: :put, operation: :put, ids: [:theme_id], path: "themes/<theme_id>/assets.json"},
      {http_method: :get, operation: :get, ids: [:theme_id], path: "themes/<theme_id>/assets.json"},
      {http_method: :delete, operation: :delete, ids: [:theme_id], path: "themes/<theme_id>/assets.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :attachment
    sig { returns(T.nilable(String)) }
    attr_reader :checksum
    sig { returns(T.nilable(String)) }
    attr_reader :content_type
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(String)) }
    attr_reader :key
    sig { returns(T.nilable(String)) }
    attr_reader :public_url
    sig { returns(T.nilable(Integer)) }
    attr_reader :size
    sig { returns(T.nilable(Integer)) }
    attr_reader :theme_id
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at
    sig { returns(T.nilable(String)) }
    attr_reader :value

    class << self
      sig do
        returns(String)
      end
      def primary_key()
        "key"
      end

      sig do
        params(
          session: Auth::Session,
          theme_id: T.nilable(T.any(Integer, String)),
          asset: T.nilable(Hash)
        ).returns(T.untyped)
      end
      def delete(
        session:,
        theme_id: nil,
        asset: nil
      )
        request(
          http_method: :delete,
          operation: :delete,
          session: session,
          ids: {theme_id: theme_id},
          params: {asset: asset},
        )
      end

      sig do
        params(
          session: Auth::Session,
          theme_id: T.nilable(T.any(Integer, String)),
          fields: T.untyped,
          asset: T.nilable(Hash),
          kwargs: T.untyped
        ).returns(T::Array[Asset])
      end
      def all(
        session:,
        theme_id: nil,
        fields: nil,
        asset: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {theme_id: theme_id},
          params: {fields: fields, asset: asset}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[Asset])
      end

    end

  end
end
