# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Webhooks
    module Registrations
      class PubSub < Registration
        extend T::Sig

        sig { override.returns(String) }
        def callback_address
          @path
        end

        sig { override.returns(T::Hash[Symbol, String]) }
        def subscription_args
          project_topic_pair = callback_address.gsub(%r{^pubsub://}, "").split(":")
          project = project_topic_pair[0]
          topic = project_topic_pair[1]
          { pubSubProject: project, pubSubTopic: topic, includeFields: fields,
            metafieldNamespaces: metafield_namespaces, }.compact
        end

        sig { override.params(webhook_id: T.nilable(String)).returns(String) }
        def mutation_name(webhook_id)
          webhook_id ? "pubSubWebhookSubscriptionUpdate" : "pubSubWebhookSubscriptionCreate"
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
                      ... on WebhookPubSubEndpoint {
                        pubSubProject
                        pubSubTopic
                      }
                    }
                  }
                }
              }
            }
          QUERY
        end

        sig { override.params(body: T::Hash[String, T.untyped]).returns(T::Hash[Symbol, T.untyped]) }
        def parse_check_result(body)
          edges = body.dig("data", "webhookSubscriptions", "edges") || {}
          webhook_id = nil
          current_address = nil
          fields = nil
          metafield_namespaces = nil
          unless edges.empty?
            node = edges[0]["node"]
            webhook_id = node["id"].to_s
            current_address = "pubsub://#{node["endpoint"]["pubSubProject"]}:#{node["endpoint"]["pubSubTopic"]}"
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
