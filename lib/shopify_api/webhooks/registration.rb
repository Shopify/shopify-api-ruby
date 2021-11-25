# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Webhooks
    class Registration
      extend T::Sig
      extend T::Helpers
      abstract!

      sig { returns(String) }
      attr_reader :topic

      sig { returns(T.nilable(Handler)) }
      attr_reader :handler

      sig { params(topic: String, path: String, handler: T.nilable(Handler)).void }
      def initialize(topic:, path:, handler: nil)
        @topic = topic
        @path = path
        @handler = handler
      end

      sig { abstract.params(path: String).returns(String) }
      def callback_address(path); end

      sig { abstract.params(webhook_id: T.nilable(String)).returns(String) }
      def mutation_name(webhook_id); end

      sig { abstract.params(topic: String).returns(String) }
      def build_check_query(topic); end

      sig { params(topic: String, callback_address: String, webhook_id: T.nilable(String)).returns(String) }
      def build_register_query(topic:, callback_address:, webhook_id: nil)
        identifier = webhook_id ? "id: \"#{webhook_id}\"" : "topic: #{topic}"
        subscription_args = "{callbackUrl: \"#{callback_address}\"}"

        <<~QUERY
          mutation webhookSubscription {
            #{mutation_name(webhook_id)}(#{identifier}, webhookSubscription: #{subscription_args}) {
              userErrors {
                field
                message
              }
              webhookSubscription {
                id
              }
            }
          }
        QUERY
      end
    end
  end
end
