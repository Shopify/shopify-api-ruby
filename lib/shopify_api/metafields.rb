# frozen_string_literal: true
module ShopifyAPI
  module Metafields
    def metafields(**options)
      options.merge!(resource: self.class.collection_name, resource_id: id)

      Metafield.find(:all, params: options)
    end

    def add_metafield(metafield)
      raise ArgumentError, "You can only add metafields to resource that has been saved" if new?

      metafield.prefix_options = {
        resource: self.class.collection_name,
        resource_id: id,
      }
      metafield.save
      metafield
    end
  end
end
