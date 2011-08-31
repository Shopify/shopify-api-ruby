module ShopifyAPI
  class Product < Base
    include Events
    include Metafields

    # compute the price range
    def price_range
      prices = variants.collect(&:price)
      format =  "%0.2f"
      if prices.min != prices.max
        "#{format % prices.min} - #{format % prices.max}"
      else
        format % prices.min
      end
    end
    
    def collections
      CustomCollection.find(:all, :params => {:product_id => self.id})
    end
    
    def smart_collections
      SmartCollection.find(:all, :params => {:product_id => self.id})
    end
    
    def add_to_collection(collection)
      collection.add_product(self)
    end
    
    def remove_from_collection(collection)
      collection.remove_product(self)
    end
  end
end
