module ShopifyAPI
  class SmartCollection < Base
    include Events
    include Metafields

    def products
      Product.find(:all, :params => {:collection_id => self.id})
    end
  end
end
