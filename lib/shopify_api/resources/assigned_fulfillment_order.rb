module ShopifyAPI
  class AssignedFulfillmentOrder < Base
    def self.all(options = {})
      assigned_fulfillment_orders = super(options)
      assigned_fulfillment_orders.map { |afo| FulfillmentOrder.new(afo.attributes) }
    end
  end
end
