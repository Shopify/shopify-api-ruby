# frozen_string_literal: true

module ShopifyAPI
  module Ping
    class Conversation < Base
      self.prefix = "/admin/api/ping-api/v1/"

      def send_message(message_attrs)
        message = ShopifyAPI::Ping::Message.new(
          message_attrs.merge(conversation_id: id)
        )

        message.save
        message
      end

      def successful_delivery(message_id:, delivery_timestamp:)
        delivery_details = ShopifyAPI::Ping::DeliveryConfirmation.new(
          conversation_id: id,
          message_id: message_id,
          delivery_confirmation_details: {
            delivered: true,
            confirmation_timestamp: delivery_timestamp,
          }
        )
        delivery_details.save
        delivery_details
      end

      def failed_delivery(message_id:, delivery_timestamp:, details:)
        delivery_details = ShopifyAPI::Ping::DeliveryConfirmation.new(
          conversation_id: id,
          message_id: message_id,
          delivery_confirmation_details: {
            delivered: false,
            confirmation_timestamp: delivery_timestamp,
            details: details,
          }
        )
        delivery_details.save
        delivery_details
      end
    end
  end
end
