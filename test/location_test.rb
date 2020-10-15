require 'test_helper'

class LocationTest < Test::Unit::TestCase
  test '#inventory_levels returns all inventory_levels associated with this location' do
    location = ShopifyAPI::Location.new(id: 487838322)
    expected_body = JSON.parse(load_fixture('inventory_levels'))
    expected_body['inventory_levels'].delete_if { |level| level['location_id'] != location.id }
    fake "locations/#{location.id}/inventory_levels", method: :get, status: 200, body: JSON(expected_body).to_s
    inventory_levels = location.inventory_levels

    assert inventory_levels.all? { |item| item.location_id == location.id },
           message: 'Response contained locations other than the current location.'
  end
end
