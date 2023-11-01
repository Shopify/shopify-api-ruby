# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Clients
    module Graphql
      class Client
        extend T::Sig

        sig { params(session: T.nilable(Auth::Session), base_path: String, api_version: T.nilable(String)).void }
        def initialize(session:, base_path:, api_version: nil)
          @http_client = T.let(HttpClient.new(session: session, base_path: base_path), HttpClient)
          @api_version = T.let(api_version || Context.api_version, String)
          if api_version
            if api_version == Context.api_version
              Context.logger.debug("Graphql client has a redundant API version override "\
                "to the default #{Context.api_version}")
            else
              Context.logger.debug("Graphql client overriding default API version "\
                "#{Context.api_version} with #{api_version}")
            end
          end

          schema = GraphQL::Client.load_schema("data/graphql_schemas/#{@api_version}.json")
          @graphql_client = GraphQL::Client.new(schema: schema, execute: self)

          # This might be something concerning we need to do:
          # "Deprecated: Allow dynamically generated queries to be passed to Client#query."
          # "This ability will eventually be removed in future versions."
          # https://github.com/github/graphql-client/blob/master/guides/dynamic-query-error.md
          @graphql_client.allow_dynamic_queries = true
        end

        sig do
          params(
            query: String,
            variables: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            headers: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            tries: Integer,
          ).returns(GraphQL::Client::Response)
        end
        def query(query:, variables: nil, headers: nil, tries: 1)
          query = @graphql_client.parse(query)
          context = {
            headers: headers,
            tries: tries,
          }
          @graphql_client.query(query, variables: variables, context: context)
        end

        ## Adaptor for graphql-client
        def execute(document:, operation_name:, variables:, context:)
          body = {
            query: document.to_query_string,
            variables: variables,
          }
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
          response.body
        end
      end
    end
  end
end
