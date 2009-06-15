require 'test_helper'

class ShopifyApiTest < Test::Unit::TestCase
  def setup
    @session_no_token = ShopifyAPI::Session.new("testshop.myshopify.com")
    @session = ShopifyAPI::Session.new("testshop.myshopify.com", "any-token")
  end
  
  
  def test_session_not_valid_without_token
    assert_not @session_no_token.valid?
  end
  
  def test_session_is_valid_with_any_token
    assert @session.valid?
  end
  
end
