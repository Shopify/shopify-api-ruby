# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class MobilePlatformApplication < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "mobile_platform_applications.json"},
      {http_method: :post, operation: :post, ids: [], path: "mobile_platform_applications.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "mobile_platform_applications/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "mobile_platform_applications/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "mobile_platform_applications/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :application_id
    sig { returns(T.nilable(Hash)) }
    attr_reader :enabled_shared_webcredentials
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :enabled_universal_or_app_links
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :platform
    sig { returns(T.nilable(T::Array[String])) }
    attr_reader :sha256_cert_fingerprints

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String)
        ).returns(T.nilable(MobilePlatformApplication))
      end
      def find(
        session:,
        id:
      )
        result = base_find(
          ids: {id: id},
          params: {},
          session: session,
        )
        T.cast(result[0], T.nilable(MobilePlatformApplication))
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
          kwargs: T.untyped
        ).returns(T::Array[MobilePlatformApplication])
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
        T.cast(result, T::Array[MobilePlatformApplication])
      end

    end

  end
end
