module ShopifyAPI
  class Customer < Base
    include Metafields

    def orders(options = {}); load_attributes_from_response(get(:orders, options)); end
    
    class DefaultAddress < Base
    end
  end
end
