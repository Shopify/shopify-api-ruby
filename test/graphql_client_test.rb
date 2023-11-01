# typed: true
# frozen_string_literal: true

require_relative "./test_helper"
require "graphql/client"
require "graphql/client/http"

module ShopifyAPITest
  WebMock.disable!
  module ShopifyAPI
    Http = GraphQL::Client::HTTP.new("https://#{ENV["SHOP_DOMAIN"]}/admin/api/2023-10/graphql.json") do
      def headers(context)
        # Optionally set any HTTP headers
        {
          "User-Agent": "shopify-api-ruby test",
          "X-Shopify-Access-Token": ENV["TOKEN"],
        }
      end
    end

    Schema = GraphQL::Client.load_schema("data/graphql_schemas/2023-10.json")
    Client = GraphQL::Client.new(schema: Schema, execute: Http)
  end

  class GraphqlClientTest < Minitest::Test
    Query = ShopifyAPI::Client.parse(<<-GRAPHQL)
      query {
        shop {
          name
        }
      }
    GRAPHQL

    def test_helloworld
      puts "query: #{Query}"
      result = ShopifyAPI::Client.query(Query)
      puts "Result: #{result.data.shop.name}"
    end
  end
end
