# typed: false
# frozen_string_literal: true

module ShopifyAPI
  class ResourceFeedback < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: nil)
      super(session: session)

      @created_at = T.let(nil, T.nilable(String))
      @feedback_generated_at = T.let(nil, T.nilable(String))
      @messages = T.let(nil, T.nilable(T::Array[T.untyped]))
      @resource_id = T.let(nil, T.nilable(Integer))
      @resource_type = T.let(nil, T.nilable(String))
      @state = T.let(nil, T.nilable(String))
      @updated_at = T.let(nil, T.nilable(String))
    end

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :post, operation: :post, ids: [], path: "resource_feedback.json"},
      {http_method: :get, operation: :get, ids: [], path: "resource_feedback.json"}
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
    attr_reader :state
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at

    class << self
      sig do
        params(
          session: Auth::Session,
          kwargs: T.untyped
        ).returns(T::Array[ResourceFeedback])
      end
      def all(
        session:,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[ResourceFeedback])
      end

    end

  end
end
