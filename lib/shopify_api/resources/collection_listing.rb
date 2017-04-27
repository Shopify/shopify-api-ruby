module ShopifyAPI
  class CollectionListing < Base
    def product_ids
      get("#{collection_id}/product_ids")
    end
  end
end
