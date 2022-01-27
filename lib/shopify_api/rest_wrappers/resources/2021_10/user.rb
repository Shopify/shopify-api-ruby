# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class User < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "users.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "users/<id>.json"},
      {http_method: :get, operation: :current, ids: [], path: "users/current.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :account_owner
    sig { returns(T.nilable(String)) }
    attr_reader :bio
    sig { returns(T.nilable(String)) }
    attr_reader :email
    sig { returns(T.nilable(String)) }
    attr_reader :first_name
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :im
    sig { returns(T.nilable(String)) }
    attr_reader :last_name
    sig { returns(T.nilable(String)) }
    attr_reader :locale
    sig { returns(T.nilable(T::Array[String])) }
    attr_reader :permissions
    sig { returns(T.nilable(String)) }
    attr_reader :phone
    sig { returns(T.nilable(Integer)) }
    attr_reader :receive_announcements
    sig { returns(T.nilable(String)) }
    attr_reader :screen_name
    sig { returns(T.nilable(String)) }
    attr_reader :url
    sig { returns(T.nilable(String)) }
    attr_reader :user_type

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String)
        ).returns(T.nilable(User))
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
        T.cast(result[0], T.nilable(User))
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
          limit: T.untyped,
          page_info: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[User])
      end
      def all(
        session:,
        limit: nil,
        page_info: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {limit: limit, page_info: page_info}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[User])
      end

      sig do
        params(
          session: Auth::Session,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def current(
        session:,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :current,
          session: session,
          path_ids: {},
          params: {}.merge(kwargs).compact,
          entity: nil,
        )
      end

    end

  end
end
