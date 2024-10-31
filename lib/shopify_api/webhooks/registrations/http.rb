# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Webhooks
    module Registrations
      class Http < Registration
        extend T::Sig

        sig { override.returns(String) }
        def callback_address
          if @path.match?(%r{^https?://})
            @path
          elsif @path.match?(/^#{Context.host_name}/)
            "#{Context.host_scheme}://#{@path}"
          else
            "#{Context.host}/#{@path}"
          end
        end

        sig { override.returns(T::Hash[Symbol, String]) }
        def subscription_args
          { callbackUrl: callback_address, includeFields: fields, metafieldNamespaces: metafield_namespaces }.compact
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
                    includeFields
                    metafieldNamespaces
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
              if node.key?("endpoint")
                node["endpoint"]["callbackUrl"].to_s
              else
                node["callbackUrl"].to_s
              end
          end
          parse_results
        end
      end
    end
  end
end
