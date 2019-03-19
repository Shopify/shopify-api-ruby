# frozen_string_literal: true
require 'test_helper'

class ApiVersionTest < Test::Unit::TestCase
  test "no version creates url that start with /admin/" do
    assert_equal(
      "/admin/resource_path/id.json",
      ShopifyAPI::ApiVersion.no_version.construct_api_path("resource_path/id.json")
    )
  end

  test "no version creates graphql url that start with /admin/api" do
    assert_equal(
      "/admin/api/graphql.json",
      ShopifyAPI::ApiVersion.no_version.construct_graphql_path
    )
  end

  test "unstable version creates url that start with /admin/api/unstable/" do
    assert_equal(
      "/admin/api/unstable/resource_path/id.json",
      ShopifyAPI::ApiVersion.unstable.construct_api_path("resource_path/id.json")
    )
  end

  test "unstable version creates graphql url that start with /admin/api/unstable/" do
    assert_equal(
      "/admin/api/unstable/graphql.json",
      ShopifyAPI::ApiVersion.unstable.construct_graphql_path
    )
  end
end
