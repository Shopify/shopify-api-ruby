module ShopifyAPI
  # Custom collection
  #
  class CustomCollection < Base
    def products
      Product.find(:all, :params => {:collection_id => self.id})
    end
    
    def add_product(product)
      Collect.create(:collection_id => self.id, :product_id => product.id)
    end
    
    def remove_product(product)
      collect = Collect.find(:first, :params => {:collection_id => self.id, :product_id => product.id})
      collect.destroy if collect
    end
  end                                                                 
end
