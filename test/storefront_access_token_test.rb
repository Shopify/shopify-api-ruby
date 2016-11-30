require 'test_helper'

class StorefrontAccessTokenTest < Test::Unit::TestCase

  def test_create_storefront_access_token
    fake "storefront_access_tokens", :method => :post, :body => load_fixture('storefront_access_token')
    storefront_access_token = ShopifyAPI::StorefrontAccessToken.create(title: 'Test')
    assert_equal 1, storefront_access_token.id
    assert_equal "Test", storefront_access_token.title
  end

  def test_delete_storefront_access_token
    fake 'storefront_access_tokens/1', method: :get, status: 200, body: load_fixture('storefront_access_token')
    fake 'storefront_access_tokens/1', method: :delete, status: 200, body: 'destroyed'
    
    storefront_access_tokens = ShopifyAPI::StorefrontAccessToken.find(1)
    assert storefront_access_tokens.destroy
  end

  def test_get_storefront_access_tokens
    fake "storefront_access_tokens", method: :get, status: 201, body: load_fixture('storefront_access_tokens')

    tokens = ShopifyAPI::StorefrontAccessToken.all

    assert_equal 2, tokens.size
    assert_equal 1, tokens.first.id
    assert_equal 2, tokens.last.id
    assert_equal 'Test 1', tokens.first.title
    assert_equal 'Test 2', tokens.last.title
  end

end
