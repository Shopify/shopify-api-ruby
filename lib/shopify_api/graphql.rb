require 'graphql/client'
require 'shopify_api/graphql/http_client'

module ShopifyAPI
  module GraphQL
    DEFAULT_SCHEMA_LOCATION_PATH = Pathname('shopify_graphql_schemas')
    VERSION = '2020-04'.freeze

    InvalidSchema = Class.new(StandardError)
    InvalidClient = Class.new(StandardError)

    class << self
      delegate :parse, :query, to: :client

      def client_cache
        @_client_cache
      end

      def client_cache_exists?(shop_id)
        client_cache.keys.any? do |key|
          id, version = key.split('_')
          id.to_i == shop_id && version == VERSION
        end
      end

      def client(shop_id = nil, api_version = VERSION)
        initialize_client_cache
        cached_client = @_client_cache["#{shop_id}_#{api_version}"] || @_client_cache[api_version.to_s]

        if cached_client
          cached_client
        else
          schema_file = schema_location.join("#{api_version}.json")

          unless schema_file.exist?
            raise InvalidClient, <<~MSG
              Client for API version #{api_version} does not exist because no schema file exists at `#{schema_file}`.
              To dump the schema file, use the `rake shopify_api:graphql:dump` task.
            MSG
          else
            puts '[WARNING] Client was not pre-initialized. Ensure `ShopifyAPI::GraphQL.initialize_clients` is called during app initialization.'
            initialize_clients
            @_client_cache[api_version]
          end
        end
      end

      def clear_clients
        @_client_cache = {}
      end

      def initialize_clients
        initialize_client_cache

        Dir.glob(schema_location.join('*.json')).each do |schema_file|
          schema_file = Pathname(schema_file)

          shop_id, api_version = schema_file.basename.to_s.split('.').first.split('_')

          if api_version.blank?
            api_version = shop_id
            shop_id = nil
          end

          next if api_version != VERSION

          initialize_client shop_id, schema_file
        end
      end

      def initialize_client(shop_id, schema_file)
        schema = ::GraphQL::Client.load_schema(schema_file.to_s)
        client = ::GraphQL::Client.new(schema: schema, execute: HTTPClient.new(VERSION)).tap do |c|
          c.allow_dynamic_queries = true
        end
        initialize_client_cache
        key = [shop_id, VERSION].compact.join('_')
        @_client_cache[key] = client
      end

      def schema_location
        @schema_location || DEFAULT_SCHEMA_LOCATION_PATH
      end

      def schema_location=(path)
        @schema_location = Pathname(path)
      end

      def load_schema(shop_id, shop_domain, access_token)
        shopify_session = ShopifyAPI::Session.new(shop_domain, access_token)
        ShopifyAPI::Base.activate_session(shopify_session)

        klient = ShopifyAPI::GraphQL::HTTPClient.new(VERSION)
        document = ::GraphQL.parse('{ __schema { queryType { name } } }')
        response = klient.execute(document: document).to_h

        if response['data'].blank?
          puts 'Error: failed to query the API.'
          puts "Response: #{response}"
          puts 'Ensure your SHOP_DOMAIN or SHOP_URL are valid and you have valid authentication credentials.'
          return
        end

        schema_location = ShopifyAPI::GraphQL.schema_location
        FileUtils.mkdir_p(schema_location) unless Dir.exist?(schema_location)

        schema_file = schema_location.join("#{shop_id}_#{VERSION}.json")
        ::GraphQL::Client.dump_schema(klient, schema_file.to_s)

        initialize_client shop_id, schema_file

        puts "Wrote file #{schema_file}"
      end

      private

      def initialize_client_cache
        @_client_cache ||= {}
      end
    end
  end
end