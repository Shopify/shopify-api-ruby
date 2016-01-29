require 'test_helper'

class ConnectionTest < Test::Unit::TestCase
  test 'initialize with a nil site should raise an exception' do
    error = assert_raises ArgumentError do
      ActiveResource::Connection.new(nil)
    end
    assert_equal 'Missing site URI. Make sure ShopifyAPI calls are wrapped in a Shopify session', error.message
  end

  test 'initialize with a site should not raise an exception' do
    assert_nothing_raised do
      connection = ActiveResource::Connection.new('some_site.com')
      assert_equal 'some_site.com', connection.site.to_s
    end
  end
end
