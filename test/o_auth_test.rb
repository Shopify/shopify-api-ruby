require 'test_helper'

class OAuthTest < Test::Unit::TestCase
  def test_revoke_kills_the_token
    fake 'oauth/revoke', method: :delete, body: load_fixture('o_auth_revoke')
    assert ShopifyAPI::OAuth.revoke
  end
end
