# typed: false
# frozen_string_literal: true

require_relative "../../test_helper.rb"

module ShopifyAPI
  module Clients
    module Graphql
      class AdminTest < Test::Unit::TestCase
        include TestHelpers::GraphQLClient

        def setup
          @session = ShopifyAPI::Auth::Session.new(shop: "test-shop.myshopify.com",
            access_token: SecureRandom.alphanumeric(10))
          @client = ShopifyAPI::Clients::Graphql::Admin.new(@session)
          @path = "admin/api"
          @expected_headers = {
            "Accept-Encoding": "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
            "User-Agent": "Shopify API Library v#{ShopifyAPI::VERSION} | Ruby #{RUBY_VERSION}",
            "Content-Type": "application/json",
            "Accept": "application/json",
            "X-Shopify-Access-Token": @session.access_token,
          }
        end
      end
    end
  end
end
