module ShopifyAPI
  class FulfillmentOrder < Base
    def self.all(options = {})
      order_id = options.dig(:params, :order_id)
      raise ShopifyAPI::ValidationException, "'order_id' is required" if order_id.nil? || order_id == ''

      order = ::ShopifyAPI::Order.new(id: order_id)
      order.fulfillment_orders
    end

    def fulfillments(options = {})
      fulfillment_hashes = get(:fulfillments, options)
      fulfillment_hashes.map { |fulfillment_hash| Fulfillment.new(fulfillment_hash) }
    end
  end
end
