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

    def test_retries_throttled_graphql_response_within_try_limit
      query = "{ shop { name } }"
      throttled_body = {
        "errors" => [{ "message" => "Throttled", "extensions" => { "code" => "THROTTLED" } }],
        "extensions" => {
          "cost" => {
            "requestedQueryCost" => 101,
            "throttleStatus" => { "currentlyAvailable" => 1, "restoreRate" => 50 },
          },
        },
      }
      success_body = { "data" => { "shop" => { "name" => "Test shop" } } }
      response_headers = { "content-type" => "application/json" }
      url = "https://test-shop.myshopify.com/#{@path}/#{ShopifyAPI::Context.api_version}/graphql.json"

      @client.instance_variable_get(:@http_client).expects(:sleep).with(2).once

      stub_request(:post, url)
        .with(body: { query: query, variables: nil }, headers: @expected_headers)
        .to_return(body: throttled_body.to_json, headers: response_headers)
        .times(1)
        .then.to_return(body: success_body.to_json, headers: response_headers)

      response = @client.query(query: query, tries: 2)

      assert_equal(success_body, response.body)
      assert_requested(:post, url, times: 2)
    end

    def test_retries_throttled_graphql_response_with_fractional_restore_rate
      query = "{ shop { name } }"
      throttled_body = {
        "errors" => [{ "message" => "Throttled", "extensions" => { "code" => "THROTTLED" } }],
        "extensions" => {
          "cost" => {
            "requestedQueryCost" => 10,
            "throttleStatus" => { "currentlyAvailable" => 1, "restoreRate" => 2.5 },
          },
        },
      }
      success_body = { "data" => { "shop" => { "name" => "Test shop" } } }
      response_headers = { "content-type" => "application/json" }
      url = "https://test-shop.myshopify.com/#{@path}/#{ShopifyAPI::Context.api_version}/graphql.json"

      @client.instance_variable_get(:@http_client).expects(:sleep).with(4).once

      stub_request(:post, url)
        .with(body: { query: query, variables: nil }, headers: @expected_headers)
        .to_return(body: throttled_body.to_json, headers: response_headers)
        .times(1)
        .then.to_return(body: success_body.to_json, headers: response_headers)

      response = @client.query(query: query, tries: 2)

      assert_equal(success_body, response.body)
      assert_requested(:post, url, times: 2)
    end

    def test_returns_throttled_graphql_response_without_retrying_by_default
      query = "{ shop { name } }"
      throttled_body = {
        "errors" => [{ "message" => "Throttled", "extensions" => { "code" => "THROTTLED" } }],
      }
      response_headers = { "content-type" => "application/json" }
      url = "https://test-shop.myshopify.com/#{@path}/#{ShopifyAPI::Context.api_version}/graphql.json"

      stub_request(:post, url)
        .with(body: { query: query, variables: nil }, headers: @expected_headers)
        .to_return(body: throttled_body.to_json, headers: response_headers)

      response = @client.query(query: query)

      assert_equal(throttled_body, response.body)
      assert_requested(:post, url, times: 1)
    end

    def test_does_not_retry_other_graphql_errors
      query = "{ shop { name } }"
      error_body = {
        "errors" => [{ "message" => "Access denied", "extensions" => { "code" => "ACCESS_DENIED" } }],
      }
      response_headers = { "content-type" => "application/json" }
      url = "https://test-shop.myshopify.com/#{@path}/#{ShopifyAPI::Context.api_version}/graphql.json"

      stub_request(:post, url)
        .with(body: { query: query, variables: nil }, headers: @expected_headers)
        .to_return(body: error_body.to_json, headers: response_headers)

      response = @client.query(query: query, tries: 2)

      assert_equal(error_body, response.body)
      assert_requested(:post, url, times: 1)
    end

    def test_returns_last_throttled_response_when_try_limit_is_exhausted
      query = "{ shop { name } }"
      throttled_body = {
        "errors" => [{ "message" => "Throttled", "extensions" => { "code" => "THROTTLED" } }],
        "extensions" => {
          "cost" => {
            "requestedQueryCost" => 101,
            "throttleStatus" => { "currentlyAvailable" => 1, "restoreRate" => 50 },
          },
        },
      }
      response_headers = { "content-type" => "application/json" }
      url = "https://test-shop.myshopify.com/#{@path}/#{ShopifyAPI::Context.api_version}/graphql.json"

      @client.instance_variable_get(:@http_client).expects(:sleep).with(2).once

      stub_request(:post, url)
        .with(body: { query: query, variables: nil }, headers: @expected_headers)
        .to_return(body: throttled_body.to_json, headers: response_headers)

      response = @client.query(query: query, tries: 2)

      assert_equal(throttled_body, response.body)
      assert_requested(:post, url, times: 2)
    end

    def test_can_override_api_version
      @api_version = "2022-01"
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

      stub_request(:post, "https://test-shop.myshopify.com/#{@path}/#{@api_version}/graphql.json")
        .with(body: body, headers: @expected_headers)
        .to_return(body: success_body.to_json, headers: response_headers)

      @client.query(query: query, variables: variables)
    end

    def test_can_make_debug_requests
      query = <<~QUERY
        {
          shop {
            name
          }
        }
      QUERY
      body = { query: query, variables: nil }
      success_body = { "success" => true }
      response_headers = { "content-type" => "application/json" }

      stub_request(:post, "https://test-shop.myshopify.com/#{@path}/#{ShopifyAPI::Context.api_version}/graphql.json?debug=true")
        .with(body: body, headers: @expected_headers)
        .to_return(body: success_body.to_json, headers: response_headers)

      response = @client.query(query: query, debug: true)
      assert_equal(success_body, response.body)
    end
  end
end
