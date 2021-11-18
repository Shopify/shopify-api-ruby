# typed: false
# frozen_string_literal: true

require_relative "../../test_helper.rb"

class GraphQLStorefrontTest < Test::Unit::TestCase
  def setup
    @session = ShopifyAPI::Auth::Session.new(shop: "test-shop.myshopify.com")
    @storefront_access_token = SecureRandom.alphanumeric(10)
    @client = ShopifyAPI::Clients::Graphql::Storefront.new(@session, @storefront_access_token)
    @expected_headers = {
      "Accept-Encoding": "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "User-Agent": "Shopify API Library v#{ShopifyAPI::VERSION} | Ruby #{RUBY_VERSION}",
      "Content-Type": "application/json",
      "Accept": "application/json",
      "X-Shopify-Storefront-Access-Token": @storefront_access_token,
    }
    @success_body = { "success" => true }
    @response_headers = { "content-type" => "application/json" }
  end

  def test_can_make_query
    query = "
    {
      shop {
        name
      }
    }"
    extra_headers = { extra: "header" }
    @expected_headers.merge(extra_headers)
    body = { query: query, variables: nil }

    stub_request(:post, "https://#{@session.shop}/api/#{ShopifyAPI::Context.api_version}/graphql.json")
      .with(body: body, headers: @expected_headers)
      .to_return(body: @success_body.to_json, headers: @response_headers)

    response = @client.query(data: query, headers: extra_headers)
    assert_equal(@success_body, response.body)
  end
end
