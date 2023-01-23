# typed: false
# frozen_string_literal: true

require_relative "../../test_helper.rb"

module ShopifyAPITest
  module Clients
    module Graphql
      class StorefrontTest < Test::Unit::TestCase
        include TestHelpers::GraphQLClient

        def setup
          super
          @shop = "test-shop.myshopify.com"
          @storefront_access_token = SecureRandom.alphanumeric(10)
          @client = build_client
          @path = "api"
          @expected_headers = TestHelpers::Constants::DEFAULT_CLIENT_HEADERS.merge({
            "X-Shopify-Storefront-Access-Token": @storefront_access_token,
          })
        end

        def build_client
          if !defined?("@api_version")
            ShopifyAPI::Clients::Graphql::Storefront.new(@shop, @storefront_access_token)
          else
            ShopifyAPI::Clients::Graphql::Storefront.new(@shop, @storefront_access_token, api_version: @api_version)
          end
        end
      end
    end
  end
end
