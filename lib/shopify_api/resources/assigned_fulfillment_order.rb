module ShopifyAPI
  class AssignedFulfillmentOrder < Base
    init_prefix :order

    def order_id
      @prefix_options[:order_id]
    end
  end
end
