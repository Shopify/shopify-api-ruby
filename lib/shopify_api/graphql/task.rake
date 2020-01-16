# frozen_string_literal: true
require 'fileutils'

namespace :shopify_api do
  namespace :graphql do
    prereqs = []
    # add the Rails environment task as a prerequisite if loaded from a Rails app
    prereqs << :environment if Rake::Task.task_defined?('environment')

    desc 'Writes the Shopify Admin API GraphQL schema to a local file'
    task dump: prereqs do
      site_url = ENV['SITE_URL'] || ENV['site_url']
      shop_domain = ENV['SHOP_DOMAIN'] || ENV['shop_domain']
      api_version = ENV['API_VERSION'] || ENV['api_version']
      access_token = ENV['ACCESS_TOKEN'] || ENV['access_token']

      unless site_url || shop_domain
        puts 'Either SHOP_DOMAIN or SITE_URL is required for authentication'
        exit(1)
      end

      if site_url && shop_domain
        puts 'SHOP_DOMAIN and SITE_URL cannot be used together. Use one or the other for authentication.'
        exit(1)
      end

      if shop_domain && !access_token
        puts 'ACCESS_TOKEN required when SHOP_DOMAIN is used'
        exit(1)
      end

      unless api_version
        puts "API_VERSION required. Example `2020-01`"
        exit(1)
      end

      ShopifyAPI::ApiVersion.fetch_known_versions
      ShopifyAPI::ApiVersion.version_lookup_mode = :raise_on_unknown

      shopify_session = ShopifyAPI::Session.new(domain: shop_domain, token: access_token, api_version: api_version)
      ShopifyAPI::Base.activate_session(shopify_session)

      if site_url
        ShopifyAPI::Base.site = site_url
      end

      schema_location = ShopifyAPI::GraphQL.schema_location
      FileUtils.mkdir_p(schema_location) unless Dir.exist?(schema_location)

      client = ShopifyAPI::GraphQL::HTTPClient.new(ShopifyAPI::Base.api_version)
      GraphQL::Client.dump_schema(client, schema_location.join("#{api_version}.json").to_s)
    end
  end
end
