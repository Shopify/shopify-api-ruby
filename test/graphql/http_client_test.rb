# frozen_string_literal: true
require 'test_helper'

module GraphQL
  class HTTPClientTest < Test::Unit::TestCase
    test '#headers uses the Base headers' do
      ShopifyAPI::Base.headers['X-Custom'] = 'abc'

      client = ShopifyAPI::GraphQL::HTTPClient.new('2019-07')

      assert_equal 'abc', client.headers({})['X-Custom']

      ShopifyAPI::Base.headers.delete('X-Custom')
    end

    test '#uri uses the Base site and the API version' do
      ShopifyAPI::Base.site = 'https://foo:bar@www.zombo.com'
      api_version = ShopifyAPI::ApiVersion.new(handle: '2019-07')

      client = ShopifyAPI::GraphQL::HTTPClient.new(api_version)
      expected_uri = URI('https://foo:bar@www.zombo.com/admin/api/2019-07/graphql.json')

      assert_equal expected_uri, client.uri
    end
  end
end
