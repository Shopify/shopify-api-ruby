# typed: false
# frozen_string_literal: true

########################################################################################################################
# This file is auto-generated. If you have an issue, please create a GitHub issue.                                     #
########################################################################################################################

module ShopifyAPI
  class Policy < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: ShopifyAPI::Context.active_session)
      super(session: session)

      @body = T.let(nil, T.nilable(String))
      @created_at = T.let(nil, T.nilable(String))
      @handle = T.let(nil, T.nilable(String))
      @title = T.let(nil, T.nilable(String))
      @updated_at = T.let(nil, T.nilable(String))
      @url = T.let(nil, T.nilable(String))
    end

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "policies.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :body
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(String)) }
    attr_reader :handle
    sig { returns(T.nilable(String)) }
    attr_reader :title
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at
    sig { returns(T.nilable(String)) }
    attr_reader :url

    class << self
      sig do
        params(
          session: Auth::Session,
          kwargs: T.untyped
        ).returns(T::Array[Policy])
      end
      def all(
        session: ShopifyAPI::Context.active_session,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[Policy])
      end

    end

  end
end
