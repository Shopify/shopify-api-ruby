# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Webhooks
    module Registrations
      class Http < Registration
        extend T::Sig

        sig { override.returns(String) }
        def callback_address
          if @path.match?(%r{^https://})
            @path
          elsif @path.match?(/^#{Context.host_name}/)
            "https://#{@path}"
          else
            "https://#{Context.host_name}/#{@path}"
          end
        end

        sig { override.returns(T::Hash[Symbol, String]) }
        def subscription_args
          { callbackUrl: callback_address, includeFields: fields }.compact
        end

        sig { override.params(webhook_id: T.nilable(String)).returns(String) }
        def mutation_name(webhook_id)
          webhook_id ? "webhookSubscriptionUpdate" : "webhookSubscriptionCreate"
        end

        sig { override.returns(String) }
        def build_check_query
          <<~QUERY
            {
              webhookSubscriptions(first: 1, topics: #{@topic}) {
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

        sig { override.params(body: T::Hash[String, T.untyped]).returns(T::Hash[Symbol, String]) }
        def parse_check_result(body)
          edges = body.dig("data", "webhookSubscriptions", "edges") || {}
          webhook_id = nil
          current_address = nil
          unless edges.empty?
            node = edges[0]["node"]
            webhook_id = node["id"].to_s
            current_address =
              if node.key?("endpoint")
                node["endpoint"]["callbackUrl"].to_s
              else
                node["callbackUrl"].to_s
              end
          end
          { webhook_id: webhook_id, current_address: current_address }
        end
      end
    end
  end
end
