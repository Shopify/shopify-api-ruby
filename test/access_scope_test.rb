# frozen_string_literal: true
require 'test_helper'

class AccessScopeTest < Test::Unit::TestCase
  test 'access scope does not use the versioned resource urls' do
    fake(
      'access_scopes',
      url: 'https://shop2.myshopify.com/admin/oauth/access_scopes.json',
      method: :get,
      status: 201,
      body: load_fixture('access_scopes'),
      extension: false
    )

    unstable_version = ShopifyAPI::Session.new(domain: 'shop2.myshopify.com', token: 'token2', api_version: :unstable)

    ShopifyAPI::Base.activate_session(unstable_version)

    scope_handles = ShopifyAPI::AccessScope.find(:all).map(&:handle)

    assert_equal(['write_product_listings', 'read_shipping'], scope_handles)
  end
end
