module ShopifyAPI
  class RecurringApplicationCharge < Base
    undef_method :test
    
    class << self
      def current
        all.find { |c| c.status == 'active' }
      end
      
      def pending
        all.find { |c| c.status == 'pending' }
      end
      
      def cancelled
        all.find { |c| c.status == 'cancelled' }
      end
      
      def accepted
        all.find { |c| c.status == 'accepted' }
      end
      
      def declined
        all.find { |c| c.status == 'declined' }
      end
    end
    
    def cancel
      load_attributes_from_response(self.destroy)
    end
    
    def activate
      load_attributes_from_response(post(:activate))
    end
  end
end
