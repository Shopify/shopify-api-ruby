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

        ShopifyAPI::Context.setup(
          api_key: "key",
          api_secret_key: "secret",
          api_version: "2023-10",
          scope: ["scope1", "scope2"],
          is_private: true,
          is_embedded: true,
        )
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
        assert(parsed_error["errors"])
        assert(parsed_error["error_reference"])
      end

      def test_error_message_with_oauth_error_and_description
        error_response_body = {
          "error": "invalid_subject_token",
          "error_description": "The subject token is invalid or has expired",
        }.to_json
        response_headers = {
          "x-request-id": 9012,
        }
        stub_request(@request.http_method, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(body: @request.body.to_json, query: @request.query, headers: @expected_headers)
          .to_return(body: error_response_body, status: 400, headers: response_headers)

        response = assert_raises(ShopifyAPI::Errors::HttpResponseError) do
          @client.request(@request)
        end
        parsed_error = JSON.parse(response.message)
        assert_equal("invalid_subject_token", parsed_error["error"])
        assert_equal("The subject token is invalid or has expired", parsed_error["error_description"])
        assert(parsed_error["error_reference"])
      end

      # `invalid_client` is returned with no description at all, and the key read used to be `error`.
      def test_error_message_omits_a_description_the_response_did_not_send
        stub_request(@request.http_method, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(body: @request.body.to_json, query: @request.query, headers: @expected_headers)
          .to_return(body: { "error": "invalid_client" }.to_json, status: 401)

        error = assert_raises(ShopifyAPI::Errors::HttpResponseError) { @client.request(@request) }

        assert_equal({ "error" => "invalid_client" }, JSON.parse(error.message))
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

      def test_requests_without_a_redirect_override_still_follow_redirects
        redirect_url = "https://#{@shop}#{@base_path}/redirected"
        stub_request(:post, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(query: @request.query)
          .to_return(status: 302, headers: { "Location" => redirect_url }, body: "")
        stub_request(:get, redirect_url).to_return(body: @success_body.to_json, headers: @response_headers)

        verify_http_request

        assert_requested(:get, redirect_url, times: 1)
      end

      def test_a_requests_body_type_does_not_leak_into_the_next_request
        apply_simple_http_stub
        verify_http_request
        captured_requests = []
        stub_request(:get, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with { |request| captured_requests << request }
          .to_return(body: @success_body.to_json, headers: @response_headers)

        @client.request(ShopifyAPI::Clients::HttpRequest.new(http_method: :get, path: @request.path))

        refute_includes(captured_requests.fetch(0).headers.keys.map(&:downcase), "content-type")
      end

      def test_blocked_redirect_raises_an_error_naming_the_target_and_what_was_not_sent
        @request.follow_redirects = false
        redirect_url = "https://#{@shop}#{@base_path}/redirected"
        stub_request(:post, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(query: @request.query)
          .to_return(status: 307, headers: { "Location" => redirect_url }, body: "<html>moved</html>")

        error = assert_raises(ShopifyAPI::Errors::HttpResponseError) { @client.request(@request) }

        assert_equal(307, error.code)
        assert_includes(error.message, "307")
        assert_includes(error.message, redirect_url)
        assert_includes(error.message, "Nothing was sent there")
      end

      # `response.body["errors"]` is `String#[]` on an unparsed body, so "errors" in an HTML page used to
      # come back as `{"errors":"errors"}`.
      def test_unparsable_error_body_does_not_report_invented_error_members
        stub_request(:post, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(query: @request.query)
          .to_return(status: 500, body: "<html>errors happened</html>")

        error = assert_raises(ShopifyAPI::Errors::HttpResponseError) { @client.request(@request) }

        assert_equal(500, error.code)
        refute_includes(error.message, "errors")
      end

      def test_disabling_redirects_does_not_change_nonredirect_json_parser_errors
        @request.follow_redirects = false
        stub_request(:post, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(query: @request.query)
          .to_return(body: "<html>Bad Request</html>", status: 400)

        assert_raises(JSON::ParserError) { @client.request(@request) }
      end

      def test_response_as_struct
        stub_request(@request.http_method, "https://#{@shop}#{@base_path}/#{@request.path}")
          .with(body: @request.body.to_json, query: @request.query, headers: @expected_headers)
          .to_return(body: { "key" => { "nested_key" => "nested_value" } }.to_json, headers: @response_headers)

        response = @client.request(@request, response_as_struct: true)
        assert_kind_of(OpenStruct, response.body)
        assert_equal("nested_value", response.body.key.nested_key)
      end

      def test_suppressed_inherited_http_auth_rejects_a_url_carrying_credentials
        modify_context(api_host: "user:password@internal.example.com")

        error = assert_raises(ShopifyAPI::Errors::InvalidHttpRequestError) do
          token_less_client.request(suppressed_auth_request)
        end

        assert_match(/URL containing credentials/, error.message)
      end

      def test_suppressed_inherited_http_auth_preserves_connection_settings_and_noncredential_headers
        captured_options = []
        connection_options = { timeout: 17, ssl_ca_file: "/custom/ca.pem", http_proxyaddr: "proxy.example", http_proxyport: 8080 }
        inherited_options = HTTParty::Basement.default_options.merge(connection_options).merge(
          basic_auth: { username: "inherited-user", password: "inherited-password" },
          headers: { "X-Global" => "preserved" },
          connection_adapter: lambda { |uri, options|
            captured_options << options
            HTTParty::ConnectionAdapter.call(uri, options)
          },
        )
        HTTParty::Basement.stubs(:default_options).returns(inherited_options)
        captured_requests = []
        stub_request(:post, authentication_request_url)
          .with { |request| captured_requests << request }
          .to_return(body: @success_body.to_json, headers: @response_headers)

        response = token_less_client.request(suppressed_auth_request)

        assert(response.ok?)
        assert_equal(1, captured_options.size)
        assert_equal(connection_options, captured_options.fetch(0).slice(*connection_options.keys))
        assert_nil(captured_options.fetch(0)[:basic_auth])
        assert_equal("preserved", captured_requests.fetch(0).headers["X-Global"])
        refute_includes(captured_requests.fetch(0).headers.keys.map(&:downcase), "authorization")
        assert_equal("inherited-user", inherited_options.dig(:basic_auth, :username))
      end

      private

      def simple_http_test(http_method)
        @request.http_method = http_method
        apply_simple_http_stub
        verify_http_request
      end

      def token_less_client
        ShopifyAPI::Clients::HttpClient.new(
          session: ShopifyAPI::Auth::Session.new(shop: @shop),
          base_path: @base_path,
        )
      end

      def suppressed_auth_request
        ShopifyAPI::Clients::HttpRequest.new(
          http_method: :post,
          path: "some-path",
          body: { foo: "bar" },
          body_type: "application/json",
          suppress_inherited_http_auth: true,
        )
      end

      def authentication_request_url
        "https://#{@shop}#{@base_path}/some-path"
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
