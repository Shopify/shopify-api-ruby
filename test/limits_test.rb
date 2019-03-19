require 'test_helper'

class LimitsTest < Test::Unit::TestCase
  def setup
    super
    @header_hash = { 'X-Shopify-Shop-Api-Call-Limit' => '100/300' }
    ShopifyAPI::Base.connection.expects(:response).at_least(0).returns(@header_hash)
  end

  context "Limits" do
    should "fetch limit total" do
      assert_equal(299, ShopifyAPI.credit_limit(:shop))
    end

    should "fetch used calls" do
      assert_equal(100, ShopifyAPI.credit_used(:shop))
    end

    should "calculate remaining calls" do
      assert_equal(199, ShopifyAPI.credit_left)
    end

    should "flag maxed out credits" do
      assert !ShopifyAPI.maxed?
      @header_hash = { 'X-Shopify-Shop-Api-Call-Limit' => '299/300' }
      ShopifyAPI::Base.connection.expects(:response).at_least(1).returns(@header_hash)
      assert ShopifyAPI.maxed?
    end

    should "raise error when header doesn't exist" do
      @header_hash = {}
      ShopifyAPI::Base.connection.expects(:response).at_least(1).returns(@header_hash)
      assert_raises ShopifyAPI::Limits::LimitUnavailable do
        ShopifyAPI.credit_left
      end
    end
  end
end
