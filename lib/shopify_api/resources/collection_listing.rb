module ShopifyAPI
  class CollectionListing < Base
    init_prefix :application

    def product_ids(options = {})
      get("#{collection_id}/product_ids", options[:params])
    end
  end
end
