# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Webhooks
    module Handler
      include Kernel
      extend T::Sig
      extend T::Helpers
      abstract!

      sig do
        params(data: T::Hash[Symbol, T.untyped]).void
      end
      def handle_webhook(data)
        if use_handle_webhook?
          raise NotImplementedError, "You must implement the `handle_webhook` method in your webhook handler class."
        end
      end

      sig do
        abstract.params(topic: String, shop: String, body: T::Hash[String, T.untyped]).void
      end
      def handle(topic:, shop:, body:); end

      sig { returns(T::Boolean) }
      def use_handle_webhook?
        false
      end
    end
  end
end
