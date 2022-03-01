# typed: false
# frozen_string_literal: true

module ShopifyAPI
  class DisputeEvidence < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: ShopifyAPI::Context.active_session)
      super(session: session)

      @access_activity_log = T.let(nil, T.nilable(String))
      @billing_address = T.let(nil, T.nilable(T::Hash[T.untyped, T.untyped]))
      @cancellation_policy_disclosure = T.let(nil, T.nilable(String))
      @cancellation_rebuttal = T.let(nil, T.nilable(String))
      @created_at = T.let(nil, T.nilable(String))
      @customer_email_address = T.let(nil, T.nilable(String))
      @customer_first_name = T.let(nil, T.nilable(String))
      @customer_last_name = T.let(nil, T.nilable(String))
      @dispute_evidence_files = T.let(nil, T.nilable(T::Hash[T.untyped, T.untyped]))
      @fulfillments = T.let(nil, T.nilable(T::Array[T.untyped]))
      @id = T.let(nil, T.nilable(Integer))
      @payments_dispute_id = T.let(nil, T.nilable(Integer))
      @product_description = T.let(nil, T.nilable(T::Hash[T.untyped, T.untyped]))
      @refund_policy_disclosure = T.let(nil, T.nilable(String))
      @refund_refusal_explanation = T.let(nil, T.nilable(String))
      @shipping_address_attributes = T.let(nil, T.nilable(T::Hash[T.untyped, T.untyped]))
      @submitted = T.let(nil, T.nilable(T::Boolean))
      @uncategorized_text = T.let(nil, T.nilable(String))
      @updated_on = T.let(nil, T.nilable(String))
    end

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({
      fulfillments: Fulfillment
    }, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [:dispute_id], path: "shopify_payments/disputes/<dispute_id>/dispute_evidences.json"},
      {http_method: :put, operation: :put, ids: [:dispute_id], path: "shopify_payments/disputes/<dispute_id>/dispute_evidences.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :access_activity_log
    sig { returns(T.nilable(T::Hash[T.untyped, T.untyped])) }
    attr_reader :billing_address
    sig { returns(T.nilable(String)) }
    attr_reader :cancellation_policy_disclosure
    sig { returns(T.nilable(String)) }
    attr_reader :cancellation_rebuttal
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(String)) }
    attr_reader :customer_email_address
    sig { returns(T.nilable(String)) }
    attr_reader :customer_first_name
    sig { returns(T.nilable(String)) }
    attr_reader :customer_last_name
    sig { returns(T.nilable(T::Hash[T.untyped, T.untyped])) }
    attr_reader :dispute_evidence_files
    sig { returns(T.nilable(T::Array[Fulfillment])) }
    attr_reader :fulfillments
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(Integer)) }
    attr_reader :payments_dispute_id
    sig { returns(T.nilable(T::Hash[T.untyped, T.untyped])) }
    attr_reader :product_description
    sig { returns(T.nilable(String)) }
    attr_reader :refund_policy_disclosure
    sig { returns(T.nilable(String)) }
    attr_reader :refund_refusal_explanation
    sig { returns(T.nilable(T::Hash[T.untyped, T.untyped])) }
    attr_reader :shipping_address_attributes
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :submitted
    sig { returns(T.nilable(String)) }
    attr_reader :uncategorized_text
    sig { returns(T.nilable(String)) }
    attr_reader :updated_on

    class << self
      sig do
        params(
          dispute_id: T.nilable(T.any(Integer, String)),
          session: Auth::Session,
          kwargs: T.untyped
        ).returns(T::Array[DisputeEvidence])
      end
      def all(
        dispute_id: nil,
        session: ShopifyAPI::Context.active_session,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {dispute_id: dispute_id},
          params: {}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[DisputeEvidence])
      end

    end

  end
end
