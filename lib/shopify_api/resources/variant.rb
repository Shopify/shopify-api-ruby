# frozen_string_literal: true
module ShopifyAPI
  class Variant < Base
    include Metafields
    include DisablePrefixCheck

    conditional_prefix :product

    def initialize(*)
      super
      attributes.except!('old_inventory_quantity')
    end

    def inventory_quantity_adjustment=(new_value)
      raise_deprecated_inventory_call('inventory_quantity_adjustment')
      super
    end

    def inventory_quantity=(new_value)
      raise_deprecated_inventory_call('inventory_quantity')
      super
    end

    def old_inventory_quantity=(new_value)
      raise_deprecated_inventory_call('old_inventory_quantity')
      super
    end

    def save
      attributes.except!('inventory_quantity')
      super
    end

    private

    def raise_deprecated_inventory_call(parameter)
      raise(
        ShopifyAPI::ValidationException,
        "'#{parameter}' is deprecated - see https://help.shopify.com/en/api/guides/inventory-migration-guide",
      )
    end
  end
end
