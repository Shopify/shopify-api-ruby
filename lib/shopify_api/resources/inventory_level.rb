# frozen_string_literal: true

module ShopifyAPI
  class InventoryLevel < Base
    # The default path structure in ActiveResource for delete would result in:
    # /admin/api/<version>/inventory_levels/#{ inventory_level.id }.json?#{ params }, but since
    # InventoryLevels are a second class resource made up of a Where and a What
    # (Location and InventoryItem), it does not have a resource ID. Here we
    # redefine element_path to remove the id so HTTP DELETE requests go to
    # /admin/api/<version>/inventory_levels.json?#{ params } instead.
    #
    def self.element_path(prefix_options = {}, query_options = nil)
      prefix_options, query_options = split_options(prefix_options) if query_options.nil?
      "#{prefix(prefix_options)}#{collection_name}.#{format.extension}#{query_string(query_options)}"
    end

    def destroy
      load_attributes_from_response(
        self.class.delete('/', location_id: location_id, inventory_item_id: inventory_item_id)
      )
    end

    def connect(relocate_if_necessary: nil)
      body = { location_id: location_id, inventory_item_id: inventory_item_id }
      body[:relocate_if_necessary] = relocate_if_necessary unless relocate_if_necessary.nil?
      load_attributes_from_response(
        self.class.post(:connect, {}, body.to_json)
      )
    end

    def set(new_available, disconnect_if_necessary: nil)
      body = {
        location_id: location_id,
        inventory_item_id: inventory_item_id,
        available: new_available,
      }
      body[:disconnect_if_necessary] = disconnect_if_necessary unless disconnect_if_necessary.nil?
      load_attributes_from_response(
        self.class.post(:set, {}, body.to_json)
      )
    end

    def adjust(available_adjustment)
      body = {
        location_id: location_id,
        inventory_item_id: inventory_item_id,
        available_adjustment: available_adjustment,
      }
      load_attributes_from_response(
        self.class.post(:adjust, {}, body.to_json)
      )
    end
  end
end
