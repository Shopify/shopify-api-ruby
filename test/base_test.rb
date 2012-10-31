require 'test_helper'


class BaseTest < Test::Unit::TestCase

  def setup
    @session1 = ShopifyAPI::Session.new('shop1.myshopify.com', 'token1')
    @session2 = ShopifyAPI::Session.new('shop2.myshopify.com', 'token2')
  end

  test '#activate_session should set site and headers for given session' do
    ShopifyAPI::Base.activate_session @session1

    assert_nil ActiveResource::Base.site
    assert_equal 'https://shop1.myshopify.com/admin', ShopifyAPI::Base.site.to_s
    assert_equal 'https://shop1.myshopify.com/admin', ShopifyAPI::Shop.site.to_s
    
    assert_nil ActiveResource::Base.headers['X-Shopify-Access-Token']
    assert_equal 'token1', ShopifyAPI::Base.headers['X-Shopify-Access-Token']
    assert_equal 'token1', ShopifyAPI::Shop.headers['X-Shopify-Access-Token']
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
    assert_equal 'https://shop2.myshopify.com/admin', ShopifyAPI::Base.site.to_s
    assert_equal 'https://shop2.myshopify.com/admin', ShopifyAPI::Shop.site.to_s

    assert_nil ActiveResource::Base.headers['X-Shopify-Access-Token']
    assert_equal 'token2', ShopifyAPI::Base.headers['X-Shopify-Access-Token']
    assert_equal 'token2', ShopifyAPI::Shop.headers['X-Shopify-Access-Token']
  end

  test "#delete should send custom headers with request" do
    ShopifyAPI::Base.activate_session @session1
    ShopifyAPI::Base.expects(:headers).returns({'X-Custom' => 'abc'})
    ShopifyAPI::Base.connection.expects(:delete).with('/admin/bases/1.json', {'X-Custom' => 'abc'})
    ShopifyAPI::Base.delete "1"
  end

  test "#build should send custom headers with request" do
    ShopifyAPI::Base.activate_session @session1
    ShopifyAPI::Base.expects(:headers).returns({'X-Custom' => 'abc'})
    ShopifyAPI::Base.connection.expects(:delete).with('/admin/bases/1.json', {'X-Custom' => 'abc'})
    ShopifyAPI::Base.delete "1"
  end

end
