require 'test_helper'
require 'mocha/minitest'
require 'minitest/focus'
class GraphQLTest < Test::Unit::TestCase

  def test_schema_save
    assert ShopifyAPI::GraphQL.schema_save, 'Default to save'
    assert_raises Exception do
      ShopifyAPI::GraphQL.schema_save = 'false'
    end
    
    ShopifyAPI::GraphQL.schema_save = false
    assert_equal false, ShopifyAPI::GraphQL.schema_save, 'Support being false'

    ShopifyAPI::GraphQL.schema_save = true
    assert ShopifyAPI::GraphQL.schema_save, 'Support being true'

    tmp = 'never-written'
    ShopifyAPI::GraphQL.class_variable_set(:@@schema_file, tmp)
    File.exists?(tmp)
  end

  test "ShopifyAPI::GraphQL.schema_file should get/set" do
    ShopifyAPI::GraphQL.class_variable_set(:@@schema, nil)
    ShopifyAPI::GraphQL.class_variable_set(:@@schema_file, nil)

    ShopifyAPI::GraphQL.schema_file = 'tbd'
    assert_equal 'tbd', ShopifyAPI::GraphQL.schema_file
    assert nil == ShopifyAPI::GraphQL.schema, "No schema created when setting non-existing file"
  end

  test "ShopifyAPI::GraphQL.session create missing schema file" do
    require 'tempfile'
    tmp_file = Tempfile.new

    shop = "this-is-my-test-shop.myshopify.com"
    token = "fake-shop-token"
    url = "https://#{shop}/admin/api/2019-10/graphql.json"
    expect_headers = { 'X-Shopify-Access-Token' => token }

    fake 'graphql', :method => :post, :status => 200, :body => load_fixture('graphql'), :url => url, :headers => expect_headers
    
    # Switching from WebFake to WebMock requires that we code the MockObject to retun stuff.
    # schema = GraphQL::Client.load_schema("test/fixtures/graphql.json")
    # GraphQL::Client.expects(:dump_schema).times(1)
    # GraphQL::Client.expects(:load_schema).times(2).returns(schema)
  
    ShopifyAPI::GraphQL.schema_file = tmp_file.path
    client = ShopifyAPI::GraphQL.session(shop, token)
    assert_equal ::GraphQL::Client, client.class, "Client is something"
    assert_requested :post, url, :headers => expect_headers, :times => 1
    assert File.exists?(tmp_file.path), "Made a schema file"
  end

  test "Support json and graphql files" do
    ShopifyAPI::GraphQL.schema_file = "test/fixtures/graphql.graphql"
    assert_instance_of ::GraphQL::Schema, ShopifyAPI::GraphQL.class_variable_get(:@@schema), "Loaded graphql file"
    
    ShopifyAPI::GraphQL.class_variable_set(:@@schema, nil)
    
    ShopifyAPI::GraphQL.schema_file = "test/fixtures/graphql.json"
    assert_instance_of ::GraphQL::Schema, ShopifyAPI::GraphQL.schema, "Loaded json file"
  end
  
  test "Support multiple sessions in same thread" do
    ShopifyAPI::GraphQL.schema_file = "test/fixtures/graphql.graphql"
    s1 = ShopifyAPI::GraphQL.session('shop1-name', 'shop1-token')
    s2 = ShopifyAPI::GraphQL.session('shop2-name', 'shop2-token')
    assert_equal 'shop1-name.myshopify.com', s1.http.uri.host
    assert_equal 'shop2-name.myshopify.com', s2.http.uri.host
    assert_equal 'shop1-token', s1.http.headers({})['X-Shopify-Access-Token']
    assert_equal 'shop2-token', s2.http.headers({})['X-Shopify-Access-Token']
  end
end
