# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class PaymentGateway < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "payment_gateways.json"},
      {http_method: :post, operation: :post, ids: [], path: "payment_gateways.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "payment_gateways/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "payment_gateways/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "payment_gateways/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :attachment
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(String)) }
    attr_reader :credential1
    sig { returns(T.nilable(String)) }
    attr_reader :credential2
    sig { returns(T.nilable(String)) }
    attr_reader :credential3
    sig { returns(T.nilable(String)) }
    attr_reader :credential4
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :disabled
    sig { returns(T.nilable(T::Array[String])) }
    attr_reader :enabled_card_brands
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :name
    sig { returns(T.nilable(String)) }
    attr_reader :processing_method
    sig { returns(T.nilable(Integer)) }
    attr_reader :provider_id
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :sandbox
    sig { returns(T.nilable(String)) }
    attr_reader :service_name
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :supports_network_tokenization
    sig { returns(T.nilable(String)) }
    attr_reader :type
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String)
        ).returns(T.nilable(PaymentGateway))
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
        T.cast(result[0], T.nilable(PaymentGateway))
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
        ).returns(T::Array[PaymentGateway])
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
        T.cast(result, T::Array[PaymentGateway])
      end

    end

  end
end
