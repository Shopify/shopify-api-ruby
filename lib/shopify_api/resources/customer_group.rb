module ShopifyAPI
  class CustomerGroup < Base

    def customers
      Customers.find(:all, :params => {:customer_group_id => self.id})
    end
    
  end
end
