# frozen_string_literal: true
require 'graphql/client'
require 'shopify_api/graphql/http_client'

module ShopifyAPI
  module GraphQL
    DEFAULT_SCHEMA_LOCATION_PATH = Pathname('shopify_graphql_schemas')
    DEFAULT_EXECUTION_ADAPTER = HTTPClient
    DEFAULT_GRAPHQL_CLIENT = ::GraphQL::Client

    InvalidSchema = Class.new(StandardError)
    InvalidClient = Class.new(StandardError)

    class << self
      delegate :parse, :query, to: :client

      def client(api_version = ShopifyAPI::Base.api_version.handle)
        initialize_client_cache
        cached_client = @_client_cache[api_version]

        if cached_client
          cached_client
        else
          schema_file = schema_location.join("#{api_version}.json")

          if !schema_file.exist?
            raise InvalidClient, <<~MSG
              Client for API version #{api_version} does not exist because no schema file exists at `#{schema_file}`.

              To dump the schema file, use the `rake shopify_api:graphql:dump` task.
            MSG
          else
            puts(
              '[WARNING] Client was not pre-initialized. Ensure `ShopifyAPI::GraphQL.initialize_clients` ' \
                'is called during app initialization.'
            )
            initialize_clients
            @_client_cache[api_version]
          end
        end
      end

      def clear_clients
        @_client_cache = {}
      end

      def initialize_clients(raise_on_invalid_schema: true)
        initialize_client_cache

        Dir.glob(schema_location.join("*.json")).each do |schema_file|
          schema_file = Pathname(schema_file)
          matches = schema_file.basename.to_s.match(/^#{ShopifyAPI::ApiVersion::HANDLE_FORMAT}\.json$/)

          if matches
            api_version = ShopifyAPI::ApiVersion.new(handle: matches[1])
          else
            if raise_on_invalid_schema
              raise InvalidSchema,
                "Invalid schema file name `#{schema_file}`. Does not match format of: `<version>.json`."
            else
              next
            end
          end

          schema = graphql_client.load_schema(schema_file.to_s)
          client = graphql_client.new(schema: schema, execute: execution_adapter.new(api_version)).tap do |c|
            c.allow_dynamic_queries = true
          end

          @_client_cache[api_version.handle] = client
        end
      end

      def schema_location
        @schema_location || DEFAULT_SCHEMA_LOCATION_PATH
      end

      def schema_location=(path)
        @schema_location = Pathname(path)
      end

      def execution_adapter
        @execution_adapter || DEFAULT_EXECUTION_ADAPTER
      end

      def execution_adapter=(executor)
        @execution_adapter = executor
      end

      def graphql_client
        @graphql_client || DEFAULT_GRAPHQL_CLIENT
      end

      def graphql_client=(client)
        @graphql_client = client
      end

      private

      def initialize_client_cache
        @_client_cache ||= {}
      end
    end
  end
end
