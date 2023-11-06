# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  module Clients
    module Graphql
      class Client
        extend T::Sig

        sig do
          params(
            session: T.nilable(Auth::Session),
            api_name: String,
            base_path: String,
            api_version: T.nilable(String),
          ).void
        end
        def initialize(session:, api_name:, base_path:, api_version: nil)
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

          # TODO #GRAPHQL_TODO
          # 1. Schemas for stoefront would also have to be retrieved and stored to data/graphql_schemas/storefront
          # We'll need to figure out a way of either having developers pull the schemas manually in rake task similar to
          # previous versions of this gem (https://github.com/Shopify/shopify-api-ruby/blob/v9.5.1/lib/shopify_api/graphql/task.rake)
          # Or supply the schema as a part of the gem files
          #
          # 2. Cache the loaded schemas for each version of the API similar to v9 of this libary gem
          # It might not be performant to load the schema on every new instance of the client
          schema = GraphQL::Client.load_schema("data/graphql_schemas/#{api_name}/#{@api_version}.json")
          http_adapter = GraphqlClientAdapter.new(http_client: @http_client, api_version: @api_version)
          @graphql_client = GraphQL::Client.new(schema: schema, execute: http_adapter)

          # TODO #GRAPHQL_TODO
          # This might be something concerning we need to figure out:
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
          ).returns(Response)
        end
        def query(query:, variables: nil, headers: nil, tries: 1)
          # TODO: GRAPHQL_TODO
          # using graphql-client gem's parse method will validate the query is correct before sending it to the server
          # https://github.com/github/graphql-client/blob/master/guides/handling-errors.md#parsevalidation-errors
          # This also means that we won't be able to make queries that don't exist on the schema
          # Do we need to add a way to bypass validation? e.g. for experimental features, first party apps, etc?
          #   Update: Current solution is that I added `query_bypass_schema_check` method that uses our original HTTPClient
          #     method to make queries, and return HTTPResponse like before. This would make migration to the new version of library easier as well
          #     so they don't need to use the new response object if they don't want to, and can just use the new `query_bypass_schema_check`
          #     to get the same result they would've before this change.
          query = @graphql_client.parse(query)
          context = {
            headers: headers,
            tries: tries,
          }

          # TODO: GRAPHQL_TODO
          # Error handling from graphql-gem?
          # What should we do if an error is raised during these graphql-client method calls?
          response = @graphql_client.query(query, variables: variables, context: context)
          Response.new(response: response)
        end

        sig do
          params(
            query: String,
            variables: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            headers: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            tries: Integer,
          ).returns(HttpResponse)
        end
        def query_bypass_schema_check(query:, variables: nil, headers: nil, tries: 1)
          body = { query: query, variables: variables }
          puts "Making request to server through HTTPClient  -------------------"
          @http_client.request(
            HttpRequest.new(
              http_method: :post,
              path: "#{@api_version}/graphql.json",
              body: body,
              query: nil,
              extra_headers: headers,
              body_type: "application/json",
              tries: tries,
            ),
          )
        end
      end
    end
  end
end
