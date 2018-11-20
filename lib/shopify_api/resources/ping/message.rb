# frozen_string_literal: true
require 'byebug'
module ShopifyAPI
  module Ping
    class Message < Base
      include Metafields

      self.prefix = "/admin/api/ping-api/v1/conversations/:conversation_id/"

      def confirm(delivery_confirmation_details = ShopifyAPI::Ping::DeliveryConfirmation.new)
        resource = post(:delivery_confirmation, {}, delivery_confirmation_details.encode)
        # delivery_details = ShopifyAPI::Ping::DeliveryConfirmation.new(
        #   details
        # )

        # delivery_details.save
        # delivery_details
        ShopifyAPI::Ping::DeliveryConfirmation.new(ShopifyAPI::Ping::Message.new)
      end
    end
  end
end
