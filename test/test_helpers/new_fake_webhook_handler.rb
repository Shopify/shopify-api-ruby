# typed: false
# frozen_string_literal: true

module TestHelpers
  class NewFakeWebhookHandler
    include ShopifyAPI::Webhooks::Handler

    def initialize(handler)
      @handler = handler
    end

    def handle(topic:, shop:, body:)
      @handler.call(topic, shop, body)
    end

    def handle_webhook(data)
      @handler.call(data)
    end

    def use_handle_webhook?
      true
    end
  end
end
