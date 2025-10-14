# typed: false
# frozen_string_literal: true

require_relative "../../lib/shopify_api/webhooks/handler"
module TestHelpers
  class FakeWebhookHandler
    include ShopifyAPI::Webhooks::WebhookHandler

    def initialize(handler)
      @handler = handler
    end

    def handle(data:)
      @handler.call(data)
    end
  end
end
