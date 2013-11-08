module ShopifyAPI
  class Customer < Base
    include Metafields

    def orders
      Order.find(:all, :params => {:customer_id => self.id})
    end

  end
end
