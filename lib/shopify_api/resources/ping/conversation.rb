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
    end
  end
end
