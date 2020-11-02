# frozen_string_literal: true
module ShopifyAPI
  class AssignedFulfillmentOrder < Base
    def initialize(attributes = {}, persisted = false)
      ShopifyAPI::Base.version_validation!(FulfillmentOrder::MINIMUM_VERSION)
      super(attributes, persisted)
    end

    def self.find(scope, *args)
      ShopifyAPI::Base.version_validation!(FulfillmentOrder::MINIMUM_VERSION)

      assigned_fulfillment_orders = super(scope, *args)
      assigned_fulfillment_orders.map { |afo| FulfillmentOrder.new(afo.attributes) }
    end
  end
end
