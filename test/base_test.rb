require 'test_helper'


class BaseTest < Test::Unit::TestCase

  def setup
    @session1 = ShopifyAPI::Session.new('shop1.myshopify.com', 'token1')
    @session2 = ShopifyAPI::Session.new('shop2.myshopify.com', 'token2')
  end

  def teardown
    clear_header('X-Custom')
  end

  test '#activate_session should set site and headers for given session' do
    ShopifyAPI::Base.activate_session @session1

    assert_nil ActiveResource::Base.site
    assert_equal 'https://shop1.myshopify.com', ShopifyAPI::Base.site.to_s
    assert_equal 'https://shop1.myshopify.com', ShopifyAPI::Shop.site.to_s

    assert_nil ActiveResource::Base.headers['X-Shopify-Access-Token']
    assert_equal 'token1', ShopifyAPI::Base.headers['X-Shopify-Access-Token']
    assert_equal 'token1', ShopifyAPI::Shop.headers['X-Shopify-Access-Token']
  end

  test '#clear_session should clear base site settings from Base' do
    ShopifyAPI::Base.site = "https://foo:bar@www.zombo.com"

    assert_equal "foo", ShopifyAPI::Base.user
    assert_equal "bar", ShopifyAPI::Base.password

    ShopifyAPI::Base.clear_session

    assert_equal nil, ShopifyAPI::Base.user
    assert_equal nil, ShopifyAPI::Base.password
    assert_equal nil, ShopifyAPI::Base.site
  end

  test '#clear_session should clear site and headers from Base' do
    ShopifyAPI::Base.activate_session @session1
    ShopifyAPI::Base.clear_session

    assert_nil ActiveResource::Base.site
    assert_nil ShopifyAPI::Base.site
    assert_nil ShopifyAPI::Shop.site

    assert_nil ActiveResource::Base.headers['X-Shopify-Access-Token']
    assert_nil ShopifyAPI::Base.headers['X-Shopify-Access-Token']
    assert_nil ShopifyAPI::Shop.headers['X-Shopify-Access-Token']
  end

  test '#activate_session with one session, then clearing and activating with another session should send request to correct shop' do
    ShopifyAPI::Base.activate_session @session1
    ShopifyAPI::Base.clear_session
    ShopifyAPI::Base.activate_session @session2

    assert_nil ActiveResource::Base.site
    assert_equal 'https://shop2.myshopify.com', ShopifyAPI::Base.site.to_s
    assert_equal 'https://shop2.myshopify.com', ShopifyAPI::Shop.site.to_s

    assert_nil ActiveResource::Base.headers['X-Shopify-Access-Token']
    assert_equal 'token2', ShopifyAPI::Base.headers['X-Shopify-Access-Token']
    assert_equal 'token2', ShopifyAPI::Shop.headers['X-Shopify-Access-Token']
  end

  test '#activate_session with nil raises an InvalidSessionError' do
    assert_raises ShopifyAPI::Base::InvalidSessionError do
      ShopifyAPI::Base.activate_session nil
    end
  end

  test "#delete should send custom headers with request" do
    ShopifyAPI::Base.activate_session @session1
    ShopifyAPI::Base.headers['X-Custom'] = 'abc'
    ShopifyAPI::Base.connection.expects(:delete).with('/admin/bases/1.json', has_entry('X-Custom', 'abc'))
    ShopifyAPI::Base.delete "1"
  end

  test "#headers includes the User-Agent" do
    assert_not_includes ActiveResource::Base.headers.keys, 'User-Agent'
    assert_includes ShopifyAPI::Base.headers.keys, 'User-Agent'
    thread = Thread.new do
      assert_includes ShopifyAPI::Base.headers.keys, 'User-Agent'
    end
    thread.join
  end

  if ActiveResource::VERSION::MAJOR >= 4
    test "#headers propagates changes to subclasses" do
      ShopifyAPI::Base.headers['X-Custom'] = "the value"
      assert_equal "the value", ShopifyAPI::Base.headers['X-Custom']
      assert_equal "the value", ShopifyAPI::Product.headers['X-Custom']
    end

    test "#headers clears changes to subclasses" do
      ShopifyAPI::Base.headers['X-Custom'] = "the value"
      assert_equal "the value", ShopifyAPI::Product.headers['X-Custom']
      ShopifyAPI::Base.headers['X-Custom'] = nil
      assert_nil ShopifyAPI::Product.headers['X-Custom']
    end
  end

  if ActiveResource::VERSION::MAJOR >= 5 || (ActiveResource::VERSION::MAJOR >= 4 && ActiveResource::VERSION::PRE == "threadsafe")
    test "#headers set in the main thread affect spawned threads" do
      ShopifyAPI::Base.headers['X-Custom'] = "the value"
      Thread.new do
        assert_equal "the value", ShopifyAPI::Base.headers['X-Custom']
      end.join
    end

    test "#headers set in spawned threads do not affect the main thread" do
      Thread.new do
        ShopifyAPI::Base.headers['X-Custom'] = "the value"
      end.join
      assert_nil ShopifyAPI::Base.headers['X-Custom']
    end
  end

  def clear_header(header)
    [ActiveResource::Base, ShopifyAPI::Base, ShopifyAPI::Product].each do |klass|
      klass.headers.delete(header)
    end
  end
end
