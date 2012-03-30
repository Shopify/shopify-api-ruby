require 'test_helper'

class SessionTest < Test::Unit::TestCase
  
  context "Session" do
    should "not be valid without a url" do
      session = ShopifyAPI::Session.new(nil, "any-token")
      assert_not session.valid?
    end
    
    should "not be valid without token" do
      session = ShopifyAPI::Session.new("testshop.myshopify.com")
      assert_not session.valid?
    end

    should "be valid with any token and any url" do
      session = ShopifyAPI::Session.new("testshop.myshopify.com", "any-token")
      assert session.valid?
    end
    
    should "not raise error without params" do
      assert_nothing_raised do
        session = ShopifyAPI::Session.new("testshop.myshopify.com", "any-token")
      end
    end

    should "setup api_key and secret for all sessions" do
      ShopifyAPI::Session.setup(:api_key => "My test key", :secret => "My test secret")
      assert_equal "My test key", ShopifyAPI::Session.api_key
      assert_equal "My test secret", ShopifyAPI::Session.secret
    end
    
    should "use 'https' protocol by default for all sessions" do
      assert_equal 'https', ShopifyAPI::Session.protocol
    end

    should "#temp reset ShopifyAPI::Base.site to original value" do
      
      ShopifyAPI::Session.setup(:api_key => "key", :secret => "secret")
      session1 = ShopifyAPI::Session.new('fakeshop.myshopify.com', 'token1')
      ShopifyAPI::Base.activate_session(session1)

      ShopifyAPI::Session.temp("testshop.myshopify.com", "any-token") {
        @assigned_site = ShopifyAPI::Base.site
      }
      assert_equal 'https://testshop.myshopify.com/admin', @assigned_site.to_s
      assert_equal 'https://fakeshop.myshopify.com/admin', ShopifyAPI::Base.site.to_s
    end

    should "return site for session" do
      session = ShopifyAPI::Session.new("testshop.myshopify.com", "any-token")
      assert_equal "https://testshop.myshopify.com/admin", session.site
    end
  end
end
