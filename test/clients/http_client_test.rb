# typed: false
# frozen_string_literal: true

require_relative "../test_helper.rb"

module ShopifyAPITest
  module Clients
    class HttpClientTest < Test::Unit::TestCase
      def setup
        super
        @shop = "test-shop.myshopify.com"
        @token = SecureRandom.alphanumeric(10)
        @base_path = "/base_path"
        @session = ShopifyAPI::Auth::Session.new(shop: @shop, access_token: @token)
        @client = ShopifyAPI::Clients::HttpClient.new(session: @session, base_path: @base_path)

        @request = ShopifyAPI::Clients::HttpRequest.new(
          http_method: :post,
          path: "some-path",
          body: { foo: "bar" },
          body_type: "application/json",
          query: { id: 1234 },
          extra_headers: { extra: "header" },
        )

        @expected_headers = {
          "X-Shopify-Access-Token": @token,
        }.merge(@request.extra_headers)
          .merge(TestHelpers::Constants::DEFAULT_CLIENT_HEADERS)

        @success_body = { "success" => true }
        @response_headers = { "content-type" => "application/json", "x-request-id" => "123" }
      end

      def test_get
        simple_http_test(:get)
      end

      def test_delete
        simple_http_test(:delete)
      end

      def test_put
        simple_http_test(:put)
      end

      def test_post
        simple_http_test(:post)
      end

      def test_request_with_empty_base_path
        @base_path = ""
        @client = ShopifyAPI::Clients::HttpClient.new(session: @session, base_path: @base_path)
        simple_http_test(:get)
      end

      def test_request_with_api_host_set
        @success_body = {}

        ShopifyAPI::Context.setup(
          api_key: "key",
          api_secret_key: "secret",
          api_version: "2023-10",
          scope: ["scope1", "scope2"],
          is_private: true,
          is_embedded: true,
          api_host: "example.com",
        )
        @client = ShopifyAPI::Clients::HttpClient.new(session: @session, base_path: @base_path)

        headers = @expected_headers.dup
        headers["Host"] = @session.shop

        stub_request(@request.http_method, "https://example.com#{@base_path}/#{@request.path}")
          .with(body: @request.body.to_json, query: @request.query, headers: headers)
          .to_return(body: "", headers: @response_headers, status: 204)

        verify_http_request
      end

      def test_request_using_active_session
        ShopifyAPI::Context.activate_session(@session)
        @client = ShopifyAPI::Clients::HttpClient.new(base_path: @base_path)
        simple_http_test(:get)
        ShopifyAPI::Context.deactivate_session
      end

      def test_request_with_empty_response_body
        @success_body = {}

        stub_request(@request.http_method, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(body: @request.body.to_json, query: @request.query, headers: @expected_headers)
          .to_return(body: "", headers: @response_headers)

        verify_http_request
      end

      # It doesn't really make sense for an HTTP body to ever be `nil`, but
      # the underlying HTTParty library seems to use `nil` for the response
      # body in situations where it doesn't need to parse it, e.g. when the
      # response status is 204.
      def test_request_with_nil_response_body
        @success_body = {}

        stub_request(@request.http_method, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(body: @request.body.to_json, query: @request.query, headers: @expected_headers)
          .to_return(body: "", headers: @response_headers, status: 204)

        verify_http_request
      end

      def test_request_with_no_access_token
        @session = ShopifyAPI::Auth::Session.new(shop: @shop)
        @client = ShopifyAPI::Clients::HttpClient.new(session: @session, base_path: @base_path)

        @expected_headers.delete(:"X-Shopify-Access-Token")

        apply_simple_http_stub
        verify_http_request
      end

      def test_request_with_user_agent_prefix
        @expected_headers[:"User-Agent"] = "some_prefix | " + @expected_headers[:"User-Agent"]

        modify_context(user_agent_prefix: "some_prefix")
        @client = ShopifyAPI::Clients::HttpClient.new(session: @session, base_path: @base_path)

        apply_simple_http_stub
        verify_http_request
      end

      def test_request_with_no_optional_parameters
        @request = ShopifyAPI::Clients::HttpRequest.new(http_method: :get, path: @request.path)

        @expected_headers.delete(:extra)
        @expected_headers.delete(:"Content-Type")

        stub_request(:get, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(headers: @expected_headers)
          .to_return(body: @success_body.to_json, headers: @response_headers)

        verify_http_request
      end

      def test_request_with_invalid_request
        @request.http_method = :bad
        assert_raises(ShopifyAPI::Errors::InvalidHttpRequestError) { @client.request(@request) }
      end

      def test_error_message_structure
        error_response_body = {
          "errors": { "line_items" => ["must have at least one line item"] },
        }.to_json
        response_headers = {
          "x-request-id": 1234,
        }
        stub_request(@request.http_method, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(body: @request.body.to_json, query: @request.query, headers: @expected_headers)
          .to_return(body: error_response_body, status: 422, headers: response_headers)

        response = assert_raises(ShopifyAPI::Errors::HttpResponseError) do
          @client.request(@request)
        end
        parsed_error = JSON.parse(response.message)
        assert(parsed_error["errors"].present?)
        assert(parsed_error["error_reference"].present?)
      end

      def test_non_retriable_error_code
        stub_request(@request.http_method, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(body: @request.body.to_json, query: @request.query, headers: @expected_headers)
          .to_return(body: { errors: "Something very not good" }.to_json, headers: @response_headers, status: 400)

        assert_raises(ShopifyAPI::Errors::HttpResponseError) { @client.request(@request) }
      end

      def test_retriable_error_code_no_retries
        stub_request(@request.http_method, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(body: @request.body.to_json, query: @request.query, headers: @expected_headers)
          .to_return(body: { errors: "Something very not good" }.to_json, headers: @response_headers, status: 500)

        assert_raises(ShopifyAPI::Errors::HttpResponseError) { @client.request(@request) }
      end

      def test_retry_throttle_error
        @request.tries = 2

        @client.expects(:sleep).with(2).times(1)

        stub_request(@request.http_method, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(body: @request.body.to_json, query: @request.query, headers: @expected_headers)
          .to_return(body: { errors: "Something very not good" }.to_json,
            headers: @response_headers.merge("Retry-After" => "2.0"), status: 429).times(1)
          .then.to_return(body: @success_body.to_json, headers: @response_headers)

        verify_http_request
      end

      def test_retry_internal_error
        @request.tries = 2

        @client.expects(:sleep).with(1).times(1)

        stub_request(@request.http_method, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(body: @request.body.to_json, query: @request.query, headers: @expected_headers)
          .to_return(body: { errors: "Something very not good" }.to_json, headers: @response_headers, status: 500)
          .times(1)
          .then.to_return(body: @success_body.to_json, headers: @response_headers)

        verify_http_request
      end

      def test_retries_exceeded
        @request.tries = 3

        @client.expects(:sleep).with(1).times(2)

        stub_request(@request.http_method, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(body: @request.body.to_json, query: @request.query, headers: @expected_headers)
          .to_return(body: { errors: "Something very not good" }.to_json, headers: @response_headers, status: 500)

        error = assert_raises(ShopifyAPI::Errors::MaxHttpRetriesExceededError) { @client.request(@request) }
        assert_instance_of(ShopifyAPI::Clients::HttpResponse, error.response)
      end

      def test_throttle_error_no_retry_after_header
        @request.tries = 2

        @client.expects(:sleep).with(1).times(1)

        stub_request(@request.http_method, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(body: @request.body.to_json, query: @request.query, headers: @expected_headers)
          .to_return(body: { errors: "Something very not good" }.to_json, headers: @response_headers, status: 429)
          .times(1)
          .then.to_return(body: @success_body.to_json, headers: @response_headers)

        verify_http_request
      end

      def test_throttle_error_with_retry_after_header_in_error_object
        stub_request(@request.http_method, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(body: @request.body.to_json, query: @request.query, headers: @expected_headers)
          .to_return(body: { errors: "Call limit exceeded" }.to_json,
            headers: @response_headers.merge("Retry-After" => "2.0"), status: 429)

        error = assert_raises(ShopifyAPI::Errors::HttpResponseError) { @client.request(@request) }
        assert_equal(429, error.code)
        assert_equal("2.0", error.response.headers["retry-after"][0])
      end

      def test_warns_on_deprecation_header
        reader, writer = IO.pipe
        modify_context(logger: Logger.new(writer), api_version: "2023-10")
        deprecate_reason = "https://help.shopify.com/tutorials#foobar-endpoint-is-removed"
        stub_request(@request.http_method, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(body: @request.body.to_json, query: @request.query, headers: @expected_headers)
          .to_return(body: @success_body.to_json,
            headers: @response_headers.merge("X-Shopify-API-Deprecated-Reason" => deprecate_reason))

        @client.request(@request)
        assert_match(/#{@request.path}.*#{deprecate_reason}/, reader.gets)
      end

      def test_json_parser_error
        stub_request(@request.http_method, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(body: @request.body.to_json, query: @request.query, headers: @expected_headers)
          .to_return(body: "<html>Some HTML</html>", status: 502)

        error = assert_raises(ShopifyAPI::Errors::HttpResponseError) { @client.request(@request) }
        assert_equal(502, error.code)
      end

      def test_response_as_struct
        stub_request(@request.http_method, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(body: @request.body.to_json, query: @request.query, headers: @expected_headers)
          .to_return(body: { "key" => { "nested_key" => "nested_value" } }.to_json, headers: @response_headers)

        response = @client.request(@request, response_as_struct: true)
        assert_kind_of(OpenStruct, response.body)
        assert_equal("nested_value", response.body.key.nested_key)
      end

      private

      def simple_http_test(http_method)
        @request.http_method = http_method
        apply_simple_http_stub
        verify_http_request
      end

      def apply_simple_http_stub
        stub_request(@request.http_method, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(body: @request.body.to_json, query: @request.query, headers: @expected_headers)
          .to_return(body: @success_body.to_json, headers: @response_headers)
      end

      def verify_http_request
        response = @client.request(@request)

        assert(response.ok?)
        assert_equal(@success_body, response.body)
        assert_equal(@response_headers.to_h { |k, v| [k, [v]] }, response.headers)
      end
    end
  end
end
