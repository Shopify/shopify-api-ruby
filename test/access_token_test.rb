# frozen_string_literal: true
require 'test_helper'

class AccessTokenTest < Test::Unit::TestCase

  def test_delegate_access_token
    fake(
      "access_tokens/delegate.json?delegate_access_scope%5B%5D=write_orders&" \
      "delegate_access_scope%5B%5D=read_products&expires_in=",
      method: :post,
      status: 201,
      body: load_fixture('access_token_delegate'),
      extension: false
    )
    delegate_scope = ['write_orders', 'read_products']
    token = ShopifyAPI::AccessToken.delegate(delegate_scope)

    assert_equal('abracadabra', token.access_token)
    assert_equal('write_orders,read_products', token.scope)
  end
end
