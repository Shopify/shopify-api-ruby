require 'test_helper'
require "active_support/log_subscriber/test_helper"

class LogSubscriberTest < Test::Unit::TestCase
  include ActiveSupport::LogSubscriber::TestHelper

  def setup
    super
    @page = { :page => { :id => 1, :title => 'Shopify API' } }.to_json

    ShopifyAPI::Base.site = "http://localhost/admin"

    ActiveResource::LogSubscriber.attach_to :active_resource
    ActiveResource::DetailedLogSubscriber.attach_to :active_resource_detailed
  end

  def set_logger(logger)
    ActiveResource::Base.logger = logger
  end

  test "logging on #find" do
    fake "pages/1", :method => :get, :body => @page

    ShopifyAPI::Page.find(1)

    assert_equal 4, @logger.logged(:info).size
    assert_equal "GET http://localhost:80/admin/pages/1.json",                  @logger.logged(:info)[0]
    assert_match /\-\-\> 200/,                                                  @logger.logged(:info)[1]
    assert_equal "Headers: {\"Accept\"=>\"application/json\"}",                 @logger.logged(:info)[2]
    assert_equal "Response:\n{\"page\":{\"title\":\"Shopify API\",\"id\":1}}",  @logger.logged(:info)[3]
  end

  test "logging on #find with an error" do
    fake "pages/2", :method => :get, :body => nil, :status => 404

    assert_raise ActiveResource::ResourceNotFound do
      ShopifyAPI::Page.find(2)
    end

    assert_equal 4, @logger.logged(:info).size
    assert_equal "GET http://localhost:80/admin/pages/2.json",  @logger.logged(:info)[0]
    assert_match /\-\-\> 404/,                                  @logger.logged(:info)[1]
    assert_equal "Headers: {\"Accept\"=>\"application/json\"}", @logger.logged(:info)[2]
    assert_equal "Response:",                                   @logger.logged(:info)[3]
  end
end
