# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class DeprecatedApiCall < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "deprecated_api_calls.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :data_updated_at
    sig { returns(T.nilable(T::Array[Hash])) }
    attr_reader :deprecated_api_calls

    class << self
      sig do
        params(
          session: Auth::Session,
          kwargs: T.untyped
        ).returns(T::Array[DeprecatedApiCall])
      end
      def all(
        session:,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[DeprecatedApiCall])
      end

    end

  end
end
