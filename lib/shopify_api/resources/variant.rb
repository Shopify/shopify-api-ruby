module ShopifyAPI
  class Variant < Base
    include Metafields
    include DisablePrefixCheck

    conditional_prefix :product
    
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

    def serializable_hash(options = {})
      if allow_inventory_params?
        super(options)
      else
        super(options).tap do |resource|
          (resource['variant'] || resource).except!('inventory_quantity', 'old_inventory_quantity')
        end
      end
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
