# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Webhooks
    module Registrations
      class Http < Registration
        extend T::Sig

        sig { override.params(path: String).returns(String) }
        def callback_address(path)
          "https://#{Context.host_name}/#{path}"
        end

        sig { override.params(webhook_id: T.nilable(String)).returns(String) }
        def mutation_name(webhook_id)
          webhook_id ? "webhookSubscriptionUpdate" : "webhookSubscriptionCreate"
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
                      ... on WebhookHttpEndpoint {
                        callbackUrl
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
