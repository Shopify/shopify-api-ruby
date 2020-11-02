# frozen_string_literal: true
module ShopifyAPI
  class Location < Base
    def inventory_levels
      ShopifyAPI::InventoryLevel.find(:all, from: "#{self.class.prefix}locations/#{id}/inventory_levels.json")
    end
  end
end
