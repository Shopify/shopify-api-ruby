module ShopifyAPI
  class ProductListing < Base
    self.primary_key = :product_id

    early_july_pagination_release!

    def self.product_ids
      get(:product_ids)
    end
  end
end
