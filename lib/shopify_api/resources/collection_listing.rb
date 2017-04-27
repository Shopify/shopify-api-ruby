module ShopifyAPI
  class CollectionListing < Base
    self.primary_key = :collection_id

    def product_ids
      get(:product_ids)
    end
  end
end
