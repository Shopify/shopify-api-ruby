require 'test_helper'
require 'timecop'

class SessionTest < Test::Unit::TestCase

  def setup
    super
    ShopifyAPI::Session.secret = 'secret'
  end

  test "not be valid without a url" do
    session = ShopifyAPI::Session.new(domain: nil, token: "any-token", api_version: any_api_version)
    assert_not session.valid?
  end

  test "not be valid without token" do
    session = ShopifyAPI::Session.new(domain: "testshop.myshopify.com", token: nil, api_version: any_api_version)
    assert_not session.valid?
  end

  test "not be valid without an API version" do
    session = ShopifyAPI::Session.new(domain: "testshop.myshopify.com", token: "any-token", api_version: nil)
    assert_not session.valid?

    session = ShopifyAPI::Session.new(domain: "testshop.myshopify.com", token: "any-token", api_version: ShopifyAPI::ApiVersion::NullVersion)
    assert_not session.valid?
  end

  test "default to base API version" do
    session = ShopifyAPI::Session.new(domain: "testshop.myshopify.com", token: "any-token")
    assert session.valid?
    assert_equal session.api_version, ShopifyAPI::Base.api_version
  end

  test "can override the base API version" do
    different_api_version = '2020-01'
    session = ShopifyAPI::Session.new(domain: "testshop.myshopify.com", token: "any-token", api_version: different_api_version)
    assert session.valid?
    assert_equal session.api_version, ShopifyAPI::ApiVersion.find_version(different_api_version)
  end

  test "be valid with any token, any url and version" do
    session = ShopifyAPI::Session.new(
      domain: "testshop.myshopify.com",
      token: "any-token",
      api_version: any_api_version
    )
    assert session.valid?
  end

  test "not raise error without params" do
    assert_nothing_raised do
      ShopifyAPI::Session.new(domain: "testshop.myshopify.com", token: "any-token", api_version: any_api_version)
    end
  end

  test "ignore everything but the subdomain in the shop" do
    assert_equal(
      "https://testshop.myshopify.com",
      ShopifyAPI::Session.new(
        domain: "http://user:pass@testshop.notshopify.net/path",
        token: "any-token",
        api_version: any_api_version
      ).site
    )
  end

  test "append the myshopify domain if not given" do
    assert_equal(
      "https://testshop.myshopify.com",
      ShopifyAPI::Session.new(domain: "testshop", token: "any-token", api_version: any_api_version).site
    )
  end

  test "not raise error without params" do
    assert_nothing_raised do
      ShopifyAPI::Session.new(domain: "testshop.myshopify.com", token: "any-token", api_version: any_api_version)
    end
  end

  test "raise error if params passed but signature omitted" do
    assert_raises(ShopifyAPI::ValidationException) do
      session = ShopifyAPI::Session.new(domain: "testshop.myshopify.com", token: nil, api_version: any_api_version)
      session.request_token({ 'code' => 'any-code' })
    end
  end

  test "setup api_key and secret for all sessions" do
    ShopifyAPI::Session.setup(:api_key => "My test key", :secret => "My test secret")
    assert_equal "My test key", ShopifyAPI::Session.api_key
    assert_equal "My test secret", ShopifyAPI::Session.secret
  end

  test "#temp reset ShopifyAPI::Base values to original value" do
    session1 = ShopifyAPI::Session.new(domain: 'fakeshop.myshopify.com', token: 'token1', api_version: '2019-01')
    ShopifyAPI::Base.user = 'foo'
    ShopifyAPI::Base.password = 'bar'
    ShopifyAPI::Base.activate_session(session1)

    ShopifyAPI::Session.temp(domain: "testshop.myshopify.com", token: "any-token", api_version: :unstable) do
      @assigned_site = ShopifyAPI::Base.site
      @assigned_version = ShopifyAPI::Base.api_version
      @assigned_user = ShopifyAPI::Base.user
      @assigned_password = ShopifyAPI::Base.password
    end

    assert_equal('https://testshop.myshopify.com', @assigned_site.to_s)
    assert_equal('https://fakeshop.myshopify.com', ShopifyAPI::Base.site.to_s)

    assert_equal(ShopifyAPI::ApiVersion.new(handle: :unstable), @assigned_version)
    assert_equal(ShopifyAPI::ApiVersion.new(handle: '2019-01'), ShopifyAPI::Base.api_version)

    assert_nil(@assigned_user)
    assert_equal('foo', ShopifyAPI::Base.user)

    assert_nil(@assigned_password)
    assert_equal('bar', ShopifyAPI::Base.password)
  end

  test "#temp does not use basic auth values from Base.site" do
    ShopifyAPI::Base.site = 'https://user:pass@fakeshop.myshopify.com'

    ShopifyAPI::Session.temp(domain: "testshop.myshopify.com", token: "any-token", api_version: :unstable) do
      @assigned_site = ShopifyAPI::Base.site
      @assigned_user = ShopifyAPI::Base.user
      @assigned_password = ShopifyAPI::Base.password
    end

    assert_equal('https://testshop.myshopify.com', @assigned_site.to_s)
    assert_equal('https://fakeshop.myshopify.com', ShopifyAPI::Base.site.to_s)

    assert_nil(@assigned_user)
    assert_equal('user', ShopifyAPI::Base.user)

    assert_nil(@assigned_password)
    assert_equal('pass', ShopifyAPI::Base.password)
  end

  test "#with_session activates the session for the duration of the block" do
    session1 = ShopifyAPI::Session.new(domain: 'fakeshop.myshopify.com', token: 'token1', api_version: '2019-01')
    ShopifyAPI::Base.activate_session(session1)

    other_session = ShopifyAPI::Session.new(
      domain: "testshop.myshopify.com",
      token: "any-token",
      api_version: :unstable
    )

    ShopifyAPI::Session.with_session(other_session) do
      @assigned_site = ShopifyAPI::Base.site
      @assigned_version = ShopifyAPI::Base.api_version
    end

    assert_equal('https://testshop.myshopify.com', @assigned_site.to_s)
    assert_equal('https://fakeshop.myshopify.com', ShopifyAPI::Base.site.to_s)

    assert_equal(ShopifyAPI::ApiVersion.new(handle: :unstable), @assigned_version)
    assert_equal(ShopifyAPI::ApiVersion.new(handle: '2019-01'), ShopifyAPI::Base.api_version)
  end

  test "#with_session resets the activated session even if there an exception during the block" do
    session1 = ShopifyAPI::Session.new(domain: 'fakeshop.myshopify.com', token: 'token1', api_version: '2019-01')
    ShopifyAPI::Base.activate_session(session1)

    other_session = ShopifyAPI::Session.new(
      domain: "testshop.myshopify.com",
      token: "any-token",
      api_version: :unstable
    )

    assert_raises StandardError do
      ShopifyAPI::Session.with_session(other_session) { raise StandardError, "" }
    end

    assert_equal('https://fakeshop.myshopify.com', ShopifyAPI::Base.site.to_s)
    assert_equal(ShopifyAPI::ApiVersion.new(handle: '2019-01'), ShopifyAPI::Base.api_version)
  end

  test "#with_version will adjust the actvated api version for the duration of the block" do
    session1 = ShopifyAPI::Session.new(domain: 'fakeshop.myshopify.com', token: 'token1', api_version: '2019-01')
    ShopifyAPI::Base.activate_session(session1)

    ShopifyAPI::Session.with_version(:unstable) do
      @assigned_site = ShopifyAPI::Base.site
      @assigned_version = ShopifyAPI::Base.api_version
    end

    assert_equal('https://fakeshop.myshopify.com', @assigned_site.to_s)
    assert_equal('https://fakeshop.myshopify.com', ShopifyAPI::Base.site.to_s)

    assert_equal(ShopifyAPI::ApiVersion.new(handle: :unstable), @assigned_version)
    assert_equal(ShopifyAPI::ApiVersion.new(handle: '2019-01'), ShopifyAPI::Base.api_version)
  end

  test "create_permission_url requires redirect_uri" do
    ShopifyAPI::Session.setup(api_key: "My_test_key", secret: "My test secret")
    session = ShopifyAPI::Session.new(
      domain: 'http://localhost.myshopify.com',
      token: 'any-token',
      api_version: any_api_version
    )
    scope = ["write_products"]
    assert_raises(ArgumentError) do
      session.create_permission_url(scope)
    end
  end

  test "create_permission_url returns correct url with single scope and redirect uri" do
    ShopifyAPI::Session.setup(api_key: "My_test_key", secret: "My test secret")
    session = ShopifyAPI::Session.new(
      domain: 'http://localhost.myshopify.com',
      token: 'any-token',
      api_version: any_api_version
    )
    scope = ["write_products"]
    permission_url = session.create_permission_url(scope, "http://my_redirect_uri.com")
    assert_equal "https://localhost.myshopify.com/admin/oauth/authorize?client_id=My_test_key&scope=write_products&redirect_uri=http://my_redirect_uri.com", permission_url
  end

  test "create_permission_url returns correct url with dual scope" do
    ShopifyAPI::Session.setup(api_key: "My_test_key", secret: "My test secret")
    session = ShopifyAPI::Session.new(
      domain: 'http://localhost.myshopify.com',
      token: 'any-token',
      api_version: any_api_version
    )
    scope = ["write_products","write_customers"]
    permission_url = session.create_permission_url(scope, "http://my_redirect_uri.com")
    assert_equal "https://localhost.myshopify.com/admin/oauth/authorize?client_id=My_test_key&scope=write_products,write_customers&redirect_uri=http://my_redirect_uri.com", permission_url
  end

  test "create_permission_url returns correct url with no scope" do
    ShopifyAPI::Session.setup(api_key: "My_test_key", secret: "My test secret")
    session = ShopifyAPI::Session.new(
      domain: 'http://localhost.myshopify.com',
      token: 'any-token',
      api_version: any_api_version
    )
    scope = []
    permission_url = session.create_permission_url(scope, "http://my_redirect_uri.com")
    assert_equal "https://localhost.myshopify.com/admin/oauth/authorize?client_id=My_test_key&scope=&redirect_uri=http://my_redirect_uri.com", permission_url
  end

  test "create_permission_url returns correct url with state" do
    ShopifyAPI::Session.setup(api_key: "My_test_key", secret: "My test secret")
    session = ShopifyAPI::Session.new(
      domain: 'http://localhost.myshopify.com',
      token: 'any-token',
      api_version: any_api_version
    )
    scope = []
    permission_url = session.create_permission_url(scope, "http://my_redirect_uri.com", state: "My nonce")
    assert_equal "https://localhost.myshopify.com/admin/oauth/authorize?client_id=My_test_key&scope=&redirect_uri=http://my_redirect_uri.com&state=My%20nonce", permission_url
  end

  test "raise exception if code invalid in request token" do
    ShopifyAPI::Session.setup(:api_key => "My test key", :secret => "My test secret")
    session = ShopifyAPI::Session.new(
      domain: 'http://localhost.myshopify.com',
      token: nil,
      api_version: any_api_version
    )
    fake(
      nil,
      url: 'https://localhost.myshopify.com/admin/oauth/access_token',
      method: :post,
      status: 404,
      body: '{"error" : "invalid_request"}'
    )
    assert_raises(ShopifyAPI::ValidationException) do
      session.request_token(code: "bad-code")
    end
    assert_equal false, session.valid?
  end

  test "return site for session" do
    session = ShopifyAPI::Session.new(
      domain: "testshop.myshopify.com",
      token: "any-token",
      api_version: any_api_version
    )
    assert_equal "https://testshop.myshopify.com", session.site
  end

  test "return_token_if_signature_is_valid" do
    api_version = any_api_version
    fake nil,
      url: "https://testshop.myshopify.com/admin/oauth/access_token",
      method: :post,
      body: '{"access_token":"any-token"}'
    session = ShopifyAPI::Session.new(domain: "testshop.myshopify.com", token: nil, api_version: api_version)

    params = { code: 'any-code', timestamp: Time.now }
    token = session.request_token(params.merge(hmac: generate_signature(params)))

    assert_equal "any-token", token
    assert_equal "any-token", session.token
  end

  test "extra parameters are stored in session" do
    api_version = ShopifyAPI::ApiVersion.new(handle: :unstable)
    fake nil,
      url: "https://testshop.myshopify.com/admin/oauth/access_token",
      method: :post,
      body: '{"access_token":"any-token","foo":"example"}'
    session = ShopifyAPI::Session.new(domain: "testshop.myshopify.com", token: nil, api_version: api_version)

    params = { code: 'any-code', timestamp: Time.now }
    assert session.request_token(params.merge(hmac: generate_signature(params)))

    assert_equal ({ "foo" => "example" }), session.extra
  end

  test "expires_in is automatically converted in expires_at" do
    api_version = any_api_version
    fake nil,
      url: "https://testshop.myshopify.com/admin/oauth/access_token",
      method: :post,
      body: '{"access_token":"any-token","expires_in":86393}'
    session = ShopifyAPI::Session.new(domain: "testshop.myshopify.com", token: nil, api_version: api_version)

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
    params = { :code => "any-code", :timestamp => Time.now }
    signature = generate_signature(params)
    params[:foo] = 'world'
    assert_raises(ShopifyAPI::ValidationException) do
      session = ShopifyAPI::Session.new(domain: "testshop.myshopify.com", token: nil, api_version: any_api_version)
      session.request_token(params.merge(:hmac => signature))
    end
  end

  test "raise error if timestamp is too old" do
    params = { :code => "any-code", :timestamp => Time.now - 2.days }
    signature = generate_signature(params)
    params[:foo] = 'world'
    assert_raises(ShopifyAPI::ValidationException) do
      session = ShopifyAPI::Session.new(domain: "testshop.myshopify.com", token: nil, api_version: any_api_version)
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

  test "url is aliased to domain to minimize the upgrade changes" do
    session = ShopifyAPI::Session.new(
      domain: "http://testshop.myshopify.com",
      token: "any-token",
      api_version: any_api_version
    )

    assert_equal('testshop.myshopify.com', session.url)
  end

  test "#hash returns the same value for equal Sessions" do
    session = ShopifyAPI::Session.new(
      domain: "http://testshop.myshopify.com",
      token: "any-token",
      api_version: '2019-01',
      extra: { foo: "bar" }
    )
    other_session = ShopifyAPI::Session.new(
      domain: "http://testshop.myshopify.com",
      token: "any-token",
      api_version: '2019-01',
      extra: { foo: "bar" }
    )
    assert_equal(session.hash, other_session.hash)
  end

  test "equality verifies domain" do
    session = ShopifyAPI::Session.new(
      domain: "http://testshop.myshopify.com",
      token: "any-token",
      api_version: '2019-01',
      extra: { foo: "bar" }
    )
    other_session = ShopifyAPI::Session.new(
      domain: "http://testshop.myshopify.com",
      token: "any-token",
      api_version: '2019-01',
      extra: { foo: "bar" }
    )
    different_session = ShopifyAPI::Session.new(
      domain: "http://another_testshop.myshopify.com",
      token: "any-token",
      api_version: '2019-01',
      extra: { foo: "bar" }
    )
    assert_equal(session, other_session)
    refute_equal(session, different_session)
  end

  test "equality verifies token" do
    session = ShopifyAPI::Session.new(
      domain: "http://testshop.myshopify.com",
      token: "any-token",
      api_version: '2019-01',
      extra: { foo: "bar" }
    )
    different_session = ShopifyAPI::Session.new(
      domain: "http://testshop.myshopify.com",
      token: "very-different-token",
      api_version: '2019-01',
      extra: { foo: "bar" }
    )
    refute_equal(session, different_session)
  end

  test "equality verifies api_version" do
    session = ShopifyAPI::Session.new(
      domain: "http://testshop.myshopify.com",
      token: "any-token",
      api_version: '2019-01',
      extra: { foo: "bar" }
    )
    different_session = ShopifyAPI::Session.new(
      domain: "http://testshop.myshopify.com",
      token: "any-token",
      api_version: :unstable,
      extra: { foo: "bar" }
    )
    refute_equal(session, different_session)
  end

  test "equality verifies extra" do
    session = ShopifyAPI::Session.new(
      domain: "http://testshop.myshopify.com",
      token: "any-token",
      api_version: '2019-01',
      extra: { foo: "bar" }
    )
    different_session = ShopifyAPI::Session.new(
      domain: "http://testshop.myshopify.com",
      token: "any-token",
      api_version: '2019-01',
      extra: { bar: "other-bar" }
    )
    refute_equal(session, different_session)
  end

  test "equality verifies other is a Session" do
    session = ShopifyAPI::Session.new(
      domain: "http://testshop.myshopify.com",
      token: "any-token",
      api_version: '2019-01',
      extra: { foo: "bar" }
    )
    different_session = nil
    refute_equal(session, different_session)
  end

  test "#eql? and #hash are implemented" do
    session = ShopifyAPI::Session.new(
      domain: "http://testshop.myshopify.com",
      token: "any-token",
      api_version: '2019-01',
      extra: { foo: "bar" }
    )
    other_session = ShopifyAPI::Session.new(
      domain: "http://testshop.myshopify.com",
      token: "any-token",
      api_version: '2019-01',
      extra: { foo: "bar" }
    )
    different_session = ShopifyAPI::Session.new(
      domain: "http://another_testshop.myshopify.com",
      token: "any-token",
      api_version: '2019-01',
      extra: { foo: "bar" }
    )

    assert_equal([session, different_session], [session, other_session, different_session].uniq)
  end

  private

  def make_sorted_params(params)
    params.with_indifferent_access.except(
      :signature, :hmac, :action, :controller
    ).collect { |k, v| "#{k}=#{v}" }.sort.join('&')
  end

  def generate_signature(params)
    params = make_sorted_params(params) if params.is_a?(Hash)
    OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('SHA256'), ShopifyAPI::Session.secret, params)
  end

  def any_api_version
    version_name = ['2019-01', :unstable].sample(1).first
    ShopifyAPI::ApiVersion.find_version(version_name)
  end
end
