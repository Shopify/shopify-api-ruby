# typed: true
# frozen_string_literal: true

require_relative "./test_helper"
require "graphql/client"
require "graphql/client/http"

module ShopifyAPITest
  WebMock.disable!
  class GraphqlClientDemoTest < Minitest::Test
    def test_this_is_a_demo
      # To Run this demo, do the following:
      # bundle exec rake test TEST=test/graphql_client_demo_test.rb SHOP_DOMAIN=<my-shop-domain>.myshopify.com TOKEN=the_session_token-for_your_shop
      products_query = <<~QUERY
        query {
          products(first: 10){
             edges {
               node{
                 id
                 title
               }
             }
             pageInfo{
               endCursor
               hasNextPage
               hasPreviousPage
               startCursor
             }
           }
        }
      QUERY

      bad_query = <<~QUERY
        query($id: ID!) {
          product(id: $id) {
            title
            imaginaryField
            description
          }
        }
      QUERY

      session = ::ShopifyAPI::Auth::Session.new(
        shop: ENV["SHOP_DOMAIN"],
        access_token: ENV["TOKEN"],
      )

      #------- Create admin client exactly the same way as before, and query it the same way
      client = ::ShopifyAPI::Clients::Graphql::Admin.new(session: session)

      #-------  Get all products and use the result in hash and object ----------------------
      http_response = client.query(query: products_query)
      hash_access_result = http_response.body["data"]["products"]["edges"][0]["node"]["id"]
      object_access_result = http_response.data.products.edges[0].node.id
      puts " ---------------- "
      puts ">>> http_response.body[\"data\"][\"products\"][\"edges\"][0][\"node\"][\"id\"]"
      puts "ProductId from hash retreival: #{hash_access_result}"
      puts " ---------------- "
      puts ">>> http_response.data.products.edges[0].node.id"
      puts "ProductId from data object retreival: #{object_access_result}"
      puts " ---------------- "

      # ------- Making bad queries or experimental queries that requires by passing schema check
      puts "Making sure that bad queries will raise error"
      error = assert_raises(GraphQL::Client::ValidationError) do
        client.query(query: bad_query)
      end
      puts "graphql-client raised error: #{error.message}"
      puts " ---------------- "

      puts "Making sure that bad queries will raise error from server side if schema check is disabled"
      result = client.query(query: bad_query, bypass_schema_check: true)
      error = result.body["errors"]
      puts "Error from server : #{error}"
    end
  end
end
