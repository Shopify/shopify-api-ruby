# typed: false
# frozen_string_literal: true

########################################################################################################################
# This file is auto-generated. If you have an issue, please create a GitHub issue.                                     #
########################################################################################################################

module ShopifyAPI
  class DiscountCode < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @api_call_limit = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @retry_request_after = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session), from_hash: T.nilable(T::Hash[T.untyped, T.untyped])).void }
    def initialize(session: ShopifyAPI::Context.active_session, from_hash: nil)

      @code = T.let(nil, T.nilable(String))
      @created_at = T.let(nil, T.nilable(String))
      @id = T.let(nil, T.nilable(Integer))
      @price_rule_id = T.let(nil, T.nilable(Integer))
      @updated_at = T.let(nil, T.nilable(String))
      @usage_count = T.let(nil, T.nilable(Integer))

      super(session: session, from_hash: from_hash)
    end

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :delete, operation: :delete, ids: [:price_rule_id, :id], path: "price_rules/<price_rule_id>/discount_codes/<id>.json"},
      {http_method: :get, operation: :count, ids: [], path: "discount_codes/count.json"},
      {http_method: :get, operation: :get, ids: [:price_rule_id, :batch_id], path: "price_rules/<price_rule_id>/batch/<batch_id>/discount_codes.json"},
      {http_method: :get, operation: :get_batch_results, ids: [:price_rule_id, :batch_id], path: "price_rules/<price_rule_id>/batch/<batch_id>/discount_codes.json"},
      {http_method: :get, operation: :get, ids: [:price_rule_id], path: "price_rules/<price_rule_id>/discount_codes.json"},
      {http_method: :get, operation: :get, ids: [:price_rule_id, :id], path: "price_rules/<price_rule_id>/discount_codes/<id>.json"},
      {http_method: :get, operation: :get_all, ids: [:price_rule_id, :batch_id], path: "price_rules/<price_rule_id>/batch/<batch_id>.json"},
      {http_method: :get, operation: :lookup, ids: [], path: "discount_codes/lookup.json"},
      {http_method: :post, operation: :batch, ids: [:price_rule_id], path: "price_rules/<price_rule_id>/batch.json"},
      {http_method: :post, operation: :post, ids: [:price_rule_id], path: "price_rules/<price_rule_id>/discount_codes.json"},
      {http_method: :put, operation: :put, ids: [:price_rule_id, :id], path: "price_rules/<price_rule_id>/discount_codes/<id>.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :code
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(Integer)) }
    attr_reader :price_rule_id
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :usage_count

    class BatchResult < T::Struct
      const :id, T.nilable(Integer)
      const :code, T.nilable(String)
      const :errors, T.nilable(T::Hash[T.untyped, T.untyped])
    end

    class << self
      sig do
        params(
          id: T.any(Integer, String),
          price_rule_id: T.nilable(T.any(Integer, String)),
          session: Auth::Session
        ).returns(T.nilable(DiscountCode))
      end
      def find(
        id:,
        price_rule_id: nil,
        session: ShopifyAPI::Context.active_session
      )
        result = base_find(
          session: session,
          ids: {id: id, price_rule_id: price_rule_id},
          params: {},
        )
        T.cast(result[0], T.nilable(DiscountCode))
      end

      sig do
        params(
          id: T.any(Integer, String),
          price_rule_id: T.nilable(T.any(Integer, String)),
          session: Auth::Session
        ).returns(T.untyped)
      end
      def delete(
        id:,
        price_rule_id: nil,
        session: ShopifyAPI::Context.active_session
      )
        request(
          http_method: :delete,
          operation: :delete,
          session: session,
          ids: {id: id, price_rule_id: price_rule_id},
          params: {},
        )
      end

      sig do
        params(
          price_rule_id: T.nilable(T.any(Integer, String)),
          batch_id: T.nilable(T.any(Integer, String)),
          session: Auth::Session,
          kwargs: T.untyped
        ).returns(T::Array[DiscountCode])
      end
      def all(
        price_rule_id: nil,
        batch_id: nil,
        session: ShopifyAPI::Context.active_session,
        **kwargs
      )
        unless batch_id.nil?
          deprecation_msg = <<~MSG
            DEPRECATED: Use `.get_batch_results`
            instead of `.all` with `batch_id` argument to get the right return type.
          MSG
          ShopifyAPI::Logger.deprecated(
            deprecation_msg,
            "14.0.0",
          )
        end

        response = base_find(
          session: session,
          ids: {price_rule_id: price_rule_id, batch_id: batch_id},
          params: {}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[DiscountCode])
      end

      sig do
        params(
          times_used: T.untyped,
          times_used_min: T.untyped,
          times_used_max: T.untyped,
          session: Auth::Session,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        times_used: nil,
        times_used_min: nil,
        times_used_max: nil,
        session: ShopifyAPI::Context.active_session,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          ids: {},
          params: {times_used: times_used, times_used_min: times_used_min, times_used_max: times_used_max}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

      sig do
        params(
          price_rule_id: T.nilable(T.any(Integer, String)),
          batch_id: T.nilable(T.any(Integer, String)),
          session: Auth::Session,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def get_all(
        price_rule_id: nil,
        batch_id: nil,
        session: ShopifyAPI::Context.active_session,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :get_all,
          session: session,
          ids: {price_rule_id: price_rule_id, batch_id: batch_id},
          params: {}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

      sig do
        params(
          price_rule_id: T.nilable(T.any(Integer, String)),
          batch_id: T.nilable(T.any(Integer, String)),
          session: Auth::Session,
          kwargs: T.untyped
        ).returns(T::Array[BatchResult])
      end
      def get_batch_results(
        price_rule_id: nil,
        batch_id: nil,
        session: ShopifyAPI::Context.active_session,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get_batch_results,
          session: session,
          ids: {price_rule_id: price_rule_id, batch_id: batch_id},
          params: {}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )

        body = T.cast(response.body, T::Hash[String, T.untyped])
        results = T.let([], T::Array[BatchResult])

        response_names = json_response_body_names
        response_names.each do |response_name|
          root = response_name.pluralize
          batch_results = body[root]

          results = batch_results.map do |result|
            original_state = result.transform_keys(&:to_sym)

            BatchResult.new(
              id: original_state[:id],
              code: original_state[:code],
              errors: original_state[:errors],
            )
          end
        end

        results
      end

      sig do
        params(
          code: T.untyped,
          session: Auth::Session,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def lookup(
        code: nil,
        session: ShopifyAPI::Context.active_session,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :lookup,
          session: session,
          ids: {},
          params: {code: code}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

    end

    sig do
      params(
        body: T.untyped,
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def batch(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :batch,
        session: @session,
        ids: {price_rule_id: @price_rule_id},
        params: {}.merge(kwargs).compact,
        body: body,
        entity: self,
      )
    end

  end
end
