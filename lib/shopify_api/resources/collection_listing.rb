# frozen_string_literal: true
module ShopifyAPI
  class CollectionListing < Base
    self.primary_key = :collection_id

    early_july_pagination_release!

    def product_ids
      ProductId.all(params: { collection_id: collection_id })
    end

    class ProductId < ArrayBase
      self.resource_prefix = 'collection_listings/:collection_id/'

      early_july_pagination_release!
    end
    private_constant :ProductId
  end
end
