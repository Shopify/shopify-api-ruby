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

      def messages(filter_params = {})
        ShopifyAPI::Ping::Message.find(
          :all,
          params: default_filter_params.merge(filter_params)
        )
      end

      def successful_delivery(message_id:, delivery_timestamp:)
        delivery_details = ShopifyAPI::Ping::DeliveryConfirmationDetails.new(
          delivery_attrs(message_id, delivery_timestamp).merge(delivered: true)
        )
        delivery_details.save
        delivery_details
      end

      def failed_delivery(message_id:, delivery_timestamp:, details:)
        delivery_details = ShopifyAPI::Ping::DeliveryConfirmationDetails.new(
          delivery_attrs(message_id, delivery_timestamp).merge(delivered: false, details: details)
        )
        delivery_details.save
        delivery_details
      end

      def delivery_attrs(message_id, delivery_timestamp)
        {
          conversation_id: id,
          message_id: message_id,
          confirmation_timestamp: delivery_timestamp,
        }
      end

      def default_filter_params
        {
          after: nil,
          before: nil,
          limit: 20,
          filter_by: nil,
        }
      end
    end
  end
end
