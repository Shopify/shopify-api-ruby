# frozen_string_literal: true

module ShopifyAPI
  module Ping
    class DeliveryConfirmation < Base
      self.prefix = "/admin/api/ping-api/v1/conversations/:conversation_id/messages/:message_id/"
      self.collection_name = "delivery_confirmation"
    end
  end
end
