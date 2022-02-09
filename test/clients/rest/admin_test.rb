# typed: false
# frozen_string_literal: true

require_relative "../../test_helper.rb"

class AdminTest < Test::Unit::TestCase
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

  def test_path_starting_at_admin_overrides_default
    session = ShopifyAPI::Auth::Session.new(
      shop: "test-shop.myshopify.com",
      access_token: SecureRandom.alphanumeric(10)
    )
    client = ShopifyAPI::Clients::Rest::Admin.new(session: session)

    request_path = "/admin/some-custom-path"

    success_body = { "success" => true }
    response_headers = { "content-type" => "application/json" }

    stub_request(:get, "https://#{session.shop}#{request_path}")
      .to_return(body: success_body.to_json, headers: response_headers)

    response = client.send(:get, path: request_path)

    assert_equal(success_body, response.body)
    assert_equal(response_headers.to_h { |k, v| [k, [v]] }, response.headers)
  end

  private

  def run_test(http_method)
    session = ShopifyAPI::Auth::Session.new(shop: "test-shop.myshopify.com",
      access_token: SecureRandom.alphanumeric(10))
    client = ShopifyAPI::Clients::Rest::Admin.new(session: session)

    request = {
      path: "some-path",
      body: { foo: "bar" },
      query: { id: 1234 },
      headers: { extra: "header" },
    }

    expected_headers = TestHelpers::Constants::DEFAULT_CLIENT_HEADERS.merge({
      "X-Shopify-Access-Token": session.access_token,
    }).merge(request[:headers])

    success_body = { "success" => true }
    response_headers = { "content-type" => "application/json" }

    stub_request(http_method, "https://#{session.shop}/admin/api/#{ShopifyAPI::Context.api_version}/#{request[:path]}")
      .with(body: request[:body].to_json, query: request[:query], headers: expected_headers)
      .to_return(body: success_body.to_json, headers: response_headers)

    response = client.send(http_method,
      path: request[:path], body: request[:body], query: request[:query], headers: request[:headers])

    assert_equal(success_body, response.body)
    assert_equal(response_headers.to_h { |k, v| [k, [v]] }, response.headers)
  end
end
