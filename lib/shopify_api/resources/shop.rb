module ShopifyAPI
  # Shop object. Use Shop.current to receive 
  # the shop.
  class Shop < Base
    def self.current
      find(:one, from: "/admin/shop.#{format.extension}")
    end

    def metafields
      Metafield.find(:all)
    end
    
    def add_metafield(metafield)
      raise ArgumentError, "You can only add metafields to resource that has been saved" if new?      
      metafield.save
      metafield
    end
    
    def events
      Event.find(:all)
    end
  end               
end
