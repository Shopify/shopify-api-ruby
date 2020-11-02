# frozen_string_literal: true
module ShopifyAPI
  class FulfillmentV2 < Base
    self.element_name = 'fulfillment'

    def initialize(attributes = {}, persisted = false)
      ShopifyAPI::Base.version_validation!(FulfillmentOrder::MINIMUM_VERSION)
      super(attributes, persisted)
    end

    def update_tracking(tracking_info:, notify_customer:)
      body = {
        fulfillment: {
          tracking_info: tracking_info,
          notify_customer: notify_customer,
        },
      }
      load_attributes_from_response(post(:update_tracking, {}, body.to_json))
    end
  end
end
