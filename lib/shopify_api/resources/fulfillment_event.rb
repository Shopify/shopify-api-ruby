# frozen_string_literal: true
module ShopifyAPI
  class FulfillmentEvent < Base
    self.resource_prefix = "orders/:order_id/fulfillments/:fulfillment_id/"
    self.collection_name = 'events'
    self.element_name = 'event'

    def order_id
      @prefix_options[:order_id]
    end

    def fulfillment_id
      @prefix_options[:fulfillment_id]
    end
  end
end
