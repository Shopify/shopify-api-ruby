# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class UsageCharge < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :post, operation: :post, ids: [:recurring_application_charge_id], path: "recurring_application_charges/<recurring_application_charge_id>/usage_charges.json"},
      {http_method: :get, operation: :get, ids: [:recurring_application_charge_id], path: "recurring_application_charges/<recurring_application_charge_id>/usage_charges.json"},
      {http_method: :get, operation: :get, ids: [:recurring_application_charge_id, :id], path: "recurring_application_charges/<recurring_application_charge_id>/usage_charges/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(String)) }
    attr_reader :description
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(Integer)) }
    attr_reader :price
    sig { returns(T.nilable(Integer)) }
    attr_reader :recurring_application_charge_id
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          recurring_application_charge_id: T.nilable(T.any(Integer, String)),
          fields: T.untyped
        ).returns(T.nilable(UsageCharge))
      end
      def find(
        session:,
        id:,
        recurring_application_charge_id: nil,
        fields: nil
      )
        result = base_find(
          ids: {recurring_application_charge_id: recurring_application_charge_id, id: id},
          params: {fields: fields},
          session: session,
        )
        T.cast(result[0], T.nilable(UsageCharge))
      end

      sig do
        params(
          session: Auth::Session
        ).returns(T.untyped)
      end
      def delete(session:)
        request(
          http_method: :delete,
          operation: :delete,
          session: session,
          path_ids: {},
          params: {},
        )
      end

      sig do
        params(
          session: Auth::Session,
          recurring_application_charge_id: T.nilable(T.any(Integer, String)),
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[UsageCharge])
      end
      def all(
        session:,
        recurring_application_charge_id: nil,
        fields: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {recurring_application_charge_id: recurring_application_charge_id},
          params: {fields: fields}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[UsageCharge])
      end

    end

  end
end
