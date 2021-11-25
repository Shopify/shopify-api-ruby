# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Webhooks
    module Registrations
      class PubSub < Registration
        extend T::Sig

        sig { override.params(path: String).returns(String) }
        def callback_address(path)
          path
        end

        sig { override.params(webhook_id: T.nilable(String)).returns(String) }
        def mutation_name(webhook_id)
          webhook_id ? "pubSubWebhookSubscriptionUpdate" : "pubSubWebhookSubscriptionCreate"
        end

        sig { override.params(topic: String).returns(String) }
        def build_check_query(topic)
          <<~QUERY
            {
              webhookSubscriptions(first: 1, topics: #{topic}) {
                edges {
                  node {
                    id
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
      end
    end
  end
end
