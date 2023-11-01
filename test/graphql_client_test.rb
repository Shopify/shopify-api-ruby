# typed: true
# frozen_string_literal: true

require_relative "./test_helper"
require "graphql/client"
require "graphql/client/http"

module ShopifyAPITest
  WebMock.disable!
  class GraphqlClientTest < Minitest::Test
    def test_query
      query = <<~QUERY
        query {
          shop {
            name
          }
        }
      QUERY

      session = ::ShopifyAPI::Auth::Session.new(
        shop: ENV["SHOP_DOMAIN"],
        access_token: ENV["TOKEN"] + "sdfd",
      )

      client = ::ShopifyAPI::Clients::Graphql::Admin.new(session: session)
      result = client.query(query: query)
      puts "result: #{result}"
      puts "result: #{result.data.shop.name}"
    end
  end
end
