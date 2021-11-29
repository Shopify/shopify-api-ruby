# typed: false
# frozen_string_literal: true

require_relative "../../test_helper.rb"

class GraphQLStorefrontTest < Test::Unit::TestCase
  include TestHelpers::GraphQLClient
  def setup
    @shop = "test-shop.myshopify.com"
    @storefront_access_token = SecureRandom.alphanumeric(10)
    @client = ShopifyAPI::Clients::Graphql::Storefront.new(@shop, @storefront_access_token)
    @path = "api"
    @expected_headers = {
      "Accept-Encoding": "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "User-Agent": "Shopify API Library v#{ShopifyAPI::VERSION} | Ruby #{RUBY_VERSION}",
      "Content-Type": "application/json",
      "Accept": "application/json",
      "X-Shopify-Storefront-Access-Token": @storefront_access_token,
    }
  end
end
