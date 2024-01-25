# typed: false
# frozen_string_literal: true

module TestHelpers
  class NewFakeWebhookHandler
    include ShopifyAPI::Webhooks::WebhookHandler

    def initialize(handler)
      @handler = handler
    end

    def handle(data:)
      @handler.call(data)
    end
  end
end
