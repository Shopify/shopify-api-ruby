require 'test_helper'

class ShopifyApiTest < Test::Unit::TestCase
  
  context "Session" do
    test "should raise error when blank shop url is provided" do
      assert_raise(ArgumentError) { ShopifyAPI::Session.new("") }
    end

    test "should not be valid without token" do
      session = ShopifyAPI::Session.new("testshop.myshopify.com")
      assert_not session.valid?
    end

    test "should be valid with any token" do
      session = ShopifyAPI::Session.new("testshop.myshopify.com", "any-token")
      assert session.valid?
    end
    
  end
end
