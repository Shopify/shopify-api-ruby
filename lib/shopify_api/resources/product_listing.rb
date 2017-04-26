module ShopifyAPI
  class ProductListing < Base
    def self.product_ids
      get(:product_ids)
    end
  end
end
