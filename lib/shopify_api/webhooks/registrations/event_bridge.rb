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

        sig { override.params(body: T::Hash[String, T.untyped]).returns(T::Hash[Symbol, String]) }
        def parse_check_result(body)
          edges = body.dig("data", "webhookSubscriptions", "edges") || {}
          webhook_id = nil
          current_address = nil
          fields = nil
          metafield_namespaces = nil
          unless edges.empty?
            node = edges[0]["node"]
            webhook_id = node["id"].to_s
            current_address = node["endpoint"]["arn"].to_s
            fields = node["includeFields"]
            metafield_namespaces = node["metafieldNamespaces"]
          end
          { webhook_id: webhook_id, current_address: current_address, fields: fields,
            metafield_namespaces: metafield_namespaces, }
        end
      end
    end
  end
end
