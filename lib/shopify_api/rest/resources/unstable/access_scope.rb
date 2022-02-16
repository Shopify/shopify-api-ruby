# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class AccessScope < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @custom_prefix = T.let("/admin/oauth", T.nilable(String))
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "access_scopes.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(String) }
    attr_reader :handle
    sig { returns(T.nilable(T::Array[Hash])) }
    attr_reader :access_scopes

    class << self
      sig do
        params(
          session: Auth::Session,
          kwargs: T.untyped
        ).returns(T::Array[AccessScope])
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

        T.cast(response, T::Array[AccessScope])
      end

    end

  end
end
