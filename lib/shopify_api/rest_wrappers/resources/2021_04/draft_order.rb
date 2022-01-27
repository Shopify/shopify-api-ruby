# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class DraftOrder < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({
      customer: Customer,
      currency: Currency
    }, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :post, operation: :post, ids: [], path: "draft_orders.json"},
      {http_method: :get, operation: :get, ids: [], path: "draft_orders.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "draft_orders/<id>.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "draft_orders/<id>.json"},
      {http_method: :delete, operation: :delete, ids: [:id], path: "draft_orders/<id>.json"},
      {http_method: :get, operation: :count, ids: [], path: "draft_orders/count.json"},
      {http_method: :post, operation: :send_invoice, ids: [:id], path: "draft_orders/<id>/send_invoice.json"},
      {http_method: :put, operation: :complete, ids: [:id], path: "draft_orders/<id>/complete.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(Hash)) }
    attr_reader :applied_discount
    sig { returns(T.nilable(Hash)) }
    attr_reader :billing_address
    sig { returns(T.nilable(String)) }
    attr_reader :completed_at
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(Currency)) }
    attr_reader :currency
    sig { returns(T.nilable(Customer)) }
    attr_reader :customer
    sig { returns(T.nilable(String)) }
    attr_reader :email
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :invoice_sent_at
    sig { returns(T.nilable(String)) }
    attr_reader :invoice_url
    sig { returns(T.nilable(Hash)) }
    attr_reader :line_items
    sig { returns(T.nilable(String)) }
    attr_reader :name
    sig { returns(T.nilable(String)) }
    attr_reader :note
    sig { returns(T.nilable(T::Array[Hash])) }
    attr_reader :note_attributes
    sig { returns(T.nilable(Integer)) }
    attr_reader :order_id
    sig { returns(T.nilable(Hash)) }
    attr_reader :shipping_address
    sig { returns(T.nilable(Hash)) }
    attr_reader :shipping_line
    sig { returns(T.nilable(String)) }
    attr_reader :status
    sig { returns(T.nilable(Float)) }
    attr_reader :subtotal_price
    sig { returns(T.nilable(String)) }
    attr_reader :tags
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :tax_exempt
    sig { returns(T.nilable(T::Array[String])) }
    attr_reader :tax_exemptions
    sig { returns(T.nilable(T::Array[Hash])) }
    attr_reader :tax_lines
    sig { returns(T.nilable(T::Boolean)) }
    attr_reader :taxes_included
    sig { returns(T.nilable(String)) }
    attr_reader :total_price
    sig { returns(T.nilable(String)) }
    attr_reader :total_tax
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          fields: T.untyped
        ).returns(T.nilable(DraftOrder))
      end
      def find(
        session:,
        id:,
        fields: nil
      )
        result = base_find(
          ids: {id: id},
          params: {fields: fields},
          session: session,
        )
        T.cast(result[0], T.nilable(DraftOrder))
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
          fields: T.untyped,
          limit: T.untyped,
          since_id: T.untyped,
          updated_at_min: T.untyped,
          updated_at_max: T.untyped,
          ids: T.untyped,
          status: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[DraftOrder])
      end
      def all(
        session:,
        fields: nil,
        limit: nil,
        since_id: nil,
        updated_at_min: nil,
        updated_at_max: nil,
        ids: nil,
        status: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {fields: fields, limit: limit, since_id: since_id, updated_at_min: updated_at_min, updated_at_max: updated_at_max, ids: ids, status: status}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[DraftOrder])
      end

      sig do
        params(
          session: Auth::Session,
          since_id: T.untyped,
          status: T.untyped,
          updated_at_max: T.untyped,
          updated_at_min: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        since_id: nil,
        status: nil,
        updated_at_max: nil,
        updated_at_min: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          path_ids: {},
          params: {since_id: since_id, status: status, updated_at_max: updated_at_max, updated_at_min: updated_at_min}.merge(kwargs).compact,
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
    def send_invoice(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :send_invoice,
        session: @session,
        path_ids: {id: @id},
        params: {}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

    sig do
      params(
        payment_pending: T.untyped,
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def complete(
      payment_pending: nil,
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :put,
        operation: :complete,
        session: @session,
        path_ids: {id: @id},
        params: {payment_pending: payment_pending}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

  end
end
