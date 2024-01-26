# typed: false
# frozen_string_literal: true

require_relative "../../lib/shopify_api/webhooks/handler"

module TestHelpers
  class FakeWebhookHandler
    include ShopifyAPI::Webhooks::Handler

    def initialize(handler)
      @handler = handler
    end

    def handle(topic:, shop:, body:)
      @handler.call(topic, shop, body)
    end
  end
end
