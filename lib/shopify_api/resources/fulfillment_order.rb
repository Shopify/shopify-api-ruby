# frozen_string_literal: true
module ShopifyAPI
  class FulfillmentOrder < Base
    MINIMUM_VERSION = '2020-01'

    def initialize(attributes = {}, persisted = false)
      ShopifyAPI::Base.version_validation!(MINIMUM_VERSION)
      super(attributes, persisted)
    end

    def self.find(scope, *args)
      ShopifyAPI::Base.version_validation!(MINIMUM_VERSION)

      if scope == :all
        order_id = args.first&.dig(:params, :order_id)
        raise ShopifyAPI::ValidationException, "'order_id' is required" if order_id.blank?

        order = ::ShopifyAPI::Order.new(id: order_id)
        order.fulfillment_orders(args.first[:params].except(:order_id))
      else
        super(scope, *args)
      end
    end

    def fulfillments(options = {})
      fulfillment_hashes = get(:fulfillments, options)
      fulfillment_hashes.map { |fulfillment_hash| Fulfillment.new(fulfillment_hash) }
    end

    def locations_for_move
      locations_for_move_hashes = get(:locations_for_move, {})

      locations_for_move_hashes.map do |locations_for_move_hash|
        FulfillmentOrderLocationsForMove.new(locations_for_move_hash)
      end
    end

    def move(new_location_id:)
      body = {
        fulfillment_order: {
          new_location_id: new_location_id,
        },
      }
      keyed_fulfillment_orders = keyed_fulfillment_orders_from_response(post(:move, {}, body.to_json))
      load_keyed_fulfillment_order(keyed_fulfillment_orders, 'original_fulfillment_order')
      keyed_fulfillment_orders
    end

    def cancel
      keyed_fulfillment_orders = keyed_fulfillment_orders_from_response(post(:cancel, {}, only_id))
      load_keyed_fulfillment_order(keyed_fulfillment_orders, 'fulfillment_order')
      keyed_fulfillment_orders
    end

    def open
      load_attributes_from_response(post(:open, {}, only_id))
    end

    def reschedule(new_fulfill_at:)
      body = {
        fulfillment_order: {
          new_fulfill_at: new_fulfill_at,
        },
      }
      load_attributes_from_response(post(:reschedule, {}, body.to_json))
    end

    def close(message: nil)
      body = {
        fulfillment_order: {
          message: message,
        },
      }
      load_attributes_from_response(post(:close, {}, body.to_json))
    end

    def request_fulfillment(fulfillment_order_line_items: nil, message: nil)
      body = {
        fulfillment_request: {
          fulfillment_order_line_items: fulfillment_order_line_items,
          message: message,
        },
      }
      keyed_fulfillment_orders = keyed_fulfillment_orders_from_response(post(:fulfillment_request, {}, body.to_json))
      load_keyed_fulfillment_order(keyed_fulfillment_orders, 'original_fulfillment_order')
      keyed_fulfillment_orders
    end

    def accept_fulfillment_request(message: nil)
      body = {
        fulfillment_request: {
          message: message,
        },
      }
      load_attributes_from_response(post('fulfillment_request/accept', {}, body.to_json))
    end

    def reject_fulfillment_request(message: nil)
      body = {
        fulfillment_request: {
          message: message,
        },
      }
      load_attributes_from_response(post('fulfillment_request/reject', {}, body.to_json))
    end

    def request_cancellation(message: nil)
      body = {
        cancellation_request: {
          message: message,
        },
      }
      load_attributes_from_response(post(:cancellation_request, {}, body.to_json))
    end

    def accept_cancellation_request(message: nil)
      body = {
        cancellation_request: {
          message: message,
        },
      }
      load_attributes_from_response(post('cancellation_request/accept', {}, body.to_json))
    end

    def reject_cancellation_request(message: nil)
      body = {
        cancellation_request: {
          message: message,
        },
      }
      load_attributes_from_response(post('cancellation_request/reject', {}, body.to_json))
    end

    private

    def load_keyed_fulfillment_order(keyed_fulfillment_orders, key)
      if keyed_fulfillment_orders[key]&.attributes
        load(keyed_fulfillment_orders[key].attributes, false, true)
      end
    end

    def keyed_fulfillment_orders_from_response(response)
      return load_attributes_from_response(response) if response.code != '200'

      keyed_fulfillment_orders = ActiveSupport::JSON.decode(response.body)
      keyed_fulfillment_orders.transform_values do |fulfillment_order_attributes|
        FulfillmentOrder.new(fulfillment_order_attributes) if fulfillment_order_attributes
      end
    end
  end
end
