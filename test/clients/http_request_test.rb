# typed: false
# frozen_string_literal: true

require_relative "../test_helper.rb"

class HttpRequestTest < Test::Unit::TestCase
  def test_valid_request
    ShopifyAPI::Clients::HttpRequest.new(
      http_method: :get,
      path: "path"
    ).verify
  end

  def test_invalid_http_method
    assert_raises(ShopifyAPI::Errors::InvalidHttpRequestError) do
      ShopifyAPI::Clients::HttpRequest.new(
        http_method: :bad,
        path: "path"
      ).verify
    end
  end

  def test_body_with_no_type
    assert_raises(ShopifyAPI::Errors::InvalidHttpRequestError) do
      ShopifyAPI::Clients::HttpRequest.new(
        http_method: :get,
        path: "path",
        body: {}
      ).verify
    end
  end

  def test_post_no_body
    assert_raises(ShopifyAPI::Errors::InvalidHttpRequestError) do
      ShopifyAPI::Clients::HttpRequest.new(
        http_method: :post,
        path: "path",
      ).verify
    end
  end

  def test_put_no_body
    assert_raises(ShopifyAPI::Errors::InvalidHttpRequestError) do
      ShopifyAPI::Clients::HttpRequest.new(
        http_method: :put,
        path: "path",
      ).verify
    end
  end
end
