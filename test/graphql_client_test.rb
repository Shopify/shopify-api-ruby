# typed: true
# frozen_string_literal: true

require_relative "./test_helper"
require "graphql/client"
require "graphql/client/http"

module ShopifyAPITest
  WebMock.disable!
  class GraphqlClientTest < Minitest::Test
    def test_query
      products = <<~QUERY
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

      product = <<~QUERY
        query($id: ID!) {
          product(id: $id) {
            title
            id
            description
          }
        }
      QUERY

      session = ::ShopifyAPI::Auth::Session.new(
        shop: ENV["SHOP_DOMAIN"],
        access_token: ENV["TOKEN"],
      )

      client = ::ShopifyAPI::Clients::Graphql::Admin.new(session: session)
      products = client.query(query: products)
      variables = {
        id: products.data.products.edges.first.node.id,
      }
      product = client.query(query: product, variables: variables)

      puts "product description: #{product.data.product.description}"
    end
  end
end
