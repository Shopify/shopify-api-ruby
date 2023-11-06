# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Clients
    module Graphql
      class GraphqlClientAdapter
        extend T::Sig

        sig { params(http_client: HttpClient, api_version: String).void }
        def initialize(http_client:, api_version:)
          @http_client = http_client
          @api_version = api_version
        end

        # **************
        # Adaptor for graphql-client gem
        # graphql-client comes default with basic Net::HTTP adaptor for us to use,
        # We can specify the HTTP client by ovriding this method and
        # passing the http execution object into the client constructor:
        #   GraphQL::Client.new(schema: schema, execute: AdapterClass)
        # https://github.com/github/graphql-client/blob/master/guides/remote-queries.md
        # This way we can still use our shared HTTPClient for setting headers, error handling and logging
        # TODO: GRAPHQL_TODO
        #   Determine if this is the best appoach, how can we clean this up better, etc
        sig do
          params(
            document: T.untyped,
            operation_name: T.untyped,
            variables: T.untyped,
            context: T.untyped,
          ).returns(T.untyped)
        end
        def execute(document:, operation_name:, variables:, context:)
          body = {
            query: document.to_query_string,
            variables: variables,
          }
          puts "Making request to server through graphql-client ------------------"
          response = @http_client.request(
            HttpRequest.new(
              http_method: :post,
              path: "#{@api_version}/graphql.json",
              body: body,
              query: nil,
              extra_headers: context[:headers],
              body_type: "application/json",
              tries: context[:tries],
            ),
          )

          # TODO: GRAPHQL_TODO
          # This is so that we can convert graphql-client results back into our HTTPResponse class
          # By default, the graphql-client only accepts the body of the HTTP response as the output of this method,
          # but we need more data like headers to construct our response object
          # Hack is to add those data as a part of the body hash and retrieve it later for use -
          # See "lib/shopify_api/clients/graphql/reponse.rb" for its usage
          result = response.body
          extra = {
            "response_body" => response.body,
            "response_code" => response.code,
            "response_headers" => response.headers,
          }
          result.merge(extra)
        end
      end
    end
  end
end
