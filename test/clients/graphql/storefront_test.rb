# typed: false
# frozen_string_literal: true

require_relative "../../test_helper.rb"

module ShopifyAPITest
  module Clients
    module Graphql
      class StorefrontTest < Test::Unit::TestCase
        include TestHelpers::GraphQLClient

        def setup
          @shop = "test-shop.myshopify.com"
          @storefront_access_token = SecureRandom.alphanumeric(10)
          @client = ShopifyAPI::Clients::Graphql::Storefront.new(@shop, @storefront_access_token)
          @path = "api"
          @expected_headers = TestHelpers::Constants::DEFAULT_CLIENT_HEADERS.merge({
            "X-Shopify-Storefront-Access-Token": @storefront_access_token,
          })
        end
      end
    end
  end
end
