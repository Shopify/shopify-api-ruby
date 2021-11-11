# typed: false
# frozen_string_literal: true

require_relative "../../test_helper.rb"

class RestClientTest < Test::Unit::TestCase
  def test_get
    run_test(:get)
  end

  def test_delete
    run_test(:delete)
  end

  def test_put
    run_test(:put)
  end

  def test_post
    run_test(:post)
  end

  private

  def run_test(http_method)
    session = ShopifyAPI::Auth::Session.new(shop: "test-shop.myshopify.com",
      access_token: SecureRandom.alphanumeric(10))
    client = ShopifyAPI::Clients::Rest::Admin.new(session)

    request = {
      path: "some-path",
      body: { foo: "bar" },
      query: { id: 1234 },
      headers: { extra: "header" },
    }

    expected_headers = {
      "Accept-Encoding": "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "User-Agent": "Shopify API Library v#{ShopifyAPI::VERSION} | Ruby #{RUBY_VERSION}",
      "Content-Type": "application/json",
      "Accept": "application/json",
      "X-Shopify-Access-Token": session.access_token,
    }.merge(request[:headers])

    success_body = { "success" => true }
    response_headers = { "content-type" => "application/json" }

    stub_request(http_method, "https://#{session.shop}/admin/api/#{ShopifyAPI::Context.api_version}/#{request[:path]}")
      .with(body: request[:body].to_json, query: request[:query], headers: expected_headers)
      .to_return(body: success_body.to_json, headers: response_headers)

    response = client.send(http_method,
      path: request[:path], body: request[:body], query: request[:query], headers: request[:headers])

    assert_equal(success_body, response.body)
    assert_equal(response_headers.map { |k, v| [k, [v]] }.to_h, response.headers)
  end
end
