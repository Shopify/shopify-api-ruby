# typed: false
# frozen_string_literal: true

module ShopifyAPI
  class RecurringApplicationCharge < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    sig { params(session: T.nilable(ShopifyAPI::Auth::Session)).void }
    def initialize(session: nil)
      super(session: session)

      @activated_on = T.let(nil, T.nilable(String))
      @billing_on = T.let(nil, T.nilable(String))
      @cancelled_on = T.let(nil, T.nilable(String))
      @capped_amount = T.let(nil, T.nilable(T.any(String, Integer)))
      @confirmation_url = T.let(nil, T.nilable(String))
      @created_at = T.let(nil, T.nilable(String))
      @id = T.let(nil, T.nilable(Integer))
      @name = T.let(nil, T.nilable(String))
      @price = T.let(nil, T.nilable(T.any(String, Float)))
      @return_url = T.let(nil, T.nilable(String))
      @status = T.let(nil, T.nilable(String))
      @terms = T.let(nil, T.nilable(String))
      @test = T.let(nil, T.nilable(T::Boolean))
      @trial_days = T.let(nil, T.nilable(Integer))
      @trial_ends_on = T.let(nil, T.nilable(String))
      @updated_at = T.let(nil, T.nilable(String))
    end

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :post, operation: :post, ids: [], path: "recurring_application_charges.json"},
      {http_method: :get, operation: :get, ids: [], path: "recurring_application_charges.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "recurring_application_charges/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "recurring_application_charges/<id>.json"},
      {http_method: :put, operation: :customize, ids: [:id], path: "recurring_application_charges/<id>/customize.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(String)) }
    attr_reader :activated_on
    sig { returns(T.nilable(String)) }
    attr_reader :billing_on
    sig { returns(T.nilable(String)) }
    attr_reader :cancelled_on
    sig { returns(T.nilable(T.any(String, Integer))) }
    attr_reader :capped_amount
    sig { returns(T.nilable(String)) }
    attr_reader :confirmation_url
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :name
    sig { returns(T.nilable(T.any(String, Float))) }
    attr_reader :price
    sig { returns(T.nilable(String)) }
    attr_reader :return_url
    sig { returns(T.nilable(String)) }
    attr_reader :status
    sig { returns(T.nilable(String)) }
    attr_reader :terms
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :test
    sig { returns(T.nilable(Integer)) }
    attr_reader :trial_days
    sig { returns(T.nilable(String)) }
    attr_reader :trial_ends_on
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          fields: T.untyped
        ).returns(T.nilable(RecurringApplicationCharge))
      end
      def find(
        session:,
        id:,
        fields: nil
      )
        result = base_find(
          session: session,
          ids: {id: id},
          params: {fields: fields},
        )
        T.cast(result[0], T.nilable(RecurringApplicationCharge))
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
          ids: {id: id},
          params: {},
        )
      end

      sig do
        params(
          session: Auth::Session,
          since_id: T.untyped,
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[RecurringApplicationCharge])
      end
      def all(
        session:,
        since_id: nil,
        fields: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {since_id: since_id, fields: fields}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[RecurringApplicationCharge])
      end

    end

    sig do
      params(
        body: T.untyped,
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def customize(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :put,
        operation: :customize,
        session: @session,
        ids: {id: @id},
        params: {}.merge(kwargs).compact,
        body: body,
        entity: self,
      )
    end

  end
end
