require 'test_helper'

class FulFillmentServiceTest < Test::Unit::TestCase
	test 'new should create fulfillment service' do
		fake "fulfillment_service", :method => :post
		fulfillment_service = ShopifyAPI::FulfillmentService.new(:name => "SomeService")
		assert_equal "SomeService" , fulfillment_service.name
	end

	test 'find should return the fulfillment service' do
		fake "fulfillment_service/123456.json", :method => :get, :body => load_fixture('fulfillment_service')
		fulfillment_service = ShopifyAPI::FulfillmentService.find(123456)
		assert_equal 123456 , fulfillment_service.id
		assert_equal "SomeService", fulfillment_service.name
	end
end