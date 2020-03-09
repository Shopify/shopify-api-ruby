# frozen_string_literal: true
require 'fileutils'

namespace :shopify_api do
  namespace :graphql do
    desc 'Dumps a local JSON schema file of the Shopify Admin API'
    task :dump do
      usage = <<~USAGE

        Usage: rake shopify_api:graphql:dump [<args>]

        Dumps a local JSON schema file of the Shopify Admin API. The schema is specific to an
        API version and authentication is required (either OAuth or private app).

        Dump the schema file for the 2020-01 API version using private app authentication:
          $ rake shopify_api:graphql:dump SHOP_URL="https://API_KEY:PASSWORD@SHOP_NAME.myshopify.com" API_VERSION=2020-01

        Dump the schema file for the unstable API version using an OAuth access token:
          $ rake shopify_api:graphql:dump SHOP_DOMAIN=SHOP_NAME.myshopify.com ACCESS_TOKEN=abc API_VERSION=unstable

        See https://github.com/Shopify/shopify_api#getting-started for more
        details on getting started with authenticated API calls.

        Arguments:
          ACCESS_TOKEN  OAuth access token (shop specific)
          API_VERSION   API version handle [example: 2020-01]
          SHOP_DOMAIN   Shop domain (without path) [example: SHOP_NAME.myshopify.com]
          SHOP_URL      Shop URL for private apps [example: https://API_KEY:PASSWORD@SHOP_NAME.myshopify.com]
      USAGE

      access_token = ENV['ACCESS_TOKEN'] || ENV['access_token']
      api_version = ENV['API_VERSION'] || ENV['api_version']
      shop_url = ENV['SHOP_URL'] || ENV['shop_url']
      shop_domain = ENV['SHOP_DOMAIN'] || ENV['shop_domain']

      unless access_token || api_version || shop_url || shop_domain
        puts usage
        exit(1)
      end

      unless shop_url || shop_domain
        puts 'Error: either SHOP_DOMAIN or SHOP_URL is required for authentication'
        puts usage
        exit(1)
      end

      if shop_url && shop_domain
        puts 'Error: SHOP_DOMAIN and SHOP_URL cannot be used together. Use one or the other for authentication.'
        puts usage
        exit(1)
      end

      if shop_domain && !access_token
        puts 'Error: ACCESS_TOKEN required when SHOP_DOMAIN is used'
        puts usage
        exit(1)
      end

      unless api_version
        puts 'Error: API_VERSION required. Example: 2020-01'
        puts usage
        exit(1)
      end

      Rake::Task['environment'].invoke if Rake::Task.task_defined?('environment')

      ShopifyAPI::ApiVersion.fetch_known_versions
      ShopifyAPI::ApiVersion.version_lookup_mode = :raise_on_unknown

      shopify_session = ShopifyAPI::Session.new(domain: shop_domain, token: access_token, api_version: api_version)
      ShopifyAPI::Base.activate_session(shopify_session)

      if shop_url
        ShopifyAPI::Base.site = shop_url
      end

      puts "Fetching schema for #{ShopifyAPI::Base.api_version.handle} API version..."

      client = ShopifyAPI::GraphQL::HTTPClient.new(ShopifyAPI::Base.api_version)
      document = GraphQL.parse('{ __schema { queryType { name } } }')
      response = client.execute(document: document).to_h

      unless response['data'].present?
        puts "Error: failed to query the API."
        puts "Response: #{response}"
        puts 'Ensure your SHOP_DOMAIN or SHOP_URL are valid and you have valid authentication credentials.'
        puts usage
        exit(1)
      end

      schema_location = ShopifyAPI::GraphQL.schema_location
      FileUtils.mkdir_p(schema_location) unless Dir.exist?(schema_location)

      schema_file = schema_location.join("#{api_version}.json")
      GraphQL::Client.dump_schema(client, schema_file.to_s)

      puts "Wrote file #{schema_file}"
    end
  end
end
