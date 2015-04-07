module ShopifyAPI
  class Product < Base
    include Events
    include Metafields

    # compute the price range
    def price_range
      prices = variants.collect(&:price).collect(&:to_f)
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

    def self.search(params)
      products = self.all
      result = []
      products.each do |product|
        meets_criteria = true
        temp = product.as_json
        params.each do |key, value|
          if !temp[key.to_s].nil?
            if temp[key.to_s] != value.to_s
              meets_criteria = false
            end
          else
            product.variants.each do |variant|
              v_temp = variant.as_json
              params.each do |v_key, v_value|
                if !v_temp[v_key.to_s].nil?
                  if v_temp[v_key.to_s] != v_value.to_s
                    meets_criteria = false
                  end
                end
              end
            end
          end
        end

        if meets_criteria
          result << product
        end
      end

      return result
    end
  end
end
