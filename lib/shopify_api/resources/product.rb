# frozen_string_literal: true
module ShopifyAPI
  class Product < Base
    include Events
    include Metafields

    early_july_pagination_release!

    def initialize(*)
      super
      self.attributes.except!('total_inventory') unless allow_inventory_params?
    end

    # compute the price range
    def price_range
      prices = variants.collect(&:price).collect(&:to_f)
      format = "%0.2f"
      if prices.min != prices.max
        "#{format % prices.min} - #{format % prices.max}"
      else
        format % prices.min
      end
    end

    def total_inventory=(new_value)
      raise_deprecated_inventory_call('total_inventory') unless allow_inventory_params?
      super
    end

    def collections
      CustomCollection.find(:all, params: { product_id: self.id })
    end

    def smart_collections
      SmartCollection.find(:all, params: { product_id: self.id })
    end

    def add_to_collection(collection)
      collection.add_product(self)
    end

    def remove_from_collection(collection)
      collection.remove_product(self)
    end

    private

    def raise_deprecated_inventory_call(parameter)
      raise(
        ShopifyAPI::ValidationException,
        "'#{parameter}' is deprecated - see https://help.shopify.com/en/api/guides/inventory-migration-guide",
      )
    end

    def allow_inventory_params?
      Base.api_version < ApiVersion.find_version('2019-10')
    end
  end
end
