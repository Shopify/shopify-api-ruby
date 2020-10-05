# frozen_string_literal: true
require 'test_helper'
require_relative 'fixtures/graphql/dummy_schema'

class GraphQLTest < Test::Unit::TestCase
  def setup
    ShopifyAPI::ApiVersion.version_lookup_mode = :define_on_unknown
    @fixture_location = Pathname('test/fixtures/graphql')
    @site = 'https://this-is-my-test-shop.myshopify.com'
    ShopifyAPI::Base.site = @site
  end

  def teardown
    ShopifyAPI::GraphQL.clear_clients
  end

  test '#initialize_clients creates a GraphQL::Client from local schema file' do
    version_fixtures('unstable') do |_dir|
      ShopifyAPI::GraphQL.initialize_clients

      assert ShopifyAPI::GraphQL.client('unstable')
    end
  end

  test '#initialize_clients handles multiple schema files' do
    version_fixtures('unstable', '2019-10') do |_dir|
      ShopifyAPI::GraphQL.initialize_clients

      assert ShopifyAPI::GraphQL.client('unstable')
      assert ShopifyAPI::GraphQL.client('2019-10')
    end
  end

  test '#initialize_clients ignores non JSON schema files' do
    version_fixtures('unstable', '2019-10') do |_dir|
      FileUtils.touch(ShopifyAPI::GraphQL.schema_location.join('nope.txt'))

      ShopifyAPI::GraphQL.initialize_clients

      assert ShopifyAPI::GraphQL.client('unstable')
      assert ShopifyAPI::GraphQL.client('2019-10')
    end
  end

  test '#initialize_clients raises if a JSON schema file is not named after a version' do
    version_fixtures do |dir|
      ShopifyAPI::GraphQL.schema_location = dir
      FileUtils.touch(ShopifyAPI::GraphQL.schema_location.join('nope.json'))

      assert_raises ShopifyAPI::GraphQL::InvalidSchema do
        ShopifyAPI::GraphQL.initialize_clients
      end
    end
  end

  test '#initialize_clients does not raise if raise_on_invalid_schema is set to false' do
    version_fixtures('unstable') do |dir|
      ShopifyAPI::GraphQL.schema_location = dir
      FileUtils.touch(ShopifyAPI::GraphQL.schema_location.join('nope.json'))

      ShopifyAPI::GraphQL.initialize_clients(raise_on_invalid_schema: false)

      assert ShopifyAPI::GraphQL.client('unstable')
    end
  end

  test '#client returns default schema if only one exists' do
    version_fixtures('unstable') do |_dir|
      ShopifyAPI::Base.api_version = 'unstable'

      ShopifyAPI::GraphQL.initialize_clients

      assert_instance_of ::GraphQL::Client, ShopifyAPI::GraphQL.client
    end
  end

  test '#client accepts optional api_version parameter' do
    version_fixtures('unstable') do |_dir|
      ShopifyAPI::Base.api_version = 'unstable'

      ShopifyAPI::GraphQL.initialize_clients

      assert_instance_of ::GraphQL::Client, ShopifyAPI::GraphQL.client('unstable')
    end
  end

  test '#client executes queries on specified API version' do
    version_fixtures('unstable', '2019-10') do |_dir|
      ShopifyAPI::Base.api_version = 'unstable'

      ShopifyAPI::GraphQL.initialize_clients
      ShopifyAPI::Base.site = 'https://this-is-my-test-shop.myshopify.com'

      client = ShopifyAPI::GraphQL.client('2019-10')

      assert_instance_of ::GraphQL::Client, client

      query = client.parse <<~GRAPHQL
        {
          product {
            name
          }
        }
      GRAPHQL

      path = ShopifyAPI::ApiVersion.new('2019-10').construct_graphql_path
      stub_request(:post, "#{@site}#{path}").to_return(body: { product: { name: 'Shirt' } }.to_json)

      client.query(query)
    end
  end

  test '#client raises exception for version that does not exist' do
    version_fixtures('unstable') do |_dir|
      ShopifyAPI::Base.api_version = '2019-10'

      ShopifyAPI::GraphQL.initialize_clients

      assert_raises ShopifyAPI::GraphQL::InvalidClient do
        ShopifyAPI::GraphQL.client('2019-10')
      end
    end
  end

  test '#client lazily initializes clients' do
    version_fixtures('unstable') do |_dir|
      ShopifyAPI::Base.api_version = 'unstable'

      assert_raises ShopifyAPI::GraphQL::InvalidClient do
        ShopifyAPI::GraphQL.client('2019-10')
      end
    end
  end

  test '#client caches lookups' do
    version_fixtures('unstable') do |_dir|
      ShopifyAPI::Base.api_version = 'unstable'

      client1 = ShopifyAPI::GraphQL.client
      client2 = ShopifyAPI::GraphQL.client('unstable')

      assert_equal client1, client2
    end
  end

  test '#client creates execution adapter based off configured class' do
    class SuperDuperExecutionAdapter < ShopifyAPI::GraphQL::HTTPClient
    end

    ShopifyAPI::GraphQL.execution_adapter = SuperDuperExecutionAdapter
    version_fixtures('unstable') do |_dir|
      ShopifyAPI::Base.api_version = 'unstable'

      ShopifyAPI::GraphQL.initialize_clients
      assert_instance_of SuperDuperExecutionAdapter, ShopifyAPI::GraphQL.client('unstable').execute
    end

    ShopifyAPI::GraphQL.execution_adapter = nil
  end

  test '#client creates client based off configured class' do
    class SuperDuperClient < ::GraphQL::Client
    end

    ShopifyAPI::GraphQL.graphql_client = SuperDuperClient
    version_fixtures('unstable') do |_dir|
      ShopifyAPI::Base.api_version = 'unstable'

      ShopifyAPI::GraphQL.initialize_clients

      assert_instance_of SuperDuperClient, ShopifyAPI::GraphQL.client('unstable')
    end

    ShopifyAPI::GraphQL.clear_clients
    ShopifyAPI::GraphQL.graphql_client = nil
  end

  private

  def version_fixtures(*versions)
    Dir.mktmpdir do |dir|
      versions.each do |version|
        FileUtils.cp(@fixture_location.join("#{version}.json"), dir)
      end

      ShopifyAPI::GraphQL.schema_location = dir
      yield(dir)
    end
  end
end
