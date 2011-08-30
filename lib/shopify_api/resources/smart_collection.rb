module ShopifyAPI
  class SmartCollection < Base
    def products
      Product.find(:all, :params => {:collection_id => self.id})
    end
  end
end
