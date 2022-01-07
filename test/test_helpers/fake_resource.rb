# typed: strict
# frozen_string_literal: true

module TestHelpers
  class FakeResource < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @has_one = T.let({
      has_one_attribute: FakeResource,
    }, T::Hash[Symbol, Class])

    @has_many = T.let({
      has_many_attribute: FakeResource,
    }, T::Hash[Symbol, Class])

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: nil)
      super(session: session)
      @id = T.let(nil, T.nilable(Integer))
      @attribute = T.let("", String)
      @has_one_attribute = T.let(nil, T.nilable(FakeResource))
      @has_many_attribute = T.let(nil, T.nilable(T::Array[FakeResource]))
    end

    sig { returns(T.nilable(Integer)) }
    attr_accessor :id

    sig { returns(String) }
    attr_accessor :attribute

    sig { returns(T.nilable(FakeResource)) }
    attr_accessor :has_one_attribute

    sig { returns(T.nilable(T::Array[FakeResource])) }
    attr_accessor :has_many_attribute

    class << self
      sig do
        override.params(operation: Symbol, entity: T.nilable(ShopifyAPI::RestWrappers::Base),
          ids: T::Hash[Symbol, T.any(Integer, String)]).returns(String)
      end
      def get_path(operation:, entity: nil, ids: {})
        entity = T.cast(entity, T.nilable(FakeResource))

        key = "#{operation} #{ids.keys.sort!.join(" ")}".rstrip
        {
          "get" => "fake_resources.json",
          "post" => "fake_resources.json",
          "get id" => "fake_resources/#{ids[:id]}.json",
          "put" => "fake_resources/#{entity&.id}.json",
          "delete" => "fake_resources/#{entity&.id}.json",
        }[key]
      end

      sig do
        params(id: T.any(Integer, String), session: ShopifyAPI::Auth::Session, param: T.untyped).returns(FakeResource)
      end
      def find(id:, session:, param: nil)
        T.cast(base_find(params: { param: param }, session: session, ids: { id: id })[0], FakeResource)
      end

      sig { params(session: ShopifyAPI::Auth::Session).returns(T::Array[FakeResource]) }
      def all(session:)
        T.cast(base_find(session: session), T::Array[FakeResource])
      end
    end
  end
end
