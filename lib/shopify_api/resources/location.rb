module ShopifyAPI
  class Location < Base

    def inventory_levels
      ShopifyAPI::InventoryLevel.find(:all, from: "/admin/locations/#{id}/inventory_levels.json")
    end
  end
end
