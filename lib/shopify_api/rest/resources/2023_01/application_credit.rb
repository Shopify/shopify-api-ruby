# typed: false
# frozen_string_literal: true

########################################################################################################################
# This file is auto-generated. If you have an issue, please create a GitHub issue.                                     #
########################################################################################################################

module ShopifyAPI
  class ApplicationCredit < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: ShopifyAPI::Context.active_session)
      super(session: session)

      @amount = T.let(nil, T.nilable(Integer))
      @description = T.let(nil, T.nilable(String))
      @id = T.let(nil, T.nilable(Integer))
      @test = T.let(nil, T.nilable(T::Boolean))
    end

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "application_credits.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "application_credits/<id>.json"},
      {http_method: :post, operation: :post, ids: [], path: "application_credits.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(Integer)) }
    attr_reader :amount
    sig { returns(T.nilable(String)) }
    attr_reader :description
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :test

    class << self
      sig do
        params(
          id: T.any(Integer, String),
          fields: T.untyped,
          session: Auth::Session
        ).returns(T.nilable(ApplicationCredit))
      end
      def find(
        id:,
        fields: nil,
        session: ShopifyAPI::Context.active_session
      )
        result = base_find(
          session: session,
          ids: {id: id},
          params: {fields: fields},
        )
        T.cast(result[0], T.nilable(ApplicationCredit))
      end

      sig do
        params(
          fields: T.untyped,
          session: Auth::Session,
          kwargs: T.untyped
        ).returns(T::Array[ApplicationCredit])
      end
      def all(
        fields: nil,
        session: ShopifyAPI::Context.active_session,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {fields: fields}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[ApplicationCredit])
      end

    end

  end
end
