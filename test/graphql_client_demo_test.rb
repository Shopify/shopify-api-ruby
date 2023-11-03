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

      product_query = <<~QUERY
        query($id: ID!) {
          product(id: $id) {
            title
            id
            description
          }
        }
      QUERY

      product_create_query = <<~QUERY
        mutation($input: ProductInput!) {
          productCreate(input: $input) {
            product {
              id
              title
            }
          }
        }
      QUERY

      session = ::ShopifyAPI::Auth::Session.new(
        shop: ENV["SHOP_DOMAIN"],
        access_token: ENV["TOKEN"],
      )

      # Create admin client exactly the same way as before, and query it the same way
      client = ::ShopifyAPI::Clients::Graphql::Admin.new(session: session)

      # Get all products
      products = client.query(query: products_query)
      first_product_id = products.data.products.edges.first.node.id
      puts "First productId: #{first_product_id}"
      puts " ---------------- "

      # Get single product from productID in variable
      product_query_variables = {
        id: first_product_id,
      }
      product = client.query(query: product_query, variables: product_query_variables)
      puts "Product description: #{product.data.product.description} for ID: #{first_product_id}"
      puts " ---------------- "

      # Create product
      product_create_input = {
        input: {
          title: "My product- #{Time.now.strftime("%m%d%H%M")}",
        },
      }
      created_product = client.query(query: product_create_query, variables: product_create_input)
      created_product_id = created_product.data.product_create.product.id
      created_product_title = created_product.data.product_create.product.title
      puts "Created product: [#{created_product_title}]-ID [#{created_product_id}]"
      puts " ---------------- "
    end
  end
end
