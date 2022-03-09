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

      sig { returns(T.nilable(Handler)) }
      attr_reader :handler

      sig { returns(T.nilable(T::Array[String])) }
      attr_reader :fields

      sig do
        params(topic: String, path: String, handler: T.nilable(Handler),
          fields: T.nilable(T.any(String, T::Array[String]))).void
      end
      def initialize(topic:, path:, handler: nil, fields: nil)
        @topic = T.let(topic.gsub("/", "_").upcase, String)
        @path = path
        @handler = handler
        fields_array = fields.is_a?(String) ? fields.split(FIELDS_DELIMITER) : fields
        @fields = T.let(fields_array&.map(&:strip)&.compact, T.nilable(T::Array[String]))
      end

      sig { abstract.returns(String) }
      def callback_address; end

      sig { abstract.returns(T::Hash[Symbol, String]) }
      def subscription_args; end

      sig { abstract.params(webhook_id: T.nilable(String)).returns(String) }
      def mutation_name(webhook_id); end

      sig { abstract.returns(String) }
      def build_check_query; end

      sig { abstract.params(body: T::Hash[String, T.untyped]).returns(T::Hash[Symbol, String]) }
      def parse_check_result(body); end

      sig { params(webhook_id: T.nilable(String)).returns(String) }
      def build_register_query(webhook_id: nil)
        identifier = webhook_id ? "id: \"#{webhook_id}\"" : "topic: #{@topic}"

        subscription_args_string = subscription_args.map do |k, v|
          "#{k}: #{k == :includeFields ? v : '"' + v + '"'}"
        end.join(", ")

        <<~QUERY
          mutation webhookSubscription {
            #{mutation_name(webhook_id)}(#{identifier}, webhookSubscription: {#{subscription_args_string}}) {
              userErrors {
                field
                message
              }
              webhookSubscription {
                id#{@fields.nil? ? "" : "\n      includeFields"}
              }
            }
          }
        QUERY
      end
    end
  end
end
