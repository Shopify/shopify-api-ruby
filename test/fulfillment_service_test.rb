require 'test_helper'
class FulfillmentServiceTest < Test::Unit::TestCase

  def test_create_fulfillment_service
    fake "fulfillment_services", :method => :post, :status => 202, :body => load_fixture('fulfillment_service')
    fulfillment_service = ShopifyAPI::FulfillmentService.create(:title => "Fulfillment")
    assert_equal '{"fulfillment_service":{"title":"Fulfillment"}}', FakeWeb.last_request.body
  end

  def test_get_fulfillment_services
    fake "fulfillment_services", :method => :get, :body => load_fixture('fulfillment_services')
    fulfillment_services = ShopifyAPI::FulfillmentService.all
    assert_equal 1, fulfillment_services.length
  end

end
