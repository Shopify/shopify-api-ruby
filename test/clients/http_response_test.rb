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

      def test_object_response
        modify_context(graphql_response_object: true)

        # We need to verify that the response body is an OpenStruct object
        response = ShopifyAPI::Clients::HttpResponse.new(code: 200, headers: {}, body: { "key" => { "nested_key" => "nested_value" }})
        assert_kind_of(OpenStruct, response.body)
        assert_equal("nested_value", response.body.key.nested_key)
      end
    end
  end
end
