module ShopifyAPI
  class RecurringApplicationCharge < Base
    undef_method :test

    def self.current
      find(:all).find{|charge| charge.status == 'active'}
    end
    
    def cancel
      load_attributes_from_response(self.destroy)
    end
    
    def activate
      load_attributes_from_response(post(:activate))
    end
  end
end
