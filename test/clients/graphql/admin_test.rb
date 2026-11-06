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

        def test_retries_shopifyql_throttle_after_window_reset
          query = "{ shopifyqlQuery(query: \"FROM sales SHOW total_sales\") { tableData { columns { name } } } }"
          now = Time.now
          throttled_body = {
            "errors" => [{
              "message" => "Rate limited",
              "extensions" => {
                "code" => "THROTTLED",
                "cost" => { "windowResetAt" => (now + 5).iso8601 },
              },
            }],
          }
          success_body = { "data" => { "shopifyqlQuery" => { "tableData" => { "columns" => [] } } } }
          response_headers = { "content-type" => "application/json" }
          url = "https://test-shop.myshopify.com/#{@path}/#{ShopifyAPI::Context.api_version}/graphql.json"
          @client.instance_variable_get(:@http_client).expects(:sleep).with(5).once

          stub_request(:post, url)
            .with(body: { query: query, variables: nil }, headers: @expected_headers)
            .to_return(body: throttled_body.to_json, headers: response_headers)
            .times(1)
            .then.to_return(body: success_body.to_json, headers: response_headers)

          response = @client.query(query: query, tries: 2)

          assert_equal(success_body, response.body)
          assert_requested(:post, url, times: 2)
        end
      end
    end
  end
end
