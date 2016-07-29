module ShopifyAPI
  class FulfillmentRequest < Base
    init_prefix :order

    def order_id
      @prefix_options[:order_id]
    end

    def mark_as_failed
      load_attributes_from_response(
        put(:mark_as_failed, message: failure_message)
      )
    end
  end
end
