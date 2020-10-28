# frozen_string_literal: true
module ShopifyAPI
  class FulfillmentRequest < Base
    init_prefix :order

    def order_id
      @prefix_options[:order_id]
    end

    def mark_as_failed
      options = {}
      options[:message] = failure_message if failure_message
      load_attributes_from_response(put(:mark_as_failed, options))
    end
  end
end
