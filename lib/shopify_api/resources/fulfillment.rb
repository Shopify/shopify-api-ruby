# frozen_string_literal: true
module ShopifyAPI
  class Fulfillment < Base
    init_prefix :order

    def order_id
      @prefix_options[:order_id]
    end

    def cancel
      load_attributes_from_response(post(:cancel, {}, only_id))
    end

    def complete
      load_attributes_from_response(post(:complete, {}, only_id))
    end

    def open
      load_attributes_from_response(post(:open, {}, only_id))
    end

    def order_id=(order_id)
      prefix_options[:order_id] = order_id
    end

    def load(attributes, remove_root = false, persisted = false)
      order_id = attributes['order_id']
      prefix_options[:order_id] = order_id if order_id
      super(attributes, remove_root, persisted)
    end

    def save
      if prefix_options[:order_id].present?
        super
      else
        line_items = attributes['line_items_by_fulfillment_order'] || attributes[:line_items_by_fulfillment_order]
        if line_items.blank?
          raise ShopifyAPI::ValidationException,
                "either 'line_items_by_fulfillment_order' or prefix_options[:order_id] is required"
        end

        fulfillmentV2 = FulfillmentV2.new(attributes)
        result = fulfillmentV2.save
        load(fulfillmentV2.attributes, false, true)
        result
      end
    end

    def update_tracking(tracking_info:, notify_customer:)
      fulfillmentV2 = FulfillmentV2.new(attributes)
      result = fulfillmentV2.update_tracking(tracking_info: tracking_info, notify_customer: notify_customer)
      load(fulfillmentV2.attributes, false, true)
      result
    end
  end
end
