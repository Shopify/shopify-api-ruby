module ShopifyAPI
  class FulfillmentOrder < Base
    init_prefix :order

    def order_id
      @prefix_options[:order_id]
    end

    def self.with_assigned_status(assigned_status: nil, location_ids: nil)
      options = { assigned_status: assigned_status, location_ids: location_ids }.compact
      load_attributes_from_response(get("../assigned_fulfillment_orders", options))
    end

    def cancel
      load_attributes_from_response(post(:cancel, {}, only_id))
    end

    def close
      load_attributes_from_response(post(:close, {}, only_id))
    end

    def move(new_location_id:)
      body = { new_location_id: new_location_id }
      load_attributes_from_response(post(:move, {}, body))
    end

    def new_fulfillment_request(message:, fulfillment_order_line_items:)
      body = { message: message, fulfillment_order_line_items: fulfillment_order_line_items }
      load_attributes_from_response(post('fulfillment_request', {}, body))
    end

    def accept_fulfillment_request
      load_attributes_from_response(post('fulfillment_request/accept', {}, only_id))
    end

    def reject_fulfillment_request
      load_attributes_from_response(post('fulfillment_request/reject', {}, only_id))
    end

    def new_cancellation_request(message:)
      body = { message: message }
      load_attributes_from_response(post('cancellation_request', {}, body))
    end

    def accept_cancellation_request
      load_attributes_from_response(post('cancellation_request/accept', {}, only_id))
    end

    def reject_cancellation_request
      load_attributes_from_response(post('cancellation_request/reject', {}, only_id))
    end
  end
end
