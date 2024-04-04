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

        def test_can_query_using_private_token
          query = <<~QUERY
            {
              shop {
                name
              }
            }
          QUERY
          extra_headers = { extra: "header" }
          body = { query: query, variables: nil }
          success_body = { "success" => true }
          response_headers = { "content-type" => "application/json" }

          @client = ShopifyAPI::Clients::Graphql::Storefront.new(@shop, private_token: "private_token")
          @expected_headers = TestHelpers::Constants::DEFAULT_CLIENT_HEADERS.merge({
            "Shopify-Storefront-Private-Token": "private_token",
          }).merge(extra_headers)

          stub_request(:post, "https://test-shop.myshopify.com/#{@path}/#{ShopifyAPI::Context.api_version}/graphql.json")
            .with(body: body, headers: @expected_headers)
            .to_return(body: success_body.to_json, headers: response_headers)

          response = @client.query(query: query, headers: extra_headers)
          assert_equal(success_body, response.body)
        end

        def test_can_query_using_public_token
          query = <<~QUERY
            {
              shop {
                name
              }
            }
          QUERY
          extra_headers = { extra: "header" }
          body = { query: query, variables: nil }
          success_body = { "success" => true }
          response_headers = { "content-type" => "application/json" }

          @client = ShopifyAPI::Clients::Graphql::Storefront.new(@shop, public_token: "public_token")
          @expected_headers = TestHelpers::Constants::DEFAULT_CLIENT_HEADERS.merge({
            "X-Shopify-Storefront-Access-Token": "public_token",
          }).merge(extra_headers)

          stub_request(:post, "https://test-shop.myshopify.com/#{@path}/#{ShopifyAPI::Context.api_version}/graphql.json")
            .with(body: body, headers: @expected_headers)
            .to_return(body: success_body.to_json, headers: response_headers)

          response = @client.query(query: query, headers: extra_headers)
          assert_equal(success_body, response.body)
        end

        def test_error_raised_when_no_token_provided
          assert_raises(TypeError) { ShopifyAPI::Clients::Graphql::Storefront.new(@shop) }
        end
      end
    end
  end
end
