# typed: true
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
          # 1. Schemas for stoerfront would also have to be retrieved and stored to data/graphql_schemas/storefront
          # We'll need to figure out a way of either having developers pull the schemas manually in rake task similar to
          # previous versions of this gem (https://github.com/Shopify/shopify-api-ruby/blob/v9.5.1/lib/shopify_api/graphql/task.rake)
          # Or supply the schema as a part of the gem files
          #
          # 2. Add a repository class to cache the loaded schemas for each version of the API similar to v9 of this libary gem
          # It might not be performant to load the schema on every new instance of the client
          schema = GraphQL::Client.load_schema("data/graphql_schemas/#{api_name}/#{@api_version}.json")
          @graphql_client = GraphQL::Client.new(schema: schema)
        end

        sig do
          params(
            query: String,
            variables: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            headers: T.nilable(T::Hash[T.any(Symbol, String), T.untyped]),
            tries: Integer,
            bypass_schema_check: T::Boolean,
          ).returns(Response)
        end
        def query(query:, variables: nil, headers: nil, tries: 1, bypass_schema_check: false)
          # TODO #GRAPHQL_TODO
          # This was added so that if the schema file hasn't updated and they want to make an experimental query,
          # they can bypass the schema check and directly call the HTTPClient
          # Do we need this feature?
          query_definition = bypass_schema_check ? nil : @graphql_client.parse(query)

          http_response = make_http_request(query: query, variables: variables, headers: headers, tries: tries)

          Graphql::Response.new(response: http_response, query_definition: query_definition)
        end

        private

        def make_http_request(query:, variables:, headers:, tries:)
          body = { query: query, variables: variables }
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
