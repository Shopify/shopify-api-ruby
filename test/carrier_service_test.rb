require 'test_helper'

class CarrierServiceTest < Test::Unit::TestCase
  test 'new should create carrier service' do
    fake("carrier_services", method: :post, body: load_fixture('carrier_service'))
    carrier_service = ShopifyAPI::CarrierService.new(name: "Some Postal Service")
    carrier_service.save
    assert_equal("Some Postal Service", carrier_service.name)
  end

  test 'find should return the carrier service' do
    fake("carrier_services/123456", method: :get, body: load_fixture('carrier_service'))
    carrier_service = ShopifyAPI::CarrierService.find(123456)
    assert_equal(123456, carrier_service.id)
    assert_equal("Some Postal Service", carrier_service.name)
  end
end
