# frozen_string_literal: true
module ShopifyAPI
  class Variant < Base
    include Metafields
    include DisablePrefixCheck

    conditional_prefix :product

    def initialize(*)
      super
      unless allow_inventory_params?
        attributes.except!('inventory_quantity_adjustment', 'inventory_quantity', 'old_inventory_quantity')
      end
    end

    def inventory_quantity_adjustment=(new_value)
      raise_deprecated_inventory_call('inventory_quantity_adjustment') unless allow_inventory_params?
      super
    end

    def inventory_quantity=(new_value)
      raise_deprecated_inventory_call('inventory_quantity') unless allow_inventory_params?
      super
    end

    def old_inventory_quantity=(new_value)
      raise_deprecated_inventory_call('old_inventory_quantity') unless allow_inventory_params?
      super
    end

    private

    def raise_deprecated_inventory_call(parameter)
      raise(ShopifyAPI::ValidationException,
        "'#{parameter}' is deprecated - see https://help.shopify.com/en/api/guides/inventory-migration-guide",
        )
    end

    def allow_inventory_params?
      Base.api_version < ApiVersion.find_version('2019-10')
    end
  end
end
