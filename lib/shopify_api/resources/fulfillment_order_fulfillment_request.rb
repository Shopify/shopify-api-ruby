module ShopifyAPI
  class FulfillmentOrderFulfillmentRequest < Base
    self.resource_prefix = "orders/:order_id/fulfillments/:fulfillment_id/"
    self.collection_name = 'fulfillment_request'

    def order_id
      @prefix_options[:order_id]
    end

    def fulfillment_id
      @prefix_options[:fulfillment_id]
    end

    def accept
      load_attributes_from_response(post(:accept, {}, only_id))
    end

    def reject
      load_attributes_from_response(post(:reject, {}, only_id))
    end
  end
end
