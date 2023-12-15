# typed: false
# frozen_string_literal: true

require_relative "../test_helper.rb"

module ShopifyAPITest
  module Clients
    class HttpResponseTest < Test::Unit::TestCase
      def setup
        @session = ShopifyAPI::Auth::Session.new(shop: "test-shop.myshopify.com",
          access_token: SecureRandom.alphanumeric(10))
      end

      def test_ok
        assert(ShopifyAPI::Clients::HttpResponse.new(code: 200, headers: {}, body: "").ok?)
      end

      def test_okay_with_error_response
        refute(ShopifyAPI::Clients::HttpResponse.new(code: 400, headers: {}, body: "").ok?)
      end

      def test_next
        link_header = "<https://test-shop.myshopify.com/path?limit=1&page_info=page-info>; rel=\"next\""
        response = ShopifyAPI::Clients::HttpResponse.new(code: 200, headers: { "link" => [link_header] }, body: "")

        assert_equal("page-info", response.next_page_info)
        assert_nil(response.prev_page_info)
      end

      def test_prev
        link_header = "<https://test-shop.myshopify.com/path?limit=1&page_info=page-info>; rel=\"previous\""
        response = ShopifyAPI::Clients::HttpResponse.new(code: 200, headers: { "link" => [link_header] }, body: "")

        assert_equal("page-info", response.prev_page_info)
        assert_nil(response.next_page_info)
      end

      def test_next_and_prev
        link_header = [
          "<https://test-shop.myshopify.com/path?limit=1&page_info=page-info>; rel=\"previous\"",
          "<https://test-shop.myshopify.com/path?limit=1&page_info=other-page-info>; rel=\"next\"",
        ].join(", ")
        response = ShopifyAPI::Clients::HttpResponse.new(code: 200, headers: { "link" => [link_header] }, body: "")

        assert_equal("page-info", response.prev_page_info)
        assert_equal("other-page-info", response.next_page_info)
      end

      def test_retry_request_after
        response = ShopifyAPI::Clients::HttpResponse.new(code: 200, headers: { "retry-after" => ["2.0"] }, body: "")
        assert_equal(2.0, response.retry_request_after)
      end

      def test_api_call_limit
        response = ShopifyAPI::Clients::HttpResponse.new(code: 200, headers: { "x-shopify-shop-api-call-limit" => ["1/40"] }, body: "")
        assert_equal(1, response.api_call_limit[:request_count])
        assert_equal(40, response.api_call_limit[:bucket_size])
      end
    end
  end
end
