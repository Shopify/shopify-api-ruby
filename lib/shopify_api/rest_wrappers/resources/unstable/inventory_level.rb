# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class InventoryLevel < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "inventory_levels.json"},
      {http_method: :post, operation: :adjust, ids: [], path: "inventory_levels/adjust.json"},
      {http_method: :delete, operation: :delete, ids: [], path: "inventory_levels.json"},
      {http_method: :post, operation: :connect, ids: [], path: "inventory_levels/connect.json"},
      {http_method: :post, operation: :set, ids: [], path: "inventory_levels/set.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(Integer)) }
    attr_reader :available
    sig { returns(T.nilable(Integer)) }
    attr_reader :inventory_item_id
    sig { returns(T.nilable(Integer)) }
    attr_reader :location_id
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at

    class << self
      sig do
        params(
          session: Auth::Session,
          inventory_item_id: T.untyped,
          location_id: T.untyped
        ).returns(T.untyped)
      end
      def delete(
        session:,
        inventory_item_id: nil,
        location_id: nil
      )
        request(
          http_method: :delete,
          operation: :delete,
          session: session,
          path_ids: {},
          params: {inventory_item_id: inventory_item_id, location_id: location_id},
        )
      end

      sig do
        params(
          session: Auth::Session,
          inventory_item_ids: T.untyped,
          location_ids: T.untyped,
          limit: T.untyped,
          updated_at_min: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[InventoryLevel])
      end
      def all(
        session:,
        inventory_item_ids: nil,
        location_ids: nil,
        limit: nil,
        updated_at_min: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {inventory_item_ids: inventory_item_ids, location_ids: location_ids, limit: limit, updated_at_min: updated_at_min}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[InventoryLevel])
      end

    end

    sig do
      params(
        inventory_item_id: T.untyped,
        location_id: T.untyped,
        available_adjustment: T.untyped,
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def adjust(
      inventory_item_id: nil,
      location_id: nil,
      available_adjustment: nil,
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :adjust,
        session: @session,
        path_ids: {},
        params: {inventory_item_id: inventory_item_id, location_id: location_id, available_adjustment: available_adjustment}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

    sig do
      params(
        inventory_item_id: T.untyped,
        location_id: T.untyped,
        relocate_if_necessary: T.untyped,
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def connect(
      inventory_item_id: nil,
      location_id: nil,
      relocate_if_necessary: nil,
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :connect,
        session: @session,
        path_ids: {},
        params: {inventory_item_id: inventory_item_id, location_id: location_id, relocate_if_necessary: relocate_if_necessary}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

    sig do
      params(
        inventory_item_id: T.untyped,
        location_id: T.untyped,
        available: T.untyped,
        disconnect_if_necessary: T.untyped,
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def set(
      inventory_item_id: nil,
      location_id: nil,
      available: nil,
      disconnect_if_necessary: nil,
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :set,
        session: @session,
        path_ids: {},
        params: {inventory_item_id: inventory_item_id, location_id: location_id, available: available, disconnect_if_necessary: disconnect_if_necessary}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

  end
end
