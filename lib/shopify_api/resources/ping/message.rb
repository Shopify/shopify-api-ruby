# frozen_string_literal: true
module ShopifyAPI
  module Ping
    class Message < Base
      self.prefix = "/admin/api/ping-api/v1/conversations/:conversation_id/"

      def confirm(details)
        delivery_details = ShopifyAPI::Ping::DeliveryConfirmation.new(details)
        delivery_details.save
        delivery_details
      end
    end
  end
end
