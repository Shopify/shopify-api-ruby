require 'test_helper'
require 'timecop'

class SessionTest < Test::Unit::TestCase

  def setup
    super
    ShopifyAPI::Session.secret = 'secret'
  end

  test "not be valid without a url" do
    session = ShopifyAPI::Session.new(nil, "any-token")
    assert_not session.valid?
  end

  test "not be valid without token" do
    session = ShopifyAPI::Session.new("testshop.myshopify.com")
    assert_not session.valid?
  end

  test "be valid with any token and any url" do
    session = ShopifyAPI::Session.new("testshop.myshopify.com", "any-token")
    assert session.valid?
  end

  test "not raise error without params" do
    assert_nothing_raised do
      session = ShopifyAPI::Session.new("testshop.myshopify.com", "any-token")
    end
  end

  test "ignore everything but the subdomain in the shop" do
    assert_equal(
      "https://testshop.myshopify.com",
      ShopifyAPI::Session.new("http://user:pass@testshop.notshopify.net/path", "any-token").site
    )
  end

  test "append the myshopify domain if not given" do
    assert_equal "https://testshop.myshopify.com", ShopifyAPI::Session.new("testshop", "any-token").site
  end

  test "not raise error without params" do
    assert_nothing_raised do
      session = ShopifyAPI::Session.new("testshop.myshopify.com", "any-token")
    end
  end

  test "raise error if params passed but signature omitted" do
    assert_raises(ShopifyAPI::ValidationException) do
      session = ShopifyAPI::Session.new("testshop.myshopify.com")
      session.request_token({'code' => 'any-code'})
    end
  end

  test "setup api_key and secret for all sessions" do
    ShopifyAPI::Session.setup(:api_key => "My test key", :secret => "My test secret")
    assert_equal "My test key", ShopifyAPI::Session.api_key
    assert_equal "My test secret", ShopifyAPI::Session.secret
  end

  test "#temp reset ShopifyAPI::Base.site to original value" do

    ShopifyAPI::Session.setup(:api_key => "key", :secret => "secret")
    session1 = ShopifyAPI::Session.new('fakeshop.myshopify.com', 'token1')
    ShopifyAPI::Base.activate_session(session1)

    ShopifyAPI::Session.temp("testshop.myshopify.com", "any-token") {
      @assigned_site = ShopifyAPI::Base.site
    }
    assert_equal 'https://testshop.myshopify.com', @assigned_site.to_s
    assert_equal 'https://fakeshop.myshopify.com', ShopifyAPI::Base.site.to_s
  end

  test "create_permission_url returns correct url with single scope no redirect uri" do
    ShopifyAPI::Session.setup(:api_key => "My_test_key", :secret => "My test secret")
    session = ShopifyAPI::Session.new('http://localhost.myshopify.com')
    scope = ["write_products"]
    permission_url = session.create_permission_url(scope)
    assert_equal "https://localhost.myshopify.com/admin/oauth/authorize?client_id=My_test_key&scope=write_products", permission_url
  end

  test "create_permission_url returns correct url with single scope and redirect uri" do
    ShopifyAPI::Session.setup(:api_key => "My_test_key", :secret => "My test secret")
    session = ShopifyAPI::Session.new('http://localhost.myshopify.com')
    scope = ["write_products"]
    permission_url = session.create_permission_url(scope, "http://my_redirect_uri.com")
    assert_equal "https://localhost.myshopify.com/admin/oauth/authorize?client_id=My_test_key&scope=write_products&redirect_uri=http://my_redirect_uri.com", permission_url
  end

  test "create_permission_url returns correct url with dual scope no redirect uri" do
    ShopifyAPI::Session.setup(:api_key => "My_test_key", :secret => "My test secret")
    session = ShopifyAPI::Session.new('http://localhost.myshopify.com')
    scope = ["write_products","write_customers"]
    permission_url = session.create_permission_url(scope)
    assert_equal "https://localhost.myshopify.com/admin/oauth/authorize?client_id=My_test_key&scope=write_products,write_customers", permission_url
  end

  test "create_permission_url returns correct url with no scope no redirect uri" do
    ShopifyAPI::Session.setup(:api_key => "My_test_key", :secret => "My test secret")
    session = ShopifyAPI::Session.new('http://localhost.myshopify.com')
    scope = []
    permission_url = session.create_permission_url(scope)
    assert_equal "https://localhost.myshopify.com/admin/oauth/authorize?client_id=My_test_key&scope=", permission_url
  end

  test "raise exception if code invalid in request token" do
    ShopifyAPI::Session.setup(:api_key => "My test key", :secret => "My test secret")
    session = ShopifyAPI::Session.new('http://localhost.myshopify.com')
    fake nil, :url => 'https://localhost.myshopify.com/admin/oauth/access_token',:method => :post, :status => 404, :body => '{"error" : "invalid_request"}'
    assert_raises(ShopifyAPI::ValidationException) do
      session.request_token(params={:code => "bad-code"})
    end
    assert_equal false, session.valid?
  end

  test "return site for session" do
    session = ShopifyAPI::Session.new("testshop.myshopify.com", "any-token")
    assert_equal "https://testshop.myshopify.com", session.site
  end

  test "return_token_if_signature_is_valid" do
    fake nil,
      url: 'https://testshop.myshopify.com/admin/oauth/access_token',
      method: :post,
      body: '{"access_token":"any-token"}'
    session = ShopifyAPI::Session.new("testshop.myshopify.com")

    params = { code: 'any-code', timestamp: Time.now }
    token = session.request_token(params.merge(hmac: generate_signature(params)))

    assert_equal "any-token", token
    assert_equal "any-token", session.token
  end

  test "extra parameters are stored in session" do
    fake nil,
      url: 'https://testshop.myshopify.com/admin/oauth/access_token',
      method: :post,
      body: '{"access_token":"any-token","foo":"example"}'
    session = ShopifyAPI::Session.new("testshop.myshopify.com")

    params = { code: 'any-code', timestamp: Time.now }
    assert session.request_token(params.merge(hmac: generate_signature(params)))

    assert_equal ({ "foo" => "example" }), session.extra
  end

  test "expires_in is automatically converted in expires_at" do
    fake nil,
      url: 'https://testshop.myshopify.com/admin/oauth/access_token',
      method: :post,
      body: '{"access_token":"any-token","expires_in":86393}'
    session = ShopifyAPI::Session.new("testshop.myshopify.com")

    Timecop.freeze do
      params = { code: 'any-code', timestamp: Time.now }
      assert session.request_token(params.merge(hmac: generate_signature(params)))

      expires_at = Time.now.utc + 86393
      assert_equal ({ "expires_at" => expires_at.to_i }), session.extra
      assert session.expires_at.is_a?(Time)
      assert_equal expires_at.to_i, session.expires_at.to_i
      assert_equal 86393, session.expires_in
      assert_equal false, session.expired?

      Timecop.travel(session.expires_at) do
        assert_equal true, session.expired?
      end
    end
  end

  test "raise error if signature does not match expected" do
    params = {:code => "any-code", :timestamp => Time.now}
    signature = generate_signature(params)
    params[:foo] = 'world'
    assert_raises(ShopifyAPI::ValidationException) do
      session = ShopifyAPI::Session.new("testshop.myshopify.com")
      session.request_token(params.merge(:hmac => signature))
    end
  end

  test "raise error if timestamp is too old" do
    params = {:code => "any-code", :timestamp => Time.now - 2.days}
    signature = generate_signature(params)
    params[:foo] = 'world'
    assert_raises(ShopifyAPI::ValidationException) do
      session = ShopifyAPI::Session.new("testshop.myshopify.com")
      session.request_token(params.merge(:hmac => signature))
    end
  end

  test "return true when the signature is valid and the keys of params are strings" do
    params = { 'code' => 'any-code', 'timestamp' => Time.now }
    params[:hmac] = generate_signature(params)
    assert_equal true, ShopifyAPI::Session.validate_signature(params)
  end

  test "return true when validating signature of params with ampersand and equal sign characters" do
    ShopifyAPI::Session.secret = 'secret'
    params = { 'a' => '1&b=2', 'c=3&d' => '4' }
    to_sign = 'a=1%26b=2&c%3D3%26d=4'
    params[:hmac] = generate_signature(to_sign)
    assert_equal true, ShopifyAPI::Session.validate_signature(params)
  end

  test "return true when validating signature of params with percent sign characters" do
    ShopifyAPI::Session.secret = 'secret'
    params = { 'a%3D1%26b' => '2%26c%3D3' }
    to_sign = 'a%253D1%2526b=2%2526c%253D3'
    params[:hmac] = generate_signature(to_sign)
    assert_equal true, ShopifyAPI::Session.validate_signature(params)
  end

  private

  def make_sorted_params(params)
    params.with_indifferent_access.except(
      :signature, :hmac, :action, :controller
    ).collect { |k, v| "#{k}=#{v}" }.sort.join('&')
  end

  def generate_signature(params)
    params = make_sorted_params(params) if params.is_a?(Hash)
    OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA256.new, ShopifyAPI::Session.secret, params)
  end
end
