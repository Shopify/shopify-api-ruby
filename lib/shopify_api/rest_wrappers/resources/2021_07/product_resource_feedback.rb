# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class ProductResourceFeedback < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :post, operation: :resource_feedback, ids: [:product_id], path: "products/<product_id>/resource_feedback.json"},
      {http_method: :get, operation: :resource_feedback, ids: [:product_id], path: "products/<product_id>/resource_feedback.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(String)) }
    attr_reader :feedback_generated_at
    sig { returns(T.nilable(T::Array[String])) }
    attr_reader :messages
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
          kwargs: T.untyped
        ).returns(T::Array[ProductResourceFeedback])
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
        T.cast(result, T::Array[ProductResourceFeedback])
      end

      sig do
        params(
          session: Auth::Session,
          product_id: T.nilable(T.any(Integer, String)),
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def resource_feedback(
        session:,
        product_id: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :resource_feedback,
          session: session,
          path_ids: {product_id: product_id},
          params: {}.merge(kwargs).compact,
          entity: nil,
        )
      end

    end

    sig do
      params(
        state: T.untyped,
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def resource_feedback(
      state: nil,
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :resource_feedback,
        session: @session,
        path_ids: {product_id: @product_id},
        params: {state: state}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

  end
end
