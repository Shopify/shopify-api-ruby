# typed: strict
# frozen_string_literal: true

$VERBOSE = nil
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "webmock/minitest"

require "shopify_api"
require_relative "../../test_helper"

class DeprecatedApiCall202110Test < Test::Unit::TestCase
  def setup
    super

    test_session = ShopifyAPI::Auth::Session.new(id: "id", shop: "test-shop.myshopify.io", access_token: "this_is_a_test_token")
    ShopifyAPI::Context.activate_session(test_session)
    modify_context(api_version: "2021-10")
  end

  def teardown
    super

    ShopifyAPI::Context.deactivate_session
  end

  sig do
    void
  end
  def test_1()
    stub_request(:get, "https://test-shop.myshopify.io/admin/api/2021-10/deprecated_api_calls.json")
      .with(
        headers: {"X-Shopify-Access-Token"=>"this_is_a_test_token", "Accept"=>"application/json"},
        body: {}
      )
      .to_return(status: 200, body: JSON.generate({"data_updated_at" => "2020-10-13T00:15:30Z", "deprecated_api_calls" => [{"api_type" => "REST", "description" => "The page filter has been removed from multiple endpoints. Use cursor-based pagination instead.", "documentation_url" => "https://shopify.dev/tutorials/make-paginated-requests-to-rest-admin-api", "endpoint" => "Product", "last_call_at" => "2020-06-12T03:46:18Z", "migration_deadline" => "2020-07-02T13:00:00Z", "graphql_schema_name" => nil, "version" => "2019-07"}]}), headers: {})

    ShopifyAPI::DeprecatedApiCall.all()

    assert_requested(:get, "https://test-shop.myshopify.io/admin/api/2021-10/deprecated_api_calls.json")
  end

end
