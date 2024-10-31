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
            parse_results[:current_address] =
              "pubsub://#{node["endpoint"]["pubSubProject"]}:#{node["endpoint"]["pubSubTopic"]}"
          end
          parse_results
        end
      end
    end
  end
end
