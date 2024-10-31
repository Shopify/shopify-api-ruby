# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Webhooks
    class Registration
      extend T::Sig
      extend T::Helpers
      abstract!

      FIELDS_DELIMITER = ","

      sig { returns(String) }
      attr_reader :topic

      sig { returns(T.nilable(T.any(Handler, WebhookHandler))) }
      attr_reader :handler

      sig { returns(T.nilable(T::Array[String])) }
      attr_reader :fields

      sig { returns(T.nilable(T::Array[String])) }
      attr_reader :metafield_namespaces

      sig do
        params(topic: String, path: String, handler: T.nilable(T.any(Handler, WebhookHandler)),
          fields: T.nilable(T.any(String, T::Array[String])),
          metafield_namespaces: T.nilable(T::Array[String])).void
      end
      def initialize(topic:, path:, handler: nil, fields: nil, metafield_namespaces: nil)
        @topic = T.let(topic.gsub("/", "_").upcase, String)
        @path = path
        @handler = handler
        fields_array = fields.is_a?(String) ? fields.split(FIELDS_DELIMITER) : fields
        @fields = T.let(fields_array&.map(&:strip)&.compact, T.nilable(T::Array[String]))
        @metafield_namespaces = T.let(metafield_namespaces&.map(&:strip)&.compact, T.nilable(T::Array[String]))
      end

      sig { abstract.returns(String) }
      def callback_address; end

      sig { abstract.returns(T::Hash[Symbol, String]) }
      def subscription_args; end

      sig { abstract.params(webhook_id: T.nilable(String)).returns(String) }
      def mutation_name(webhook_id); end

      sig { abstract.returns(String) }
      def build_check_query; end

      sig do
        params(body: T::Hash[String, T.untyped]).returns({
          webhook_id: T.nilable(String),
          current_address: T.nilable(String),
          fields: T::Array[String],
          metafield_namespaces: T::Array[String],
        })
      end
      def parse_check_result(body)
        edges = body.dig("data", "webhookSubscriptions", "edges") || {}
        webhook_id = nil
        fields = []
        metafield_namespaces = []
        unless edges.empty?
          node = edges[0]["node"]
          webhook_id = node["id"].to_s
          fields = node["includeFields"] || []
          metafield_namespaces = node["metafieldNamespaces"] || []
        end
        { webhook_id: webhook_id, current_address: nil, fields: fields,
          metafield_namespaces: metafield_namespaces, }
      end

      sig { params(webhook_id: T.nilable(String)).returns(String) }
      def build_register_query(webhook_id: nil)
        identifier = webhook_id ? "id: \"#{webhook_id}\"" : "topic: #{@topic}"

        subscription_args_string = subscription_args.map do |k, v|
          "#{k}: #{[:includeFields, :metafieldNamespaces].include?(k) ? v : %("#{v}")}"
        end.join(", ")

        <<~QUERY
          mutation webhookSubscription {
            #{mutation_name(webhook_id)}(#{identifier}, webhookSubscription: {#{subscription_args_string}}) {
              userErrors {
                field
                message
              }
              webhookSubscription {
                #{subscription_response_attributes.join("\n      ")}
              }
            }
          }
        QUERY
      end

      private

      sig { returns(T::Array[String]) }
      def subscription_response_attributes
        attributes = ["id"]
        attributes << "includeFields" if @fields
        attributes << "metafieldNamespaces" if @metafield_namespaces
        attributes
      end
    end
  end
end
