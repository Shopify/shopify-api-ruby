# frozen_string_literal: true
require 'test_helper'
require "active_support/log_subscriber/test_helper"

class BaseTest < Test::Unit::TestCase
  def setup
    super
    @session1 = ShopifyAPI::Session.new(domain: 'shop1.myshopify.com', token: 'token1', api_version: '2019-01')
    @session2 = ShopifyAPI::Session.new(domain: 'shop2.myshopify.com', token: 'token2', api_version: '2019-01')
  end

  def teardown
    super
    clear_header('X-Custom')
  end

  test '#activate_session should set site and headers for given session' do
    ShopifyAPI::Base.activate_session(@session1)

    assert_nil(ActiveResource::Base.site)
    assert_equal('https://shop1.myshopify.com', ShopifyAPI::Base.site.to_s)
    assert_equal('https://shop1.myshopify.com', ShopifyAPI::Shop.site.to_s)

    assert_nil(ActiveResource::Base.headers['X-Shopify-Access-Token'])
    assert_equal('token1', ShopifyAPI::Base.headers['X-Shopify-Access-Token'])
    assert_equal('token1', ShopifyAPI::Shop.headers['X-Shopify-Access-Token'])
  end

  test '#clear_session should clear base site settings from Base' do
    ShopifyAPI::Base.site = "https://foo:bar@www.zombo.com"

    assert_equal("foo", ShopifyAPI::Base.user)
    assert_equal("bar", ShopifyAPI::Base.password)

    ShopifyAPI::Base.clear_session

    assert_nil(ShopifyAPI::Base.user)
    assert_nil(ShopifyAPI::Base.password)
    assert_nil(ShopifyAPI::Base.site)
  end

  # test to  check session reset api version remains the same after session reset
  test '#clear_session should not change the api_version' do
    ShopifyAPI::Base.site = "https://zoo:lion@www.zoo.com"


    assert_equal("zoo", ShopifyAPI::Base.user)
    assert_equal("lion", ShopifyAPI::Base.password)

    ShopifyAPI::Base.clear_session

    assert_nil(ShopifyAPI::Base.user)
    assert_nil(ShopifyAPI::Base.password)
    assert_nil(ShopifyAPI::Base.site)
    assert_equal(ShopifyAPI::Base.api_version,@session1.api_version)
  end

  test '#clear_session should clear site and headers from Base' do
    ShopifyAPI::Base.activate_session(@session1)
    ShopifyAPI::Base.clear_session

    assert_nil(ActiveResource::Base.site)
    assert_nil(ShopifyAPI::Base.site)
    assert_nil(ShopifyAPI::Shop.site)

    assert_nil(ActiveResource::Base.headers['X-Shopify-Access-Token'])
    assert_nil(ShopifyAPI::Base.headers['X-Shopify-Access-Token'])
    assert_nil(ShopifyAPI::Shop.headers['X-Shopify-Access-Token'])
  end

  test '#activate_session with one session, then clearing and activating with another session should send request to correct shop' do
    ShopifyAPI::Base.activate_session(@session1)
    ShopifyAPI::Base.clear_session
    ShopifyAPI::Base.activate_session(@session2)

    assert_nil(ActiveResource::Base.site)
    assert_equal('https://shop2.myshopify.com', ShopifyAPI::Base.site.to_s)
    assert_equal('https://shop2.myshopify.com', ShopifyAPI::Shop.site.to_s)

    assert_nil(ActiveResource::Base.headers['X-Shopify-Access-Token'])
    assert_equal('token2', ShopifyAPI::Base.headers['X-Shopify-Access-Token'])
    assert_equal('token2', ShopifyAPI::Shop.headers['X-Shopify-Access-Token'])
  end

  test '#activate_session with nil raises an InvalidSessionError' do
    assert_raises(ShopifyAPI::Base::InvalidSessionError) do
      ShopifyAPI::Base.activate_session(nil)
    end
  end

  test "#delete should send custom headers with request" do
    ShopifyAPI::Base.activate_session(@session1)
    ShopifyAPI::Base.headers['X-Custom'] = 'abc'
    ShopifyAPI::Base.connection
      .expects(:delete)
      .with('/admin/api/2019-01/bases/1.json', has_entry('X-Custom', 'abc'))
    ShopifyAPI::Base.delete("1")
  end

  test "#headers includes the User-Agent" do
    assert_not_includes ActiveResource::Base.headers.keys, 'User-Agent'
    assert_includes(ShopifyAPI::Base.headers.keys, 'User-Agent')
    thread = Thread.new do
      assert_includes(ShopifyAPI::Base.headers.keys, 'User-Agent')
    end
    thread.join
  end

  test "prefix= will forward to resource when the value does not start with admin" do
    session = ShopifyAPI::Session.new(domain: 'shop1.myshopify.com', token: 'token1', api_version: '2019-01')
    ShopifyAPI::Base.activate_session(session)
    silence_warnings do
      TestResource.prefix = 'a/regular/path/'
    end

    assert_equal('/admin/api/2019-01/a/regular/path/', TestResource.prefix)
  end

  test "prefix= will raise an error if value starts with with /admin" do
    assert_raises(ArgumentError) do
      TestResource.prefix = '/admin/old/prefix/structure/'
    end
  end

  test "#headers propagates changes to subclasses" do
    ShopifyAPI::Base.headers['X-Custom'] = "the value"
    assert_equal("the value", ShopifyAPI::Base.headers['X-Custom'])
    assert_equal("the value", ShopifyAPI::Product.headers['X-Custom'])
  end

  test "#headers clears changes to subclasses" do
    ShopifyAPI::Base.headers['X-Custom'] = "the value"
    assert_equal("the value", ShopifyAPI::Product.headers['X-Custom'])
    ShopifyAPI::Base.headers['X-Custom'] = nil
    assert_nil(ShopifyAPI::Product.headers['X-Custom'])
  end

  test "#headers set in the main thread affect spawned threads" do
    ShopifyAPI::Base.headers['X-Custom'] = "the value"
    Thread.new do
      assert_equal("the value", ShopifyAPI::Base.headers['X-Custom'])
    end.join
  end

  test "#headers set in spawned threads do not affect the main thread" do
    Thread.new do
      ShopifyAPI::Base.headers['X-Custom'] = "the value"
    end.join
    assert_nil(ShopifyAPI::Base.headers['X-Custom'])
  end

  test "using a different version changes the url" do
    release_2019_01 = ShopifyAPI::Session.new(domain: 'shop1.myshopify.com', token: 'token1', api_version: '2019-01')
    unstable_version = ShopifyAPI::Session.new(domain: 'shop2.myshopify.com', token: 'token2', api_version: :unstable)

    fake(
      "shop",
      url: "https://shop1.myshopify.com/admin/api/2019-01/shop.json",
      method: :get,
      status: 201,
      body: '{ "shop": { "id": 1 } }'
    )
    fake(
      "shop",
      url: "https://shop2.myshopify.com/admin/api/unstable/shop.json",
      method: :get,
      status: 201,
      body: '{ "shop": { "id": 2 } }'
    )

    ShopifyAPI::Base.activate_session(release_2019_01)
    assert_equal(1, ShopifyAPI::Shop.current.id)

    ShopifyAPI::Base.activate_session(unstable_version)
    assert_equal(2, ShopifyAPI::Shop.current.id)
  end

  test "#api_version= should set ApiVersion" do
    ShopifyAPI::Base.api_version = '2019-04'
    assert_equal('2019-04', ShopifyAPI::Base.api_version.to_s)
  end

  test "#api_version= nil should set ApiVersion to ShopifyAPI::ApiVersion::NullVersion" do
    ShopifyAPI::Base.api_version = nil
    assert_equal(ShopifyAPI::ApiVersion::NullVersion, ShopifyAPI::Base.api_version)
  end

  test "#api_version= ShopifyAPI::ApiVersion::NullVersion should set ApiVersion to ShopifyAPI::ApiVersion::NullVersion" do
    ShopifyAPI::Base.api_version = ShopifyAPI::ApiVersion::NullVersion
    assert_equal(ShopifyAPI::ApiVersion::NullVersion, ShopifyAPI::Base.api_version)
  end

  test "#version_validation! does not raise is api_version is newer or equal to minimum supported version" do
    ShopifyAPI::Base.api_version = '2020-01'
    assert_nil(ShopifyAPI::Base::version_validation!('2020-01'))
  end

  test "#version_validation! raises NotImplemetedError if api_version is older than minimum supported version" do
    ShopifyAPI::Base.api_version = '2019-10'
    exception = assert_raises(NotImplementedError) do
      ShopifyAPI::Base::version_validation!('2020-01')
    end
    assert_equal('The minimum supported version is 2020-01.', exception.message)
  end


  def clear_header(header)
    [ActiveResource::Base, ShopifyAPI::Base, ShopifyAPI::Product].each do |klass|
      klass.headers.delete(header)
    end
  end

  class TestResource < ShopifyAPI::Base
  end
end
