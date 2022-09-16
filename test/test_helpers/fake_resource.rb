# typed: strict
# frozen_string_literal: true

module TestHelpers
  class FakeResource < ShopifyAPI::Rest::Base
    extend T::Sig

    @has_one = T.let({
      has_one_attribute: FakeResource,
    }, T::Hash[Symbol, Class])

    @has_many = T.let({
      has_many_attribute: FakeResource,
    }, T::Hash[Symbol, Class])

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @read_only_attributes = T.let([:unsaveable_attribute], T::Array[Symbol])

    @paths = T.let([
      { http_method: :get, operation: :get, ids: [], path: "fake_resources.json" },
      { http_method: :post, operation: :post, ids: [], path: "fake_resources.json" },
      { http_method: :get, operation: :get, ids: [:id], path: "fake_resources/<id>.json" },
      { http_method: :put, operation: :put, ids: [:id], path: "fake_resources/<id>.json" },
      { http_method: :delete, operation: :delete, ids: [:id], path: "fake_resources/<id>.json" },
      { http_method: :get, operation: :custom, ids: [],
        path: "other_resources/<other_resource_id>/fake_resources/<id>/custom.json", },
      { http_method: :delete, operation: :delete, ids: [:other_resource_id, :id],
        path: "other_resources/<other_resource_id>/fake_resources/<id>.json", },
    ], T::Array[T::Hash[String, T.any(T::Array[T.untyped], String, Symbol)]])

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: nil)
      super(session: session)
      @id = T.let(nil, T.nilable(Integer))
      @attribute = T.let(nil, T.nilable(String))
      @has_one_attribute = T.let(nil, T.nilable(FakeResource))
      @has_many_attribute = T.let(nil, T.nilable(T::Array[FakeResource]))
      @other_resource_id = T.let(nil, T.nilable(Integer))
      @unsaveable_attribute = T.let(nil, T.nilable(String))
    end

    sig { returns(T.nilable(Integer)) }
    attr_reader :id

    sig { returns(T.nilable(String)) }
    attr_reader :attribute

    sig { returns(T.nilable(FakeResource)) }
    attr_reader :has_one_attribute

    sig { returns(T.nilable(T::Array[FakeResource])) }
    attr_reader :has_many_attribute

    sig { returns(T.nilable(Integer)) }
    attr_reader :other_resource_id

    sig { returns(T.nilable(String)) }
    attr_reader :unsaveable_attribute

    class << self
      sig do
        params(id: T.any(Integer, String), session: ShopifyAPI::Auth::Session, param: T.untyped,
          kwargs: T.untyped).returns(FakeResource)
      end
      def find(id:, session:, param: nil, **kwargs)
        T.cast(base_find(params: { param: param }.merge(kwargs), session: session, ids: { id: id })[0], FakeResource)
      end

      sig { params(session: ShopifyAPI::Auth::Session, kwargs: T.untyped).returns(T::Array[FakeResource]) }
      def all(session:, **kwargs)
        T.cast(base_find(session: session, params: kwargs), T::Array[FakeResource])
      end

      sig do
        params(
          session: ShopifyAPI::Auth::Session,
          id: Integer,
          other_resource_id: T.nilable(Integer),
        ).returns(T.untyped)
      end
      def custom(session:, id:, other_resource_id: nil)
        request(
          http_method: :get,
          operation: :custom,
          session: session,
          ids: { id: id, other_resource_id: other_resource_id },
        )
      end
    end
  end
end
