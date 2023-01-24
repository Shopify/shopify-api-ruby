# typed: false
# frozen_string_literal: true

require_relative "../../test_helper.rb"

module ShopifyAPI
  module Clients
    module Graphql
      class AdminTest < Test::Unit::TestCase
        include TestHelpers::GraphQLClient

        def setup
          super
          @session = ShopifyAPI::Auth::Session.new(shop: "test-shop.myshopify.com",
            access_token: SecureRandom.alphanumeric(10))
          @client = build_client
          @path = "admin/api"
          @expected_headers = TestHelpers::Constants::DEFAULT_CLIENT_HEADERS.merge({
            "X-Shopify-Access-Token": @session.access_token,
          })
        end

        def build_client
          if !defined?("@api_version")
            ShopifyAPI::Clients::Graphql::Admin.new(session: @session)
          else
            ShopifyAPI::Clients::Graphql::Admin.new(session: @session, api_version: @api_version)
          end
        end
      end
    end
  end
end
