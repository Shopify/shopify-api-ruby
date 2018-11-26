# frozen_string_literal: true

require 'byebug'

module ShopifyAPI
  module Ping
    class Message < Base
      self.prefix = "/admin/api/ping-api/v1/conversations/:conversation_id/"

      def successful_delivery(prefix_options)
        delivery_details = ShopifyAPI::Ping::DeliveryConfirmation.new(prefix_options)
        delivery_details.save
        "true"
      end

      def failed_delivery(prefix_options)
        delivery_details = ShopifyAPI::Ping::DeliveryConfirmation.new(prefix_options)
        delivery_details.save
        delivery_details
      end
    end
  end
end
