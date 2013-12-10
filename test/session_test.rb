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

    should "raise error if params passed but signature omitted" do
      assert_raises(RuntimeError) do
        session = ShopifyAPI::Session.new("testshop.myshopify.com", "any-token", {'foo' => 'bar'})
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

    should "create_permission_url returns correct url with single scope no redirect uri" do
      ShopifyAPI::Session.setup(:api_key => "My_test_key", :secret => "My test secret")
      session = ShopifyAPI::Session.new('http://localhost.myshopify.com')
      scope = ["write_products"]
      permission_url = session.create_permission_url(scope)
      assert_equal "https://localhost.myshopify.com/admin/oauth/authorize?client_id=My_test_key&scope=write_products", permission_url
    end

    should "create_permission_url returns correct url with single scope and redirect uri" do
      ShopifyAPI::Session.setup(:api_key => "My_test_key", :secret => "My test secret")
      session = ShopifyAPI::Session.new('http://localhost.myshopify.com')
      scope = ["write_products"]
      permission_url = session.create_permission_url(scope, "http://my_redirect_uri.com")
      assert_equal "https://localhost.myshopify.com/admin/oauth/authorize?client_id=My_test_key&scope=write_products&redirect_uri=http://my_redirect_uri.com", permission_url
    end

    should "create_permission_url returns correct url with dual scope no redirect uri" do
      ShopifyAPI::Session.setup(:api_key => "My_test_key", :secret => "My test secret")
      session = ShopifyAPI::Session.new('http://localhost.myshopify.com')
      scope = ["write_products","write_customers"]
      permission_url = session.create_permission_url(scope)
      assert_equal "https://localhost.myshopify.com/admin/oauth/authorize?client_id=My_test_key&scope=write_products,write_customers", permission_url
    end

    should "create_permission_url returns correct url with no scope no redirect uri" do
      ShopifyAPI::Session.setup(:api_key => "My_test_key", :secret => "My test secret")
      session = ShopifyAPI::Session.new('http://localhost.myshopify.com')
      scope = []
      permission_url = session.create_permission_url(scope)
      assert_equal "https://localhost.myshopify.com/admin/oauth/authorize?client_id=My_test_key&scope=", permission_url
    end

    should "request token should get token" do
      ShopifyAPI::Session.setup(:api_key => "My test key", :secret => "My test secret")
      session = ShopifyAPI::Session.new('http://localhost.myshopify.com')
      fake nil, :url => 'https://localhost.myshopify.com/admin/oauth/access_token',:method => :post, :body => '{"access_token" : "token"}'
      assert_equal "token", session.request_token("code")
    end

    should "raise exception if code invalid in request token" do
      ShopifyAPI::Session.setup(:api_key => "My test key", :secret => "My test secret")
      session = ShopifyAPI::Session.new('http://localhost.myshopify.com')
      fake nil, :url => 'https://localhost.myshopify.com/admin/oauth/access_token',:method => :post, :status => 404, :body => '{"error" : "invalid_request"}'
      assert_raises(RuntimeError) do
        session.request_token("bad_code")
      end
      assert_equal false, session.valid?
    end

    should "#temp reset ShopifyAPI::Base.site to original value when using a non-standard port" do
      ShopifyAPI::Session.setup(:api_key => "key", :secret => "secret")
      session1 = ShopifyAPI::Session.new('fakeshop.myshopify.com:3000', 'token1')
      ShopifyAPI::Base.activate_session(session1)

      ShopifyAPI::Session.temp("testshop.myshopify.com", "any-token") {
        @assigned_site = ShopifyAPI::Base.site
      }
      assert_equal 'https://testshop.myshopify.com/admin', @assigned_site.to_s
      assert_equal 'https://fakeshop.myshopify.com:3000/admin', ShopifyAPI::Base.site.to_s
    end

    should "return site for session" do
      session = ShopifyAPI::Session.new("testshop.myshopify.com", "any-token")
      assert_equal "https://testshop.myshopify.com/admin", session.site
    end

    should "raise error if signature does not match expected" do
      ShopifyAPI::Session.secret = 'secret'
      params = {:foo => 'hello', :foo => 'world', :timestamp => Time.now}
      sorted_params = params.except(:signature, :action, :controller).collect{|k,v|"#{k}=#{v}"}.sort.join
      signature = Digest::MD5.hexdigest(ShopifyAPI::Session.secret + sorted_params)

      session = ShopifyAPI::Session.new("testshop.myshopify.com", "any-token", params.merge(:signature => signature))
    end
  end
end
