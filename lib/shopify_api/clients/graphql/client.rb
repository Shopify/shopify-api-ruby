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
          # 2. Cache the loaded schemas for each version of the API?
          # It might not be performant to load the schema on every new instance of the client
          schema = GraphQL::Client.load_schema("data/graphql_schemas/#{api_name}/#{@api_version}.json")
          @graphql_client = GraphQL::Client.new(schema: schema, execute: self)

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

        # **************
        # Adaptor for graphql-client gem
        # graphql-client comes default with basic Net::HTTP adaptor for us to use,
        # We can specify the HTTP client by ovriding this method and
        # passing the http execution object into the client constructor:
        #   GraphQL::Client.new(schema: schema, execute: self)
        # https://github.com/github/graphql-client/blob/master/guides/remote-queries.md
        # This way we can still use our shared HTTPClient for setting headers, error handling and logging
        # TODO: GRAPHQL_TODO
        #   Determine if this is the best appoach, should we create a seperate adaptor class, etc
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
