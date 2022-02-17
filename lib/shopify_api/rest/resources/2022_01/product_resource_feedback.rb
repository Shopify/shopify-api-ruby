# typed: false
# frozen_string_literal: true

module ShopifyAPI
  class ProductResourceFeedback < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: nil)
      super(session: session)

      @created_at = T.let(nil, T.nilable(String))
      @feedback_generated_at = T.let(nil, T.nilable(String))
      @messages = T.let(nil, T.nilable(T::Array[T.untyped]))
      @product_id = T.let(nil, T.nilable(Integer))
      @resource_id = T.let(nil, T.nilable(Integer))
      @resource_type = T.let(nil, T.nilable(String))
      @resource_updated_at = T.let(nil, T.nilable(String))
      @state = T.let(nil, T.nilable(String))
      @updated_at = T.let(nil, T.nilable(String))
    end

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :post, operation: :post, ids: [:product_id], path: "products/<product_id>/resource_feedback.json"},
      {http_method: :get, operation: :get, ids: [:product_id], path: "products/<product_id>/resource_feedback.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(String)) }
    attr_reader :feedback_generated_at
    sig { returns(T.nilable(T::Array[String])) }
    attr_reader :messages
    sig { returns(T.nilable(Integer)) }
    attr_reader :product_id
    sig { returns(T.nilable(Integer)) }
    attr_reader :resource_id
    sig { returns(T.nilable(String)) }
    attr_reader :resource_type
    sig { returns(T.nilable(String)) }
    attr_reader :resource_updated_at
    sig { returns(T.nilable(String)) }
    attr_reader :state
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at

    class << self
      sig do
        returns(String)
      end
      def json_body_name()
        "resource_feedback"
      end

      sig do
        params(
          session: Auth::Session,
          product_id: T.nilable(T.any(Integer, String)),
          kwargs: T.untyped
        ).returns(T::Array[ProductResourceFeedback])
      end
      def all(
        session:,
        product_id: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {product_id: product_id},
          params: {}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[ProductResourceFeedback])
      end

    end

  end
end
