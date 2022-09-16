# typed: strict
# frozen_string_literal: true

module TestHelpers
  class FakeResourceWithCustomPrefix < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      { http_method: :get, operation: :get, ids: [:id], path: "fake_resource_with_custom_prefix/<id>.json" },
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    @custom_prefix = T.let("/admin/custom_prefix", String)

    sig { returns(T.nilable(Integer)) }
    attr_reader :id

    sig { returns(T.nilable(String)) }
    attr_reader :attribute

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: nil)
      super(session: session)
      @id = T.let(nil, T.nilable(Integer))
      @attribute = T.let(nil, T.nilable(String))
    end

    class << self
      sig do
        params(id: T.any(Integer, String), session: ShopifyAPI::Auth::Session, param: T.untyped,
          kwargs: T.untyped).returns(FakeResourceWithCustomPrefix)
      end
      def find(id:, session:, param: nil, **kwargs)
        T.cast(
          base_find(params: { param: param }.merge(kwargs), session: session, ids: { id: id })[0],
          FakeResourceWithCustomPrefix,
        )
      end

      sig do
        params(session: ShopifyAPI::Auth::Session, kwargs: T.untyped).returns(T::Array[FakeResourceWithCustomPrefix])
      end
      def all(session:, **kwargs)
        T.cast(
          base_find(session: session, params: kwargs),
          T::Array[FakeResourceWithCustomPrefix],
        )
      end
    end
  end
end
