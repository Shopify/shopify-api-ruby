# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class MarketingEvent < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "marketing_events.json"},
      {http_method: :post, operation: :post, ids: [], path: "marketing_events.json"},
      {http_method: :get, operation: :count, ids: [], path: "marketing_events/count.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "marketing_events/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "marketing_events/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "marketing_events/<id>.json"},
      {http_method: :post, operation: :engagements, ids: [:id], path: "marketing_events/<id>/engagements.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(String) }
    attr_reader :event_type
    sig { returns(String) }
    attr_reader :marketing_channel
    sig { returns(T::Boolean) }
    attr_reader :paid
    sig { returns(String) }
    attr_reader :started_at
    sig { returns(T.nilable(Hash)) }
    attr_reader :UTM_parameters
    sig { returns(T.nilable(String)) }
    attr_reader :budget
    sig { returns(T.nilable(String)) }
    attr_reader :budget_type
    sig { returns(T.nilable(String)) }
    attr_reader :currency
    sig { returns(T.nilable(String)) }
    attr_reader :description
    sig { returns(T.nilable(String)) }
    attr_reader :ended_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :manage_url
    sig { returns(T.nilable(T::Array[Hash])) }
    attr_reader :marketed_resources
    sig { returns(T.nilable(String)) }
    attr_reader :preview_url
    sig { returns(T.nilable(String)) }
    attr_reader :referring_domain
    sig { returns(T.nilable(String)) }
    attr_reader :remote_id
    sig { returns(T.nilable(String)) }
    attr_reader :scheduled_to_end_at

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String)
        ).returns(T.nilable(MarketingEvent))
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
        T.cast(result[0], T.nilable(MarketingEvent))
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
          limit: T.untyped,
          offset: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[MarketingEvent])
      end
      def all(
        session:,
        limit: nil,
        offset: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {limit: limit, offset: offset}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[MarketingEvent])
      end

      sig do
        params(
          session: Auth::Session,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          path_ids: {},
          params: {}.merge(kwargs).compact,
          entity: nil,
        )
      end

    end

    sig do
      params(
        occurred_on: T.untyped,
        impressions_count: T.untyped,
        views_count: T.untyped,
        clicks_count: T.untyped,
        shares_count: T.untyped,
        favorites_count: T.untyped,
        comments_count: T.untyped,
        ad_spend: T.untyped,
        is_cumulative: T.untyped,
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def engagements(
      occurred_on: nil,
      impressions_count: nil,
      views_count: nil,
      clicks_count: nil,
      shares_count: nil,
      favorites_count: nil,
      comments_count: nil,
      ad_spend: nil,
      is_cumulative: nil,
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :engagements,
        session: @session,
        path_ids: {id: @id},
        params: {occurred_on: occurred_on, impressions_count: impressions_count, views_count: views_count, clicks_count: clicks_count, shares_count: shares_count, favorites_count: favorites_count, comments_count: comments_count, ad_spend: ad_spend, is_cumulative: is_cumulative}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

  end
end
