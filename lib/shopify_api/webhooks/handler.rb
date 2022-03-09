# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Webhooks
    module Handler
      extend T::Sig
      extend T::Helpers
      interface!

      sig { abstract.params(topic: String, shop: String, body: T::Hash[String, T.untyped]).void }
      def handle(topic:, shop:, body:); end
    end
  end
end
