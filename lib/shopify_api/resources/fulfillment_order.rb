module ShopifyAPI
  class FulfillmentOrder < Base
    init_prefix :order

    def order_id
      @prefix_options[:order_id]
    end

    def cancel; load_attributes_from_response(post(:cancel, {}, only_id)); end
    def close; load_attributes_from_response(post(:close, {}, only_id)); end

    def move(new_location_id:)
      body = { new_location_id: new_location_id }
      load_attributes_from_response(post(:move, {}, body))
    end
  end
end
