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

      sig { abstract.returns(String) }
      def callback_address; end

      sig { abstract.returns(String) }
      def subscription_args; end

      sig { abstract.params(webhook_id: T.nilable(String)).returns(String) }
      def mutation_name(webhook_id); end

      sig { abstract.returns(String) }
      def build_check_query; end

      sig { abstract.params(body: T::Hash[String, T.untyped]).returns(T::Hash[Symbol, String]) }
      def parse_check_result(body); end

      sig { params(topic: String, webhook_id: T.nilable(String)).returns(String) }
      def build_register_query(topic:, webhook_id: nil)
        identifier = webhook_id ? "id: \"#{webhook_id}\"" : "topic: #{topic}"

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
