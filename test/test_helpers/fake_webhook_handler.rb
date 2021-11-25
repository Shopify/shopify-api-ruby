# typed: strict
# frozen_string_literal: true

module TestHelpers
  module FakeWebhookHandler
    extend ShopifyAPI::Webhooks::Handler

    class << self
      extend T::Sig

      sig { override.params(topic: String, shop: String, body: T::Hash[String, T.untyped]).void }
      def handle(topic:, shop:, body:)
      end
    end
  end
end
