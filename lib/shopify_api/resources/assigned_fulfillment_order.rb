module ShopifyAPI
  class AssignedFulfillmentOrder < Base
    def self.find(scope, *args)
      assigned_fulfillment_orders = super(scope, *args)
      assigned_fulfillment_orders.map { |afo| FulfillmentOrder.new(afo.attributes) }
    end
  end
end
