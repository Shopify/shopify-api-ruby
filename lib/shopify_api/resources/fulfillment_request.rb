module ShopifyAPI
  class FulfillmentRequest < Base
    init_prefix :order

    def order_id
      @prefix_options[:order_id]
    end

    def cancel; load_attributes_from_response(post(:cancel, {}, only_id)); end
  end
end
