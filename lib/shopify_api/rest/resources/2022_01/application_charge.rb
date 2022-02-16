# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class ApplicationCharge < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :post, operation: :post, ids: [], path: "application_charges.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "application_charges/<id>.json"},
      {http_method: :get, operation: :get, ids: [], path: "application_charges.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :confirmation_url
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :name
    sig { returns(T.nilable(String)) }
    attr_reader :price
    sig { returns(T.nilable(String)) }
    attr_reader :return_url
    sig { returns(T.nilable(String)) }
    attr_reader :status
    sig { returns(T.nilable(String)) }
    attr_reader :test
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          fields: T.untyped
        ).returns(T.nilable(ApplicationCharge))
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
        T.cast(result[0], T.nilable(ApplicationCharge))
      end

      sig do
        params(
          session: Auth::Session,
          since_id: T.untyped,
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[ApplicationCharge])
      end
      def all(
        session:,
        since_id: nil,
        fields: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {since_id: since_id, fields: fields}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[ApplicationCharge])
      end

    end

  end
end
