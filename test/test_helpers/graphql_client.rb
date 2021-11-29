# typed: false
# frozen_string_literal: true

module TestHelpers
  module GraphQLClient
    def test_can_make_query
      query = <<~QUERY
        {
          shop {
            name
          }
        }
      QUERY
      extra_headers = { extra: "header" }
      @expected_headers.merge(extra_headers)
      body = { query: query, variables: nil }
      success_body = { "success" => true }
      response_headers = { "content-type" => "application/json" }

      stub_request(:post, "https://test-shop.myshopify.com/#{@path}/#{ShopifyAPI::Context.api_version}/graphql.json")
        .with(body: body, headers: @expected_headers)
        .to_return(body: success_body.to_json, headers: response_headers)

      response = @client.query(query: query, headers: extra_headers)
      assert_equal(success_body, response.body)
    end

    def test_can_make_query_with_variables
      query = <<~QUERY
        query myTestQuery($first: Int) {
          products (first: $first) {
            edges {
              node {
                id
                title
                descriptionHtml
              }
            }
          }
        }
      QUERY
      variables = {
        first: 10,
      }
      setup
      body = { query: query, variables: variables }
      success_body = { "success" => true }
      response_headers = { "content-type" => "application/json" }

      stub_request(:post, "https://test-shop.myshopify.com/#{@path}/#{ShopifyAPI::Context.api_version}/graphql.json")
        .with(body: body, headers: @expected_headers)
        .to_return(body: success_body.to_json, headers: response_headers)

      @client.query(query: query, variables: variables)
    end
  end
end
