# frozen_string_literal: true
module ShopifyAPI
  class ProductListing < Base
    self.primary_key = :product_id

    early_july_pagination_release!

    def self.product_ids
      ProductId.all
    end

    class ProductId < ArrayBase
      self.resource_prefix = 'product_listings/'
    end
    private_constant :ProductId
  end
end
