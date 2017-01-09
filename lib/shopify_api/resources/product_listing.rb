module ShopifyAPI
  class ProductListing < Base
    init_prefix :application

    def self.product_ids(options = {})
      get(:product_ids, options[:params])
    end
  end
end
