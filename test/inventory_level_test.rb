# frozen_string_literal: true
require 'test_helper'

class InventoryLevelTest < Test::Unit::TestCase
  def setup
    super
    @inventory_level_response = ActiveSupport::JSON.decode(load_fixture('inventory_level'))
    @inventory_level = ShopifyAPI::InventoryLevel.new(@inventory_level_response['inventory_level'])
  end

  test ".find with inventory_item_ids and location_ids returns expected inventory levels" do
    params = { inventory_item_ids: [808950810, 39072856], location_ids: [905684977, 487838322] }
    fake(
      "inventory_levels.json?#{params.to_param}",
      extension: false,
      method: :get,
      status: 200,
      body: load_fixture('inventory_levels')
    )
    inventory_levels = ShopifyAPI::InventoryLevel.find(:all, params: params)

    assert(
      inventory_levels.all? { |item|
        params[:location_ids].include?(item.location_id) &&
        params[:inventory_item_ids].include?(item.inventory_item_id)
      },
      message: 'Response contained inventory_items or locations not requested.'
    )
  end

  test '#adjust with adjustment value returns inventory_level with available increased by adjustment value' do
    adjustment = 5
    updated_available = @inventory_level.available + adjustment
    @inventory_level_response[:available] = updated_available

    fake('inventory_levels/adjust', method: :post, body: ActiveSupport::JSON.encode(@inventory_level_response))
    @inventory_level.adjust(adjustment)
    assert_equal(updated_available, @inventory_level.available)
  end

  test '#connect saves an inventory_level associated with inventory_item and location_id' do
    params = { inventory_item_id: 808950810, location_id: 99999999 }
    response = params.clone
    response[:available] = 0

    fake('inventory_levels/connect', method: :post, body: ActiveSupport::JSON.encode(response))
    inventory_level = ShopifyAPI::InventoryLevel.new(params)
    inventory_level.connect
    assert_equal(0, inventory_level.available, message: 'expected newly connected location to have 0 inventory')
  end

  test '#destroy removes inventory_level and returns nil' do
    params = { inventory_item_id: @inventory_level.inventory_item_id, location_id: @inventory_level.location_id }
    fake("inventory_levels.json?#{params.to_param}", extension: false, method: :delete, status: 204, body: nil)
    assert_nil(@inventory_level.destroy)
  end

  test '#set with available value returns inventory_level with available as the available value' do
    available = 13
    response = @inventory_level_response.clone
    response['inventory_level']['available'] = available

    fake('inventory_levels/set', method: :post, body: ActiveSupport::JSON.encode(response))
    @inventory_level.set(available)

    assert_equal(available, @inventory_level.available)
  end
end
