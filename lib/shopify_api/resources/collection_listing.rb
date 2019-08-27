module ShopifyAPI
  class CollectionListing < Base
    self.primary_key = :collection_id

    early_july_pagination_release!

    def product_ids
      get(:product_ids)
    end
  end
end
