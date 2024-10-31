# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Webhooks
    module Registrations
      class EventBridge < Registration
        extend T::Sig

        sig { override.returns(String) }
        def callback_address
          @path
        end

        sig { override.returns(T::Hash[Symbol, String]) }
        def subscription_args
          { arn: callback_address, includeFields: fields, metafieldNamespaces: metafield_namespaces }.compact
        end

        sig { override.params(webhook_id: T.nilable(String)).returns(String) }
        def mutation_name(webhook_id)
          webhook_id ? "eventBridgeWebhookSubscriptionUpdate" : "eventBridgeWebhookSubscriptionCreate"
        end

        sig { override.returns(String) }
        def build_check_query
          <<~QUERY
            {
              webhookSubscriptions(first: 1, topics: #{@topic}) {
                edges {
                  node {
                    id
                    includeFields
                    metafieldNamespaces
                    endpoint {
                      __typename
                      ... on WebhookEventBridgeEndpoint {
                        arn
                      }
                    }
                  }
                }
              }
            }
          QUERY
        end

        sig do
          params(body: T::Hash[String, T.untyped]).returns({
            webhook_id: T.nilable(String),
            current_address: T.nilable(String),
            fields: T::Array[String],
            metafield_namespaces: T::Array[String],
          })
        end
        def parse_check_result(body)
          parse_results = super(body)
          edges = body.dig("data", "webhookSubscriptions", "edges") || {}
          unless edges.empty?
            node = edges[0]["node"]
            parse_results[:current_address] = node["endpoint"]["arn"].to_s
          end
          parse_results
        end
      end
    end
  end
end
