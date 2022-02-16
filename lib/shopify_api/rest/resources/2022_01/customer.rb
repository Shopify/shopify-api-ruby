# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Customer < ShopifyAPI::Rest::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({
      currency: Currency,
      metafield: Metafield
    }, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "customers.json"},
      {http_method: :post, operation: :post, ids: [], path: "customers.json"},
      {http_method: :get, operation: :search, ids: [], path: "customers/search.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "customers/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "customers/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "customers/<id>.json"},
      {http_method: :post, operation: :account_activation_url, ids: [:id], path: "customers/<id>/account_activation_url.json"},
      {http_method: :post, operation: :send_invite, ids: [:id], path: "customers/<id>/send_invite.json"},
      {http_method: :get, operation: :count, ids: [], path: "customers/count.json"},
      {http_method: :get, operation: :orders, ids: [:id], path: "customers/<id>/orders.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :accepts_marketing
    sig { returns(T.nilable(String)) }
    attr_reader :accepts_marketing_updated_at
    sig { returns(T.nilable(T::Array[Hash])) }
    attr_reader :addresses
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(Currency)) }
    attr_reader :currency
    sig { returns(T.nilable(Hash)) }
    attr_reader :default_address
    sig { returns(T.nilable(String)) }
    attr_reader :email
    sig { returns(T.nilable(String)) }
    attr_reader :first_name
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :last_name
    sig { returns(T.nilable(Integer)) }
    attr_reader :last_order_id
    sig { returns(T.nilable(String)) }
    attr_reader :last_order_name
    sig { returns(T.nilable(String)) }
    attr_reader :marketing_opt_in_level
    sig { returns(T.nilable(Metafield)) }
    attr_reader :metafield
    sig { returns(T.nilable(String)) }
    attr_reader :multipass_identifier
    sig { returns(T.nilable(String)) }
    attr_reader :note
    sig { returns(T.nilable(Integer)) }
    attr_reader :orders_count
    sig { returns(T.nilable(String)) }
    attr_reader :phone
    sig { returns(T.nilable(Hash)) }
    attr_reader :sms_marketing_consent
    sig { returns(T.nilable(String)) }
    attr_reader :state
    sig { returns(T.nilable(String)) }
    attr_reader :tags
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :tax_exempt
    sig { returns(T.nilable(T::Array[String])) }
    attr_reader :tax_exemptions
    sig { returns(T.nilable(String)) }
    attr_reader :total_spent
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :verified_email

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          fields: T.untyped
        ).returns(T.nilable(Customer))
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
        T.cast(result[0], T.nilable(Customer))
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
          ids: T.untyped,
          since_id: T.untyped,
          created_at_min: T.untyped,
          created_at_max: T.untyped,
          updated_at_min: T.untyped,
          updated_at_max: T.untyped,
          limit: T.untyped,
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[Customer])
      end
      def all(
        session:,
        ids: nil,
        since_id: nil,
        created_at_min: nil,
        created_at_max: nil,
        updated_at_min: nil,
        updated_at_max: nil,
        limit: nil,
        fields: nil,
        **kwargs
      )
        response = base_find(
          session: session,
          ids: {},
          params: {ids: ids, since_id: since_id, created_at_min: created_at_min, created_at_max: created_at_max, updated_at_min: updated_at_min, updated_at_max: updated_at_max, limit: limit, fields: fields}.merge(kwargs).compact,
        )

        T.cast(response, T::Array[Customer])
      end

      sig do
        params(
          session: Auth::Session,
          order: T.untyped,
          query: T.untyped,
          limit: T.untyped,
          fields: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def search(
        session:,
        order: nil,
        query: nil,
        limit: nil,
        fields: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :search,
          session: session,
          ids: {},
          params: {order: order, query: query, limit: limit, fields: fields}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
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
          ids: {},
          params: {}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def orders(
        session:,
        id:,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :orders,
          session: session,
          ids: {id: id},
          params: {}.merge(kwargs).compact,
          body: {},
          entity: nil,
        )
      end

    end

    sig do
      params(
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def account_activation_url(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :account_activation_url,
        session: @session,
        ids: {id: @id},
        params: {}.merge(kwargs).compact,
        body: body,
        entity: self,
      )
    end

    sig do
      params(
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def send_invite(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :send_invite,
        session: @session,
        ids: {id: @id},
        params: {}.merge(kwargs).compact,
        body: body,
        entity: self,
      )
    end

  end
end
