require 'test_helper'
require 'mocha/minitest'
require 'minitest/focus'
class GraphQLTest < Test::Unit::TestCase
  ## TODO: Need a test that confirms the token is set in the header.
  test "ShopifyAPI::GraphQL.schema_file should get/set" do
    file = "tbd"
    assert (ShopifyAPI::GraphQL.schema_file).nil?, "No default schema_file"
    ShopifyAPI::GraphQL.schema_file = file
    assert_equal file, ShopifyAPI::GraphQL.schema_file
  end

  test "ShopifyAPI::GraphQL.session should return client" do
    tmp_file = "test-schema.json"
    File.unlink(tmp_file) if File.exists?(tmp_file)

    shop = "this-is-my-test-shop.myshopify.com"
    token = "fake-shop-token"
    url = "https://#{shop}/admin/api/2019-10/graphql.json"
    expect_headers = { 'X-Shopify-Access-Token' => token }
    # Switching from fake to Mock requires that we code the MockObject to retun stuff.
    fake 'graphql', :method => :post, :status => 200, :body => load_fixture('graphql'), :url => url, :headers => expect_headers
  
    # schema = GraphQL::Client.load_schema("test/fixtures/graphql.json")
    # GraphQL::Client.expects(:dump_schema).times(1)
    # GraphQL::Client.expects(:load_schema).times(2).returns(schema)
  
    ShopifyAPI::GraphQL.schema_file = tmp_file
    client = ShopifyAPI::GraphQL.session(shop, token)
    assert_equal ::GraphQL::Client, client.class, "Client is something"
    assert_requested :post, url, :headers => expect_headers, :times => 1
    assert File.exists?(tmp_file), "Made a schema file"

    # Use the class attr schema. Neither file nor network request.
    client2 = ShopifyAPI::GraphQL.session("junk-shop", "junk-token")
    assert_equal GraphQL::Client, client2.class, "Client is something"
    # TODO: Confirm no net request
  end

  focus
  test "Support json and graphql files" do
    ShopifyAPI::GraphQL.schema_file = "test/fixtures/graphql.graphql"
    assert_instance_of ::GraphQL::Schema, ShopifyAPI::GraphQL.class_variable_get(:@@schema), "Loaded graphql file"

    ShopifyAPI::GraphQL.class_variable_set(:@@schema, nil)

    ShopifyAPI::GraphQL.schema_file = "test/fixtures/graphql.json"
    assert_instance_of ::GraphQL::Schema, ShopifyAPI::GraphQL.schema, "Loaded json file"
  end

  test "Multi-sessions are supported" do
  end
end
